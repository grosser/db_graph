gem 'gchartrb'
require 'google_chart'

module DBGraph
  class Line
    NUM_Y_LABELS = 10
    
    attr_accessor :data
    
    def initialize(style, options={})
      @style = style.to_sym
      @options = options
      self.data = {}
    end

    def add(model, attribute, options={})
      label = options.delete(:label) || "#{model} #{attribute}"
      data[label] = count(model, attribute, options)
    end

    def count(model, attribute, options={})
      scope = if @options[:at]
        start, ende = interval_for(@options[:at])
        model.scoped(:conditions=>["#{attribute} BETWEEN ? AND ?", start, ende]).scoped(options)
      else
        model.scoped(options)
      end
      data_type = @style.to_s.sub(/s$/,'').upcase
      scope.count(:group=>"#{data_type}(#{attribute})")
    end

    def to_url
      size = @options[:size] || '600x500'
      GoogleChart::LineChart.new(size, nil, false) do |line|
        for name, hash in data
          line.data(name, self.class.filled_and_sorted_values(hash, x_values), random_color)
        end
        line.axis :x, :labels => x_labels
        line.axis :y, :labels => y_labels
        line.show_legend = (@options[:show_legend]!=false)
      end.to_url
    end

    def x_labels
      case @style
      when :days then x_values.map{|x|x%5==0 ? x : ''}
      when :weeks, :minutes then x_values.map{|x|x%10==0 ? x : ''}
      else x_values
      end
    end

    def y_labels
      values = []
      data.each{|name,hash|values += self.class.filled_and_sorted_values(hash, x_values)}
      distribute_evently(values, NUM_Y_LABELS)
    end

    def self.url(style, model, attribute, options={})
      g = self.new(style, :at=>options.delete(:at))
      g.add model, attribute, options
      g.to_url
    end

    private

    def x_values
      case @style
      when :minutes then 0..59
      when :hours then 0..23
      when :days then 1..31
      when :weeks then 0..52 #week 0 == week 52 of last year, e.g. in 2009-01-01
      when :months then 1..12
      else raise "#{@style} is not supported"
      end.to_a
    end

    def random_color
      [1,2,3].map{ (('0'..'9').to_a + ('a'..'f').to_a)[rand(16)] * 2 } * ''
    end
    
    def interval_for(time)
      interval_word = {:minutes=>:hour,:hours=>:day,:days=>:month,:weeks=>:year,:months=>:year}[@style]
      raise "style #{@style} is not supported" unless interval_word

      start = self.class.at_beginning_of_interval(time, interval_word)
      ende = start + 1.send(interval_word) - 1.second
      [start, ende]
    end

    def self.at_beginning_of_interval(time, interval_type)
      #simple substraction does not (seem) to work for long intervals (summer/winter time ?)
      #and at_beginning_of_hour is not defined
      if [:year, :month, :week, :day].include? interval_type
        time.to_date.send("at_beginning_of_#{interval_type}")
      else
        time - (time.to_i % 1.send(interval_type))
      end
    end

    def self.filled_and_sorted_values(values, keys)
      array = fill_up_values(values, keys)
      array.sort.map(&:last)
    end

    #values is array or hash with integer or string keys
    def self.fill_up_values(values, expected_keys)
      values = values.map{|k,v| [k.to_i, v]}
      expected_keys.each{|k| values += [[k,0]] unless values.assoc(k)}
      values.sort
    end

    def distribute_evently(values, num_steps)
      min = values.min
      max = values.max
      step = (max-min) / (num_steps-1).to_f
      (0...num_steps).map{|i| (step*i + min).to_f.round}
    end
  end
end
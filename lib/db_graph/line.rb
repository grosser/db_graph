require 'google_chart'

module DBGraph
  class Line
    NUM_Y_LABELS = 10
    
    attr_accessor :data
    
    def initialize(style, options={})
      @style = style
      @options = options
      self.data = ActiveSupport::OrderedHash.new
    end

    def add(model, attribute)
      data["#{model} #{attribute}"] = count(model, attribute)
    end

    def count(model, attribute)
      scope = if @options[:at]
        start = @options[:at].to_date
        ende = start + 1.day - 1.second
        model.scoped(:conditions=>["#{attribute} BETWEEN ? AND ?", start, ende])
      else
        model
      end
      scope.count(:group=>"HOUR(#{attribute})")
    end

    def to_url
      size = @options[:size] || '600x500'
      GoogleChart::LineChart.new(size, nil, false) do |line|
        for name, hash in data
          line.data(name, self.class.filled_and_sorted_values(hash, x_labels))
        end
        line.axis :x, :labels => x_labels
        line.axis :y, :labels => y_labels
      end.to_url
    end

    def x_labels
      case @style
      when :hours then (0..23).to_a
      end
    end

    def y_labels
      values = []
      data.each{|name,hash|values += self.class.filled_and_sorted_values(hash, x_labels)}
      distribute_evently(values, NUM_Y_LABELS)
    end

    private

    def self.filled_and_sorted_values(hash, keys)
      hash = fill_up_values(hash, keys)
      hash.sort.map{|k,v|v}
    end

    def self.fill_up_values(hash, expected_keys)
      hash = hash.dup
      expected_keys.each{|k|hash[k.to_s] ||= 0}
      hash
    end

    def distribute_evently(values, num_steps)
      min = values.min
      max = values.max
      step = (max-min) / (num_steps-1).to_f
      (0...num_steps).map{|i| (step*i + min).to_f.round}
    end
  end
end
require 'rubygems'
require 'activerecord'
require 'activesupport'
require 'spec/test_model'

$LOAD_PATH << File.expand_path("../lib", File.dirname(__FILE__))
require 'db_graph/line'

1000.times{Product.create!(:created_at=>Time.parse('2008-01-01')+rand(1.year),  :updated_at=>Time.parse('2008-01-01')+rand(1.year))}
500.times{Product.create!(:created_at=>Time.parse('2008-10-01')+rand(2.months), :updated_at=>Time.parse('2008-10-01')+rand(2.months))}

[:weeks, :months].each do |interval|
  g = DBGraph::Line.new(interval, :size=>'445x400', :show_legend=>(interval!=:weeks))
  g.add Product, :created_at
  g.add Product, :updated_at
  puts "![#{interval}](#{g.to_url})"
end
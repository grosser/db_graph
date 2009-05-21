# ---- requirements
require 'rubygems'
$LOAD_PATH << File.expand_path("../lib", File.dirname(__FILE__))
require 'activerecord'
require 'activesupport'
load File.expand_path("test_model.rb", File.dirname(__FILE__))
require 'db_graph/line'
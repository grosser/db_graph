`mysqladmin create grosser_db_graph_test -u build` if ENV["RUN_CODE_RUN"]

ActiveRecord::Base.establish_connection({
  :adapter => "mysql",
  :database => "grosser_db_graph_test",
  :username => ENV["RUN_CODE_RUN"] ? 'build' : 'root'
})

ActiveRecord::Schema.define(:version => 1) do
  create_table :products, :force=>true do |t|
    t.timestamps
  end
end

class Product < ActiveRecord::Base
end

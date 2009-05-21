ActiveRecord::Base.establish_connection({
  :adapter => "mysql",
  :database => "db_graph_test",
  :user => 'root',
  :password => 'root'
})

ActiveRecord::Schema.define(:version => 1) do
  create_table :products, :force=>true do |t|
    t.timestamps
  end
end

class Product < ActiveRecord::Base
end

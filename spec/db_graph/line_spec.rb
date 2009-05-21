require File.join(File.dirname(__FILE__),'..','spec_helper')

describe DBGraph::Line do
  describe "hour labels" do
    before do
      Product.should_receive(:count).and_return({"0"=>1,"1"=>3,"2"=>3,"23"=>9})
      @line = DBGraph::Line.new(:hours, :at=>Time.now)
      @line.add(Product, :created_at)
    end

    it "has hours as x labels" do
      @line.x_labels.should == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
    end

    it "has even values as y labels" do
      @line.y_labels.should == [0,1,2,3,4,5,6,7,8,9]
    end
  end

  describe "hour query" do
    before :all do
      Product.create!(:created_at=>"2009-01-01 23:59:59")

      Product.create!(:created_at=>"2009-01-02 00:00:00")
      Product.create!(:created_at=>"2009-01-02 10:11:12")
      Product.create!(:created_at=>"2009-01-02 10:59:12")
      Product.create!(:created_at=>"2009-01-02 13:11:12")

      Product.create!(:created_at=>"2009-01-03 00:00:00")
    end

    it "yields the correct results when at is set" do
      @line = DBGraph::Line.new(:hours, :at=>Time.parse('2009-01-02 14:15:16'))
      @line.count(Product, :created_at).should == {"0"=>1,"10"=>2,"13"=>1}
    end

    it "yields the correct results when at is not set" do
      @line = DBGraph::Line.new(:hours)
      @line.count(Product, :created_at).should == {"23"=>1,"0"=>2,"10"=>2,"13"=>1}
      @line.add(Product,:created_at)
      puts @line.to_url
    end
  end

  describe :fill_up_values do
    it "adds 0 for every non-filled value" do
      data = {"1"=>2,"3"=>3}
      expected_keys = [1,2,3,4,5]
      filled = DBGraph::Line.send(:fill_up_values, data, expected_keys)
      filled.should == {"1"=>2, "2"=>0, "3"=>3, "4"=>0, "5"=>0}
    end
  end

  describe :filled_and_sorted_values do
    before do
      @data = {"1"=>2,"3"=>3}
      @expected_keys = [1,2,3,4,5]
      @filled = DBGraph::Line.send(:filled_and_sorted_values, @data, @expected_keys)
    end

    it "does not alter the original" do
      @data.should == {"1"=>2,"3"=>3}
    end

    it "fills/sorts the values" do
      @filled.should == [2, 0, 3, 0, 0]
    end
  end

#  describe :x_labels do
#    it "distributes them evenly" do
#      subject.data[:test] = {1=>1,12=>2}
#      subject.data[:test2] = {1=>1,12=>2,4=>1}
#      subject.x_labels.should == [1,2,3,4,5,6,7,8,9,10,11,12]
#    end
#  end
#
#  describe :y_labels do
#    it "distributes them evenly" do
#      subject.data[:test] = {1=>1,2=>5}
#      subject.data[:test2] = {1=>3,12=>12,4=>1}
#      subject.y_labels.should == [1,2,3,4,5,6,7,8,9,10,11,12]
#    end
#  end
#
#  describe :add do
#    it ""
#
#  end
end
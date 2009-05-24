require File.join(File.dirname(__FILE__),'..','spec_helper')

describe DBGraph::Line do
  describe "hour labels" do
    before do
      Product.should_receive(:count).and_return({"0"=>1,"1"=>3,"2"=>3,"23"=>9})
      @line = DBGraph::Line.new(:hours)
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
      Product.delete_all
      Product.create!(:created_at=>"2009-01-01 23:59:59")

      Product.create!(:created_at=>"2009-01-02 00:00:00")
      Product.create!(:created_at=>"2009-01-02 10:11:12")
      Product.create!(:created_at=>"2009-01-02 10:59:12")
      Product.create!(:created_at=>"2009-01-02 13:11:12")

      Product.create!(:created_at=>"2009-01-03 00:00:00")
    end

    it "collects from one day when at is set" do
      @line = DBGraph::Line.new(:hours, :at=>Time.parse('2009-01-02 14:15:16'))
      @line.count(Product, :created_at).should == {"0"=>1,"10"=>2,"13"=>1}
    end

    it "collects from all days when at is not set" do
      @line = DBGraph::Line.new(:hours)
      @line.count(Product, :created_at).should == {"23"=>1,"0"=>2,"10"=>2,"13"=>1}
    end
  end

  describe "day labels" do
    it "has days as x labels with gaps for readability" do
      @line = DBGraph::Line.new(:days)
      gaps = ['','','','']
      @line.x_labels.should == [gaps,5,gaps,10,gaps,15,gaps,20,gaps,25,gaps,30,''].flatten
    end
  end

  describe "day query" do
    before :all do
      Product.delete_all
      Product.create!(:created_at=>"2009-03-31 23:59:59")

      Product.create!(:created_at=>"2009-04-01 00:00:00")
      Product.create!(:created_at=>"2009-04-10 13:11:12")
      Product.create!(:created_at=>"2009-04-30 23:59:59")
      Product.create!(:created_at=>"2009-04-30 23:59:59")

      Product.create!(:created_at=>"2009-05-01 00:00:00")
    end

    it "collects from one onth when at is set" do
      @line = DBGraph::Line.new(:days, :at=>Time.parse('2009-04-02 14:15:16'))
      @line.count(Product, :created_at).should == {"1"=>1,"10"=>1,"30"=>2}
    end

    it "collects from all years when at is not set" do
      @line = DBGraph::Line.new(:days)
      @line.count(Product, :created_at).should == {"1"=>2,"10"=>1,"30"=>2,"31"=>1}
    end
  end

  describe "week labels" do
    it "has weeks as x labels with gaps for readability" do
      @line = DBGraph::Line.new(:weeks)
      gaps = [''] * 9
      @line.x_labels.should == [0,gaps,10,gaps,20,gaps,30,gaps,40,gaps,50,'',''].flatten
    end
  end

  describe "week query" do
    before :all do
      Product.delete_all
      Product.create!(:created_at=>"2008-12-31 23:59:59")

      Product.create!(:created_at=>"2009-01-01 00:00:00")
      Product.create!(:created_at=>"2009-05-31 13:11:12")
      Product.create!(:created_at=>"2009-05-31 13:11:11")
      Product.create!(:created_at=>"2009-12-31 23:59:59")

      Product.create!(:created_at=>"2010-01-01 00:00:00")
    end

    it "collects from one year when at is set" do
      @line = DBGraph::Line.new(:weeks, :at=>Time.parse('2009-01-02 14:15:16'))
      @line.count(Product, :created_at).should == {"0"=>1,"22"=>2,"52"=>1}
    end

    it "collects from all years when at is not set" do
      @line = DBGraph::Line.new(:weeks)
      @line.count(Product, :created_at).should == {"0"=>2,"22"=>2,"52"=>2}
    end
  end

  describe "month labels" do
    it "has months as x labels" do
      @line = DBGraph::Line.new(:months)
      @line.x_labels.should == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    end
  end

  describe "month query" do
    before :all do
      Product.delete_all
      Product.create!(:created_at=>"2008-12-31 23:59:59")

      Product.create!(:created_at=>"2009-01-01 00:00:00")
      Product.create!(:created_at=>"2009-05-31 13:11:12")
      Product.create!(:created_at=>"2009-05-31 13:11:11")
      Product.create!(:created_at=>"2009-12-31 23:59:59")

      Product.create!(:created_at=>"2010-01-01 00:00:00")
    end

    it "collects from one year when at is set" do
      @line = DBGraph::Line.new(:months, :at=>Time.parse('2009-01-02 14:15:16'))
      @line.count(Product, :created_at).should == {"1"=>1,"5"=>2,"12"=>1}
    end

    it "collects from all years when at is not set" do
      @line = DBGraph::Line.new(:months)
      @line.count(Product, :created_at).should == {"1"=>2,"5"=>2,"12"=>2}
    end
  end

  it "accepts options for count" do
    Product.delete_all
    3.times{Product.create!}
    2.times{Product.create!(:created_at=>'2009-02-02')}
    3.times{Product.create!}

    @line = DBGraph::Line.new(:months)
    @line.add(Product, :created_at, :conditions=>"MONTH(created_at)=2")
    @line.data.values.first.should == {"2"=>2}
  end

  describe :fill_up_values do
    it "adds 0 for every non-filled value" do
      data = [["1",2], ["3",3]]
      expected_keys = [1,2,3,4,5]
      filled = DBGraph::Line.send(:fill_up_values, data, expected_keys)
      filled.should == [[1,2], [2,0], [3,3], [4,0], [5,0]]
    end
  end

  describe :filled_and_sorted_values do
    it "fills/sorts the values" do
      data = {"1"=>2, "3"=>3, "10"=>4}
      expected_keys = [1,2,3,4,5,6,7,8,9,10]
      filled = DBGraph::Line.send(:filled_and_sorted_values, data, expected_keys)
      filled.should == [2, 0, 3, 0, 0, 0, 0, 0, 0, 4]
    end
  end

  describe :random_color do
    before do
      @line = DBGraph::Line.new(:months)
    end

    it "includes pairs of colors" do
      @line.should_receive(:rand).and_return 0,2,10
      @line.send(:random_color).should == '0022aa'
    end
  end
end
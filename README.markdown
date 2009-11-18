Gem/Rails plugin to generate graphs from all your date fields, beautifully simple and combineable.

Examples
========
Weeks and months  
![weeks](http://chart.apis.google.com/chart?chxl=0:|0||||||||||10||||||||||20||||||||||30||||||||||40||||||||||50|||1:|5|14|24|33|42|52|61|70|80|89&cht=lc&chs=445x400&chd=s:MOQLIKNMKMQNROTLIMLMNPPOKPJKKLNORNJKKOOo281ztr1yTROND,IMQJORQJKPMKNNOLONKKMKLMNNVMPKNLQONMKORkv3t7v609JGLNH&chco=dd0099,aa9944&chxt=x,y)
![months](http://chart.apis.google.com/chart?chxl=0:|1|2|3|4|5|6|7|8|9|10|11|12|1:|68|100|133|165|198|230|263|295|328|360&cht=lc&chs=445x400&chdl=Product+created_at|Product+updated_at&chd=s:PMQNOOMON9yQ,OMONNNQPQ34L&chco=dd0099,aa9944&chxt=x,y)

Install
=======
As Gem:
    sudo gem install db_graph -s http://gemcutter.org

Or as Rails plugin:
    sudo gem install gchartrb
    ./script/plugins install git://github.com/grosser/db_graph.git


Usage
=====
    DBGraph::Line.url(:weeks, User, :created_at, :at=>Time.now)

Or instance interface for multiple lines
    #everything
    g = DBGraph::Line.new(:weeks)

    #selected interval (:at is expanded to a interval, here: 2009-2010)
    g = DBGraph::Line.new(:weeks, :at=>Time.parse('2009-01-02'), :show_legend=>false)
    
    g.add(User, :created_at)
    g.add(Item, :sold_at, :label=>'Things we sold')
    g.add(Product, :sold_at, :conditions=>['merchandise = ?',false])
    ...
    g.to_url --> google chart url with all your data as line graph

We got :minutes, :hours, :days, :weeks, :months and seconds/years can be added if someone needs them...

TODO
====
 - weeks/months from beginning of data (->all years)

Author
======
[Michael Grosser](http://pragmatig.wordpress.com)  
grosser.michael@gmail.com  
Hereby placed under public domain, do what you want, just do not hold me accountable...
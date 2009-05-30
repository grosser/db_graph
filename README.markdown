Gem/Rails plugin to generate graphs from all your date fields, beautifully simple and combineable.

Examples
========
Weeks and months  
![weeks](http://chart.apis.google.com/chart?chd=s:LSPLPPMLJNIJLLQMNLLLMJMRNKLJPOPILLJJPPHYwypy96z3OMLME,OKLIJNQPOPJIMPIOTLNLSJLLIHNJRHMJNTLNNPOj3p7qy1xyIPLNA&chco=ee8822,dd2244&chxt=x,y&chxl=0:|0||||||||||10||||||||||20||||||||||30||||||||||40||||||||||50|||1:|1|11|21|32|42|52|62|73|83|93&cht=lc&chs=445x400)
![months](http://chart.apis.google.com/chart?chd=s:ROMONPOMO19O,NQNPPKOPQ63M&chco=ee4466,776677&chxt=x,y&chxl=0:|1|2|3|4|5|6|7|8|9|10|11|12|1:|62|95|127|160|193|225|258|291|323|356&cht=lc&chs=445x400&chdl=Product+created_at|Product+updated_at)


Install
=======
As Gem:
    sudo gem install grosser-db_graph -s http://gems.github.com/

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
Gem/Rails plugin to generate graphs from all your date fields, beautifully simple and combineable.

Examples
========
Weeks and months  
![weeks](http://chart.apis.google.com/chart?chxl=0:|0||||||||||10||||||||||20||||||||||30||||||||||40||||||||||50|||1:|6|16|25|35|45|54|64|74|83|93&cht=lc&chs=445x400&chdl=Product+created_at|Product+updated_at&chd=s:JTKPKLKMUNPQHQSKRNLGPPLKUHNNPFJLLPNJINQex19u5xrrNFKLD,HLJMONLJLNHPQNOLNPMMINNKPMPGKLFJLRQLKOOtsxxvw137MHOLF&chco=333300,bbbb33&chxt=x,y)
![months](http://chart.apis.google.com/chart?chxl=0:|1|2|3|4|5|6|7|8|9|10|11|12|1:|67|98|130|161|193|224|256|287|319|350&cht=lc&chs=445x400&chdl=Product+created_at|Product+updated_at&chd=s:QOQROONPM92L,OMPPOOMPO77N&chco=884466,22dddd&chxt=x,y)


Install
=======
As Gem:
    sudo gem install grosser-db_graph -s http://gems.github.com/

Or as Rails plugin:
    sudo gem install gchartrb
    ./script/plugins install git://github.com/grosser/db_graph.git


Usage
=====
Static interface for single lines
    DBGraph::Line.url(:weeks, User, :created_at, :at=>Time.now)

Or instance interface for multiple lines
    g = DBGraph::Line.new(:weeks)

    #minutes/hours/days/weeks/months in a selected interval (:at is expanded to a interval, here: 2009-2010)
    g = DBGraph::Line.new(:weeks, :at=>Time.parse('2009-01-02'))
    
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
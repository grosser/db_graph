Rails plugin to generate graphs from all your date fields, beautifully simple and combineable.

Examples
========
Weeks and months  
![weeks](http://chart.apis.google.com/chart?chxl=0:|0||||||||||10||||||||||20||||||||||30||||||||||40||||||||||50|||1:|6|16|25|35|45|54|64|74|83|93&cht=lc&chs=445x400&chdl=Product+created_at|Product+updated_at&chd=s:JTKPKLKMUNPQHQSKRNLGPPLKUHNNPFJLLPNJINQex19u5xrrNFKLD,HLJMONLJLNHPQNOLNPMMINNKPMPGKLFJLRQLKOOtsxxvw137MHOLF&chco=333300,bbbb33&chxt=x,y)
![months](http://chart.apis.google.com/chart?chxl=0:|1|2|3|4|5|6|7|8|9|10|11|12|1:|67|98|130|161|193|224|256|287|319|350&cht=lc&chs=445x400&chdl=Product+created_at|Product+updated_at&chd=s:QOQROONPM92L,OMPPOOMPO77N&chco=884466,22dddd&chxt=x,y)

Usage
=====
Install:
    sudo gem install gchartrb

As Gem:
    sudo gem install grosser-db_graph -s http://gems.github.com/

Or as Rails plugin:
    ./script/plugins install git://github.com/grosser/db_graph.git

Start plotting:
    #all hours/days/weeks/months
    g = DBGraph::Line.new(:weeks)

    #hours/days/weeks/months in a selected interval (e.g. in 1 year for months)
    g = DBGraph::Line.new(:weeks, :at=>Time.parse('2009-01-02 14:15:16'))
    
    g.add(User, :created_at)
    g.add(Item, :sold_at)
    g.add(Product, :sold_at, :conditions=>['merchandise = ?',false])
    ...
    g.to_url --> google chart url with all your data as line graph


TODO
====
 - weeks/months from beginning of data (->all years)
 - minutes


Author
======
[Michael Grosser](http://pragmatig.wordpress.com)  
grosser.michael@gmail.com  
Hereby placed under public domain, do what you want, just do not hold me accountable...
Rails plugin to generate graphs from all your date fields, beautifully simple and combineable.

Examples
========
    ruby examples/multi_line_grahp.rb
Week and months  
![weeks](http://chart.apis.google.com/chart?chxl=0:|0||||||||||10||||||||||20||||||||||30||||||||||40||||||||||50|||1:|9|18|28|37|46|56|65|74|84|93&cht=lc&chs=449x400&chdl=Product+created_at|Product+updated_at&chd=s:HQOLNLNNKTOJNLRJNRHQIHPMNHNHHJRNIOIRPJJl618r5sytLGNPH,JSOLPNRMPMNOJNNINPRMLNLKPLFGHNPPPLHJLLKk0oy5vq94LJJLH&chco=dd1199,220011&chxt=x,y)
![months](http://chart.apis.google.com/chart?chxl=0:|1|2|3|4|5|6|7|8|9|10|11|12|1:|68|102|135|169|202|236|269|303|336|370&cht=lc&chs=449x400&chdl=Product+created_at|Product+updated_at&chd=s:ONPPLMMNN9zN,QPOOPMLNL33L&chco=338888,665511&chxt=x,y)


Usage
=====
Install:
    sudo gem install gchartrb
    ./script/plugins install git://github.com/grosser/db_graph.git

Start plotting:
    #all hours/days/weeks/months
    g = DBGraph::Line.new(:weeks)

    #hours/days/weeks/months in a selected interval (e.g. months => in 1 year)
    g = DBGraph::Line.new(:weeks, :at=>Time.parse('2009-01-02 14:15:16'))
    
    g.add(User, :created_at)
    g.add(Item, :sold_at)
    ...
    g.to_url --> google chart url with all your data as line graph


TODO
====
 - weeks/months from beginning of data (->all years)
 - minutes


Author
======
Michael Grosser
grosser.michael@gmail.com
Hereby placed under public domain, do what you want, just do not hold me accountable...
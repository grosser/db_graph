Rails plugin to generate graphs from all your date fields, beautifully simple and combineable.

Examples
========
    ruby examples/multi_line_grahp.rb
![days](http://chart.apis.google.com/chart?chxl=0:|||||5|||||10|||||15|||||20|||||25|||||30||1:|19|24|29|35|40|45|50|56|61|66&cht=lc&chs=600x500&chdl=Product+created_at|Product+updated_at&chd=s:w2sn1rvruf1u9ot0qono42tumqkwulR,ukrg6um1uw6n0z1uhpogyf33x0szofW&chco=99aa00,44eecc&chxt=x,y)
![weeks](http://chart.apis.google.com/chart?chxl=0:|0||||||||||10||||||||||20||||||||||30||||||||||40||||||||||50|||1:|6|16|25|35|45|54|64|74|83|93&cht=lc&chs=600x500&chdl=Product+created_at|Product+updated_at&chd=s:ONRPPHPKGLIILPLRKLNJPJHMUQJPLNIPLPLLNLKmty3y9vqwLLNNH,POLQLNJLRHPLJJLLJJMSNRHNNIJMMMMMLJJLMJJczzx236s7PPNOD&chco=991122,cc1122&chxt=x,y)
![months](http://chart.apis.google.com/chart?chxl=0:|1|2|3|4|5|6|7|8|9|10|11|12|1:|69|100|131|162|193|225|256|287|318|349&cht=lc&chs=600x500&chdl=Product+created_at|Product+updated_at&chd=s:SMMOOPOON84O,RNNMRMOMN69Q&chco=6655dd,113399&chxt=x,y)


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
Rails plugin to generate graphs from all your date fields, beautifully simple and combineable.

Examples
========
    ruby examples/multi_line_grahp.rb
Week and months  
![weeks](http://chart.apis.google.com/chart?chxl=0:|0||||||||||10||||||||||20||||||||||30||||||||||40||||||||||50|||1:|3|13|23|33|43|53|63|73|83|93&cht=lc&chs=299x300&chdl=Product+created_at|Product+updated_at&chd=s:EUJKPJLQPKRQPGJLJLRQJOJMSLKPPPOHMQRLNKRhwvv9vwypLKJOB,IPPPNGLJVPPGNKLIQJNOONQQNOLNJJPHLJRLKKLcvzxv3tx3MQLRF&chco=553377,dd5566&chxt=x,y)
![months](http://chart.apis.google.com/chart?chxl=0:|1|2|3|4|5|6|7|8|9|10|11|12|1:|64|95|126|157|188|218|249|280|311|342&cht=lc&chs=299x300&chdl=Product+created_at|Product+updated_at&chd=s:PORLRPQQO92M,RMPNQRONN56R&chco=44ffaa,77cc88&chxt=x,y)

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
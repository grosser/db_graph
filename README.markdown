Rails plugin to generate graphs from all your date fields, beautifully simple and combineable.

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
 - better colors
 - weeks
 - months from beginning of data (->all years)
 - minutes

Author
======
Michael Grosser
grosser.michael@gmail.com
Hereby placed under public domain, do what you want, just do not hold me accountable...
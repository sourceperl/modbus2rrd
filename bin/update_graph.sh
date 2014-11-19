#!/bin/bash

rrdtool graph mygraph.png -a PNG --title="Position valve vs gas flow" --vertical-label "open (0/1000) / gas flow (0/1300 Mnm3)" \
--start -3600s --width 600 --height 400 \
DEF:pos=/home/pi/rrd/pos.rrd:item:AVERAGE \
LINE1:pos#ff0000:"Pos. G1" \
LINE1:550#F28C17:"Pos. G1 MAX":dashes \
LINE1:100#0000ff:"Pos. G1 MIN":dashes \
DEF:flow=/home/pi/rrd/flow.rrd:item:AVERAGE \
LINE1:flow#00ff00:"Q" \
DEF:sp=/home/pi/rrd/setpoint.rrd:item:AVERAGE \
LINE1:sp#F322D7:"Set Point"


sudo mv mygraph.png /var/www/

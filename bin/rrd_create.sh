#!/bin/bash

# create RRDtool base
# Round Robin Archive :
#  rows  step  step_value
#  3600 *  1 * 1s     -> 1h
#  8640 * 10 * 1s     -> 1d
# 10080 * 60 * 1s     -> 1w

rrdtool create item.rrd --step 1 --no-overwrite \
DS:item:GAUGE:15:U:U \
RRA:AVERAGE:0.5:1:3600 \
RRA:AVERAGE:0.5:10:8640 \
RRA:AVERAGE:0.5:60:10080

#!/usr/bin/python2.7
from pyModbusTCP.client import ModbusClient
import rrdtool
import time

# some consts
RRD_REFRESH = 1.0 # refresh RRD every 1s
RRD_POS     = "/home/pi/rrd/pos.rrd"
RRD_FLOW    = "/home/pi/rrd/flow.rrd"
RRD_SP      = "/home/pi/rrd/setpoint.rrd"

c=ModbusClient()
#c.debug(1)
c.host("163.111.184.31")
c.unit_id(33)

while(True):
  # keep TCP link open
  if not c.is_open():
    c.open()

  if c.is_open():
    # loop start time
    start = time.time()
    # #20506
    r = c.read_holding_registers(20506)
    if r:
      ret = rrdtool.update(RRD_POS, 'N:%d' % r[0])
    # #20492
    r = c.read_holding_registers(20492)
    if r:
      ret = rrdtool.update(RRD_FLOW, 'N:%d' % r[0])
    # #20494
    r = c.read_holding_registers(20494)
    if r:
      ret = rrdtool.update(RRD_SP, 'N:%d' % r[0])
    # loop end time
    end = time.time()
    loop_time = end - start
    # wait before next cycle
    time.sleep(RRD_REFRESH - loop_time)
  else:
    # wait fix 1s
    time.sleep(1)

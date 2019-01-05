#!/bin/bash

# Kill processes
pkill telegraf
pkill influx
pkill grafana

# Remove directories
rm -rf telegraf*
rm -rf influx*
rm -rf grafana*


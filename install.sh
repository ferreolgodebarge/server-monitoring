#!/bin/bash

echo -e "---------------------"
echo -e "Preparing Environment"
echo -e "---------------------"
# Kill processes
pkill telegraf
pkill grafana
pkill influx

# Remove old directories if exists
rm -rf telegraf*
rm -rf influx*
rm -rf grafana*
echo -e "Environment prepared !\n\n"

echo -e "---------------------"
echo -e "-Download Telegraf-"
echo -e "---------------------"
# Install Telegraf binaries
wget -q --show-progress wget https://dl.influxdata.com/telegraf/releases/telegraf-1.9.1_linux_amd64.tar.gz -O telegraf.tar.gz
tar -xf telegraf.tar.gz
rm telegraf.tar.gz
echo -e "Telegraf Downloaded\n\n"

echo -e "---------------------"
echo -e "-Download InfluxDB---"
echo -e "---------------------"
# Install InfluxDB binaries
wget -q --show-progress wget https://dl.influxdata.com/influxdb/releases/influxdb-1.7.2_linux_amd64.tar.gz -O influx.tar.gz
tar -xf influx.tar.gz
rm influx.tar.gz
echo -e "Inlux Downloaded\n\n"

echo -e "---------------------"
echo -e "-Download Grafana----"
echo -e "---------------------"
# Install Grafana binaries
wget -q --show-progress https://dl.grafana.com/oss/release/grafana-5.4.2.linux-amd64.tar.gz -O grafana.tar.gz
tar -xf grafana.tar.gz
rm grafana.tar.gz
echo -e "Grafana Downloaded\n\n"

TEL_HOME=telegraf
INF_HOME=influxdb-1.7.2-1
GRAF_HOME=grafana-5.4.2

echo -e "---------------------"
echo -e "-Copy configurations-"
echo -e "---------------------"
cp conf/defaults.ini $GRAF_HOME/conf/defaults.ini
echo -e "Configurations copied\n\n"

echo -e "---------------------"
echo -e "-Run InfluxDB--------"
echo -e "---------------------"
# Run InfluxDB
./INF_HOME/usr/bin/influxd &>/dev/null &
echo -e "InfluxDB runs !\n\n"

echo -e "---------------------"
echo -e "-Run Telegraf--------"
echo -e "---------------------"
# Run telegraf
./telegraf/usr/bin/telegraf --config ./telegraf/etc/telegraf/telegraf.conf&>/dev/null &
echo -e "Telegraph agent runs !\n\n"

echo -e "---------------------"
echo -e "-Run Grafana---------"
echo -e "---------------------"
# Run grafana
./$GRAF_HOME/bin/grafana-server -homepath=$GRAF_HOME/ &>/dev/null &
echo -e "Grafana runs !\n\n"

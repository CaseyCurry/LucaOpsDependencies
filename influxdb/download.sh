cd ~/src/Luca/ops/dependencies/influxdb

# download
curl -LO https://dl.influxdata.com/influxdb/releases/influxdb-1.3.5-static_linux_amd64.tar.gz
tar xvfz influxdb-1.3.5-static_linux_amd64.tar.gz
rm influxdb-1.3.5-static_linux_amd64.tar.gz

# containerize
acbuild begin
acbuild set-name influxdb
acbuild label add version 1.3.5
acbuild copy ./influxdb-1.3.5-1 /influxdb
acbuild set-exec /influxdb/influxd
acbuild port add http tcp 8086
acbuild write ./influxdb.1.3.5.aci
acbuild end

# deploy
scp ./influxdb.1.3.5.aci @server.nomad.devlab:/www/containers

# cleanup
rm ./influx.1.3.5.aci
rm -rf ./influxdb-1.3.5-1

cd ~/src/Luca/ops/environment/dependencies/chronograf

# download
curl -LO https://dl.influxdata.com/chronograf/releases/chronograf-1.3.8.1-static_linux_amd64.tar.gz
tar xvfz chronograf-1.3.8.1-static_linux_amd64.tar.gz
rm chronograf-1.3.8.1-static_linux_amd64.tar.gz

# containerize
acbuild begin
acbuild set-name chronograf
acbuild label add chronograf 1.3.8.1
acbuild copy ./chronograf-1.3.8.1-1/chronograf /chronograf
acbuild set-exec /chronograf
acbuild port add http tcp 8888
acbuild write ./chronograf.1.3.8.1.aci
acbuild end

# deploy
scp ./chronograf.1.3.8.1.aci @server.nomad.devlab:/www/containers

# cleanup
rm ./chronograf.1.3.8.1.aci
rm -rf ./chronograf-1.3.8.1-1

# download
curl -LO https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-4.5.0.linux-x64.tar.gz
tar -zxf grafana-4.5.0.linux-x64.tar.gz
rm grafana-4.5.0.linux-x64.tar.gz
sed -i 's*(http_port)s/*(http_port)s/grafana/*' ./grafana-4.5.0/conf/defaults.ini

# containerize
sudo cp /usr/lib64/ld-linux-x86-64.so.2 ./ld-linux-x86-64.so.2 && sudo chown cj:cj ./ld-linux-x86-64.so.2
sudo cp /usr/lib64/libdl.so.2 ./libdl.so.2 && sudo chown cj:cj ./libdl.so.2
sudo cp /usr/lib64/libpthread.so.0 ./libpthread.so.0 && sudo chown cj:cj ./libpthread.so.0
sudo cp /usr/lib64/libc.so.6 ./libc.so.6 && sudo chown cj:cj ./libc.so.6
acbuild begin
acbuild set-name grafana
acbuild label add version 4.5.0
acbuild copy-to-dir ./grafana-4.5.0/bin ./grafana-4.5.0/conf ./grafana-4.5.0/public ./grafana-4.5.0/scripts ./grafana-4.5.0/vendor ./grafana-4.5.0/VERSION /
acbuild copy-to-dir ./ld-linux-x86-64.so.2 ./libdl.so.2 ./libpthread.so.0 ./libc.so.6 /lib64
acbuild set-exec /bin/grafana-server web
acbuild write ./grafana-4.5.0.aci
acbuild end
rm ./ld-linux-x86-64.so.2
rm ./libdl.so.2
rm ./libpthread.so.0
rm ./libc.so.6

# run
sudo rkt run --insecure_options=image --net=host --dns=192.168.56.109 ./grafana.aci

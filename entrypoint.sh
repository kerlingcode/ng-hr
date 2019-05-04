cd /v2ray
wget -O v2ray.zip http://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip
unzip v2ray.zip 
if [ ! -f "v2ray" ]; then
  mv /v2ray/v2ray-v$VER-linux-64/v2ray .
  mv /v2ray/v2ray-v$VER-linux-64/v2ctl .
  mv /v2ray/v2ray-v$VER-linux-64/geoip.dat .
  mv /v2ray/v2ray-v$VER-linux-64/geosite.dat .
fi
chmod +x v2ray v2ctl

sed -i "s/your_uuid/$UUID/g" config.json
sed -i "s/your_path/$HRPATH/g" config.json
sed -i "s|HR_PORT|$PORT|g"  /etc/nginx/conf.d/default.conf
sed -i "s|your_path|$HRPATH|g"  /etc/nginx/conf.d/default.conf

nohup ./v2ray &
nginx -g "daemon off;"

#!/bin/sh

set -e
set -x

mkdir -p $SNAP_APP_DATA_PATH/etc/grafana/
mkdir -p $SNAP_APP_DATA_PATH/var/log/grafana/
mkdir -p $SNAP_APP_DATA_PATH/var/lib/grafana/

# ugly workaround for embedded SNAP_APP_DATA_PATH into grafana.ini
cp $SNAP_APP_PATH/conf/defaults.ini $SNAP_APP_DATA_PATH/etc/grafana/grafana.ini
SNAP_APP_DATA_PATH_ESCAPE=$(echo $SNAP_APP_DATA_PATH | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\\&/g')
sed -i "s/SNAP_APP_DATA_PATH/$SNAP_APP_DATA_PATH_ESCAPE/g" $SNAP_APP_DATA_PATH/etc/grafana/grafana.ini

# Pass default cfg parameter, see https://github.com/grafana/grafana/issues/2508#issuecomment-130819050
$SNAP_APP_PATH/bin/grafana \
  -config=$SNAP_APP_DATA_PATH/etc/grafana/grafana.ini \
  -homepath=$SNAP_APP_PATH/usr/share/grafana \
  -pidfile=$SNAP_APP_DATA_PATH/var/run/grafana.pid \
  cfg:default.paths.logs=$SNAP_APP_DATA_PATH/var/log/grafana \
  cfg:default.paths.data=$SNAP_APP_DATA_PATH/var/lib/grafana \
  default.auth.ldap.config_file=$SNAP_APP_DATA_PATH/etc/grafana/ldap.toml \
  default.dashboards.json.path=$SNAP_APP_DATA_PATH/var/lib/grafana/dashboards


lan_ip='192.168.3.1'                                                        # Lan Ip地址
utc_name='Asia\/Shanghai'                                                   # 时区
delete_bootstrap=true                                                       # 是否删除默认主题 true 、false





echo "lan ip"
sed -i "s/192.168.1.1/$lan_ip/g" package/base-files/files/bin/config_generate

echo "时区"
sed -i "s/'UTC'/'CST-8'\n   set system.@system[-1].zonename='$utc_name'/g" package/base-files/files/bin/config_generate

if [ $delete_bootstrap ]; then
  echo "去除默认bootstrap主题"
  sed -i '/\+luci-theme-bootstrap/d' feeds/luci/collections/luci/Makefile
  sed -i '/\+luci-theme-bootstrap/d' package/feeds/luci/luci/Makefile
  sed -i '/CONFIG_PACKAGE_luci-theme-bootstrap=y/d' .config
  sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
fi

echo "修改默认主题"
sed -i "s/bootstrap/$edge/g" feeds/luci/modules/luci-base/root/etc/config/luci

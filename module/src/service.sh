#!/system/bin/sh

set -e
CLEANUP_SCRIPT="/data/adb/service.d/.rezygisk.sh"
DEBUG=@DEBUG@

MODDIR=${0%/*}
# Create cleanup script
[ ! -f "$CLEANUP_SCRIPT" ] && {
  mkdir -p "$(dirname $CLEANUP_SCRIPT)"
  cp "$MODDIR/.rezygisk.sh" "$CLEANUP_SCRIPT"
  chmod +x "$CLEANUP_SCRIPT"
}
if [ "$ZYGISK_ENABLED" ]; then
  sed -i "s|^description=|description=[❌ Disable Magisk's built-in Zygisk] |" "$MODDIR/module.prop"

  exit 0
fi

cd "$MODDIR"

if [ "$(which magisk)" ]; then
  for file in ../*; do
    if [ -d "$file" ] && [ -d "$file/zygisk" ] && ! [ -f "$file/disable" ]; then
      if [ -f "$file/service.sh" ]; then
        cd "$file"
        log -p i -t "zygisk-sh" "Manually trigger service.sh for $file"
        sh "$(realpath ./service.sh)" &
        cd "$MODDIR"
      fi
    fi
  done
fi

exit 0

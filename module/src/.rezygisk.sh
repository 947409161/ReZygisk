MODULE_DIR="/data/adb/modules/rezygisk"
THIS_SCRIPT="/data/adb/service.d/.rezygsik.sh"

if [ ! -d "$MODULE_DIR/disable" ]; then
  cat "$MODULE_DIR/module.prop.bak" >"$MODULE_DIR/module.prop"
  rm -f "$THIS_SCRIPT"
fi

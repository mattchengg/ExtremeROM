SKIPUNZIP=1

# Fix Edge lighting corner radius
MODEL=$(echo -n "$TARGET_FIRMWARE" | cut -d "/" -f 1)
SET_PROP "system" "ro.factory.model" "$MODEL"

# Fix up /product/etc/build.prop
sed -i \
    "$(sed -n "/bap.broadcast.assist/=" "$WORK_DIR/product/etc/build.prop") c# Removed by post_process_props.py because overridden by bluetooth.profile.bap.broadcast.assist.enabled=true\n#bluetooth.profile.bap.broadcast.assist.enabled?=false" \
    "$WORK_DIR/product/etc/build.prop"
sed -i \
    "$(sed -n "/bap.unicast.client/=" "$WORK_DIR/product/etc/build.prop") c# Removed by post_process_props.py because overridden by bluetooth.profile.bap.unicast.client.enabled=true\n#bluetooth.profile.bap.unicast.client.enabled?=false" \
    "$WORK_DIR/product/etc/build.prop"
sed -i \
    "$(sed -n "/bluetooth.profile.csip/=" "$WORK_DIR/product/etc/build.prop") c# Removed by post_process_props.py because overridden by bluetooth.profile.csip.set_coordinator.enabled=true\n#bluetooth.profile.csip.set_coordinator.enabled?=false" \
    "$WORK_DIR/product/etc/build.prop"
sed -i \
    "$(sed -n "/bluetooth.profile.mcp/=" "$WORK_DIR/product/etc/build.prop") c# Removed by post_process_props.py because overridden by bluetooth.profile.mcp.server.enabled=true\n#bluetooth.profile.mcp.server.enabled?=false" \
    "$WORK_DIR/product/etc/build.prop"
sed -i \
    "$(sed -n "/bluetooth.profile.ccp/=" "$WORK_DIR/product/etc/build.prop") c# Removed by post_process_props.py because overridden by bluetooth.profile.ccp.server.enabled=true\n#bluetooth.profile.ccp.server.enabled?=false" \
    "$WORK_DIR/product/etc/build.prop"
sed -i \
    "$(sed -n "/bluetooth.profile.vcp/=" "$WORK_DIR/product/etc/build.prop") c# Removed by post_process_props.py because overridden by bluetooth.profile.vcp.controller.enabled=true\n#bluetooth.profile.vcp.controller.enabled?=false" \
    "$WORK_DIR/product/etc/build.prop"
sed -i \
    "/clientidbase.tx/i bluetooth.profile.bap.unicast.client.enabled=true\nbluetooth.profile.csip.set_coordinator.enabled=true\nbluetooth.profile.mcp.server.enabled=true\nbluetooth.profile.ccp.server.enabled=true\nbluetooth.profile.vcp.controller.enabled=true\nbluetooth.profile.bap.broadcast.assist.enabled=true\nro.frp.pst=/dev/block/persistent" \
    "$WORK_DIR/product/etc/build.prop"

echo "Fix up /system/build.prop"
sed -i \
    "/ro.netflix.bsp_rev/i persist.audio.deepbuffer_delay=33" \
    "$WORK_DIR/system/system/build.prop"
echo "Enable adaptive FPS"
sed -i \
    "/use_content_detection/i ro.surface_flinger.enable_frame_rate_override=false" \
    "$WORK_DIR/vendor/build.prop"
SET_PROP "vendor" "ro.surface_flinger.use_content_detection_for_refresh_rate" "true"
sed -i \
    "/use_content_detection/a ro.surface_flinger.set_idle_timer_ms=3000\nro.surface_flinger.set_touch_timer_ms=500\nro.surface_flinger.set_display_power_timer_ms=1000" \
    "$WORK_DIR/vendor/build.prop"

echo "Fix up /system/build.prop"
sed -i \
    "/ro.netflix.bsp_rev/i persist.audio.deepbuffer_delay=33" \
    "$WORK_DIR/system/system/build.prop"

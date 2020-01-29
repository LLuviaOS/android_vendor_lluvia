for device in $(python vendor/lluvia/tools/get_official_devices.py)
do
for var in user userdebug; do
add_lunch_combo lluvia_$device-$var
done
done

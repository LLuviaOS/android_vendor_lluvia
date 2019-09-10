lunch_others_targets=()
for device in $(python vendor/lluvia/tools/get_official_devices.py)
do
    for var in user userdebug; do
        lunch_others_targets+=("lluvia_$device-$var")
    done
done

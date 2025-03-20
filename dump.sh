echo "Remounting / to rw"
adb shell su -c "mount -o remount,rw /"

echo "Creating dump dir"
adb shell su -c "mkdir -p /dump"

for part in \
"mtd0 preloader" \
"mtd1 pro_info" \
"mtd2 nvram" \
"mtd3 protect_f" \
"mtd4 protect_s" \
"mtd5 seccfg" \
"mtd6 uboot" \
"mtd7 bootimg" \
"mtd8 recovery" \
"mtd9 sec_ro" \
"mtd10 misc" \
"mtd11 logo" \
"mtd12 expdb" \
"mtd13 android" \
"mtd14 cache" \
"mtd15 usrdata"
do
  mtd=$(echo $part | awk '{print $1}')
  name=$(echo $part | awk '{print $2}')

  echo "Dumping $name..."
  adb shell su -c "dd if=/dev/mtd/$mtd of=/dump/$name.bin"
  adb shell su -c "chmod 644 /dump/$name.bin"
  adb pull /dump/$name.bin
  adb shell su -c "rm /dump/$name.bin"
done

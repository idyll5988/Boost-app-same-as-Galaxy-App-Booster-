#!/system/bin/sh
echo "$date *dex2oat优化*" 
for i in $(cmd package list packages | cut -f 2 -d ":"); do
  su -c cmd package compile -m speed-profile "$i" -f > /dev/null 2>&1 && echo "$i | 提升应用" 
  su -c cmd package bg-dexopt-job "$i" > /dev/null 2>&1 && echo "$i | 增强电池" 
done
echo "$date *dex2oat优化完成*" 


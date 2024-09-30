#!/system/bin/sh
date="$( date "+%Y年%m月%d日%H时%M分%S秒")"
(echo "\n  按下音量按钮\n   音量 + : 执行编译\n   音量 - : 清除所有编译\n";
while true;
do input="$(timeout 0.1 getevent -l|grep -Eo 'VOLUMEUP|VOLUMEDOWN'|head -n1)";
if [ "$input" = "VOLUMEUP" ];then 
echo "   已选定 : 执行编译\n";
echo "$date *dex2oat优化*" 
for i in $(cmd package list packages | cut -f 2 -d ":"); do
  su -c cmd package compile -m speed-profile "$i" -f > /dev/null 2>&1 && echo "$i | 提升应用" 
  su -c cmd package bg-dexopt-job "$i" > /dev/null 2>&1 && echo "$i | 增强电池" 
done
echo "$date *dex2oat优化完成*" 
break;
elif [ "$input" = "VOLUMEDOWN" ];then 
echo "   已选定 : 清除所有编译\n";
cmd package compile --reset -a
break;
fi;
done;)2>/dev/null

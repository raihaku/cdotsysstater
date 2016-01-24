#!/bin/sh
###引数で指定したNode名のsysstat 3行目をログに記録する
###変数定義###
user=$1
ipaddr=$2
node=$3
logdir="/var/log/netapp/"
log="${logdir}sysstat.log"
msgdircrete="${logdir}ディレクトリを作成しました"
msgargerror="実行例:) $0 <ユーザ名> <cluster_mgmt IP Address> <Node名>"
msgsshsuccess="接続成功しました"
cdotcommand="run -node ${node} sysstat -x -c 3"

###前提エラー処理###
#Directoryが存在しない場合は作成する
if [ ! -d ${logdir} ]
then
 echo ${msgdircrete}
 mkdir ${logdir}
fi
#引数が足りない場合はエラー
if [ $# -ne 3 ]; then
 echo "${msgargerror}" 1>&2
 exit 1
fi

if ssh ${user}@${ipaddr} run -node ${node} date
then
 echo "${msgsshsuccess}"
 ssh ${user}@${ipaddr} ${cdotcommand} | awk -v node=${node} '{ print strftime("%s"),
node , $0 }' | sed -n -e 3p >> ${log}
fi

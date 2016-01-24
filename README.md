# cdotsysstater
collection of \[sysstat -x\] command log for NetApp clustered ONTAP
## Usage
sysstat_logging.sh \<UserName\> \<cluster_mgmt IP Address\> \<NodeName\>

## 前提条件
1. SSH公開鍵を作成する \(CentOSで実行\)  
 \#ssh\-keygen \-t rsa \-C \"SSH2 RSA Key\“  
 \#cat \/root\/\.ssh\/id_rsa\.pub  
 \#ssh-rsa AAQCtPciSkw  
  \~\~\~省略\~\~\~  
  FlAQCtPciSkwNMWztNjr6ETbbBH4szVx SSH2 RSA Key  
※表示されたキーをcDOTに登録する  
  
2. 公開鍵認証の有効化および公開鍵を登録する (cDOTで実行)  
\:\:\>publickey create -username admin -publickey "ssh-rsa AAQCtPciSkwz  
\~\~\~省略\~\~\~  
FlAQCtPciSkwNMWztNjr6ETbbBH4szVx SSH2 RSA Key“  
\:\:\>security login create -username admin -application ssh -authmethod publickey -role admin  

3. SSHログインテスト(CentOSで実行)  
  \#ssh admin\@\<Node Mgmt LIF or Cluster Mgmt LIF IPアドレス\>  
※パスワード無しでcDOTにログインできれば完了  


## 実行に作成されるファイル出力例
\#cat /var/log/netapp/sysstat.log
1435983903 3210cdot-01 2% 0 0 0 8 3 2 213 1091 0 0 42s 100% 9% T 10% 8 0 0 0 0 0 0


## Fluentd in_tailプラグイン記述例
` <source>`  
 `type tail`  
 `path /var/log/netapp/sysstat.log`  
 `pos_file /var/log/netapp/td-agent/sysstat.pos`  
 `tag cdotsysstat.bar`  
 `format /^(?<time>[^ ]*)¥s+(?<node>[^ ]*)¥s+(?<cpu>[^ ]*)%¥s+(?<nfs iops>[^ ]*)¥s+(?<cifs
iops>[^ ]*)¥s+(?<http iops>[^ ]*)¥s+(?<total iops>[^ ]*)¥s+(?<net in KBperSec>[^ ]*)¥s+(?<net out
KBperSec>[^ ]*)¥s+(?<Disk Read KBperSec>[^ ]*)¥s+(?<Disk Write KBperSec>[^ ]*)¥s+(?<Tape Read
KBperSec>[^ ]*)¥s+(?<Tape Write KBperSec>[^ ]*)¥s+(?<Cache age>[^ ]*)¥s+(?<Cache
Hit>[^ ]*)%¥s+(?<CP Time>[^ ]*)%¥s+(?<CP Type>[^ ]*)¥s+(?<Disk Util>[^ ]*)%¥s+(?<Other
iops>[^ ]*)¥s+(?<FCP iops>[^ ]*)¥s+(?<iSCSI iops>[^ ]*)¥s+(?<FCP in KBperSec>[^ ]*)¥s+(?<FCP out
KBperSec>[^ ]*)¥s+(?<iSCSI in KBperSec>[^ ]*)¥s+(?<iSCSI out KBperSec>[^ ]*)$/`  
 `time_format %s`  
 `</source> `

## 参考
http://www.slideshare.net/raihaku/kibanasysstat


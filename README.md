# cdotsysstater
collection of \[sysstat -x\] command log for NetApp clustered ONTAP
# Usage
sysstat_logging.sh \<UserName\> \<cluster_mgmt IP Address\> \<NodeName\>

# 前提条件
1. SSH公開鍵を作成する \(CentOSで実行\)
 \#ssh\-keygen \-t rsa \-C \"SSH2 RSA Key\“
 \#cat \/root\/\.ssh\/id_rsa\.pub
 \#ssh-rsa AAQCtPciSkw
  \~\~\~省略\~\~\~
  FlAQCtPciSkwNMWztNjr6ETbbBH4szVx SSH2 RSA Key
\※表示されたキーをcDOTに登録する

2. 公開鍵認証の有効化および公開鍵を登録する (cDOTで実行)
::>publickey create -username admin -publickey "ssh-rsa AAQCtPciSkwz
~~~省略~~~
FlAQCtPciSkwNMWztNjr6ETbbBH4szVx SSH2 RSA Key“
::>security login create -username admin -application ssh -authmethod publickey -role admin

3. SSHログインテスト(CentOSで実行)
  ssh admin@<Node Mgmt LIF or Cluster Mgmt LIF IPアドレス>
\※パスワード無しでcDOTにログインできれば完了

#参考
http://www.slideshare.net/raihaku/kibanasysstat

#!/bin/bash

echo "Remove any existing container"
docker rm -f zk1 zk2 zk3


echo "Starting zookeeper cluster"
docker run -itd -p 2181:2181 -p 2881:3881 --dns=172.17.0.3 --dns-search=zk1.pinsightmedia.com -h zk1 --name zk1 zk
sleep 2
docker run -itd -p 2182:2182 -p 2882:3882 --dns=172.17.0.4 --dns-search=zk2.pinsightmedia.com -h zk2 --name zk2 zk
sleep 2
docker run -itd -p 2183:2183 -p 2883:3883 --dns=172.17.0.5 --dns-search=zk3.pinsightmedia.com -h zk3 --name zk3 zk
sleep 2

echo "Copying conf.cfg file in zk1"
docker cp ./conf/zoo.cfg zk1:/opt/zookeeper/conf/

echo "Generating myid file and copying it over to zk1"
mkdir zookeeper
echo 1 > ./zookeeper/myid
docker cp ./zookeeper zk1:/tmp
sleep 2

echo "Copying conf.cfg file in zk2"
docker cp ./conf/zoo.cfg zk2:/opt/zookeeper/conf/

echo "Generating myid file and copying it over to zk2"
echo 2 > zookeeper/myid
docker cp ./zookeeper zk2:/tmp/
sleep2

echo "Copying conf.cfg file in zk3"
docker cp ./conf/zoo.cfg zk3:/opt/zookeeper/conf/

echo "Generating myid file and copying it over to zk3"
echo 3 > zookeeper/myid
docker cp ./zookeeper zk3:/tmp/
sleep10


echo "Done!!!"

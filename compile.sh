
if [ "$#" -ne 2 ]; then
    echo "[*] ****Android_MQTT   compile helper******"
    echo "[*]"
    echo "[*]  Author: Benjamin Keil"
    echo "[*]  Email:  roguefendor@gmail.com"
    echo "[*]"
    echo "[*]"
    echo "[*]  Android_MQTT Usage:"
    echo "[*]        Enter path to: <outputfile>  Enter path to: <src file>"
    echo "[*]        example: ./Android MQTT /home/build/client /src/client.c "
    echo "[*]"
    echo "[*]******************************************"
    exit
fi

clear
echo "[*] starting modified mqtt android hack first try"

#ln -s libpaho-mqtt3c.so.1.0  lib/libpaho-mqtt3c.so.1
#ln -s libpaho-mqtt3c.so.1    lib/libpaho-mqtt3c.so
#ln -s libpaho-mqtt3cs.so.1.0 lib/libpaho-mqtt3cs.so.1
#ln -s libpaho-mqtt3cs.so.1   lib/libpaho-mqtt3cs.so
#ln -s libpaho-mqtt3a.so.1.0  lib/libpaho-mqtt3a.so.1
#ln -s libpaho-mqtt3a.so.1    lib/libpaho-mqtt3a.so
#ln -s libpaho-mqtt3as.so.1.0 lib/libpaho-mqtt3as.so.1
#ln -s libpaho-mqtt3as.so.1   lib/libpaho-mqtt3as.so

rm lib/*

INJECT_OPENSSL_ANDROID="/usr/local/ssl/android-19"

INJECT_OPENSSL_LIB="/usr/local/ssl/lib -lssl -lcrypto"

TOOLCHAIN="/home/anon/Android/my-android-toolchain/bin/arm-linux-androideabi-gcc-4.9"

sed -i "s/##MQTTCLIENT_VERSION_TAG##/1.0.3/g; s/##MQTTCLIENT_BUILD_TAG##/Wed Jun 15 09:31:51 IST 2016/g"  src/MQTTClient.c

echo "[*] changed Headers!"
$TOOLCHAIN -g -fPIC -pie -I $INJECT_OPENSSL_ANDROID -pie -Os -Wall -fvisibility=hidden -o lib/libpaho-mqtt3c.so.1.0 src/MQTTPersistence.c src/Heap.c src/Socket.c src/MQTTPacket.c src/Clients.c src/MQTTClient.c src/Log.c src/MQTTPacketOut.c src/MQTTProtocolOut.c src/StackTrace.c src/MQTTPersistenceDefault.c src/utf-8.c src/Messages.c src/SocketBuffer.c src/MQTTProtocolClient.c src/LinkedList.c src/Thread.c src/Tree.c -L INJECT_OPENSSL_LIB  -shared -Wl,-init,MQTTClient_init  -Wl,-soname,libpaho-mqtt3c.so.1
echo "[*] first compile attemtp! wait a second! --------------------------------->"
read tmp
ln -s libpaho-mqtt3c.so.1.0  lib/libpaho-mqtt3c.so.1
ln -s libpaho-mqtt3c.so.1    lib/libpaho-mqtt3c.so

echo "[*] Linking first compile --------------------------------->"

sed -i "s/##MQTTCLIENT_VERSION_TAG##/1.0.3/g; s/##MQTTCLIENT_BUILD_TAG##/Wed Jun 15 09:32:02 IST 2016/g"  src/MQTTClient.c

$TOOLCHAIN -g -fPIC -pie -I $INJECT_OPENSSL_ANDROID -pie -Os -Wall -fvisibility=hidden -o lib/libpaho-mqtt3cs.so.1.0 src/MQTTPersistence.c src/Heap.c src/Socket.c src/SSLSocket.c src/MQTTPacket.c src/Clients.c src/MQTTClient.c src/Log.c src/MQTTPacketOut.c src/MQTTProtocolOut.c src/StackTrace.c src/MQTTPersistenceDefault.c src/utf-8.c src/Messages.c src/SocketBuffer.c src/MQTTProtocolClient.c src/LinkedList.c src/Thread.c src/Tree.c   -shared -Wl,--start-group  -ldl -I $INJECT_OPENSSL_ANDROID -Wl,--end-group -Wl,-init,MQTTClient_init -Wl,-soname,libpaho-mqtt3cs.so.1 -Wl,-no-whole-archive

echo "[*] second compile --------------------------------->"

ln -s libpaho-mqtt3cs.so.1.0  lib/libpaho-mqtt3cs.so.1
ln -s libpaho-mqtt3cs.so.1    lib/libpaho-mqtt3cs.so

echo "[*] Linking second compile --------------------------------->"
sed -i "s/##MQTTCLIENT_VERSION_TAG##/1.0.3/g; s/##MQTTCLIENT_BUILD_TAG##/Wed Jun 15 09:32:12 IST 2016/g"  src/MQTTAsync.c

$TOOLCHAIN -g -fPIC -pie -Os -Wall -fvisibility=hidden -o lib/libpaho-mqtt3a.so.1.0 src/MQTTPersistence.c src/Heap.c src/Socket.c src/MQTTPacket.c src/Clients.c src/Log.c src/MQTTPacketOut.c src/MQTTProtocolOut.c src/StackTrace.c src/MQTTPersistenceDefault.c src/utf-8.c src/Messages.c src/MQTTAsync.c src/SocketBuffer.c src/MQTTProtocolClient.c src/LinkedList.c src/Thread.c src/Tree.c  -shared -Wl,-init,MQTTAsync_init  -Wl,-soname,libpaho-mqtt3a.so.1

echo "[*] third compile --------------------------------->"           
  
ln -s libpaho-mqtt3a.so.1.0  lib/libpaho-mqtt3a.so.1
ln -s libpaho-mqtt3a.so.1    lib/libpaho-mqtt3a.so

echo "[linking third compile] --------------------------------->"
sed -i "s/##MQTTCLIENT_VERSION_TAG##/1.0.3/g; s/##MQTTCLIENT_BUILD_TAG##/Wed Jun 15 09:32:19 IST 2016/g"  src/MQTTAsync.c 

$TOOLCHAIN -g -fPIC -pie -I $INJECT_OPENSSL_ANDROID -pie -Os -Wall -fvisibility=hidden -o build/lib/libpaho-mqtt3as.so.1.0 src/MQTTPersistence.c src/Heap.c src/Socket.c src/SSLSocket.c src/MQTTPacket.c src/Clients.c src/Log.c src/MQTTPacketOut.c src/MQTTProtocolOut.c src/StackTrace.c src/MQTTPersistenceDefault.c src/utf-8.c src/Messages.c src/MQTTAsync.c src/SocketBuffer.c src/MQTTProtocolClient.c src/LinkedList.c src/Thread.c src/Tree.c   -shared -Wl,--start-group  -ldl -I $INJECT_OPENSSL_ANDROID -Wl,--end-group -Wl,-init,MQTTAsync_init -Wl,-soname,libpaho-mqtt3as.so.1 -Wl,-no-whole-archive

echo "[*] fourth compile --------------------------------->"

ln -s libpaho-mqtt3as.so.1.0  lib/libpaho-mqtt3as.so.1
ln -s libpaho-mqtt3as.so.1    lib/libpaho-mqtt3as.so

echo "[*] linking fourth compile --------------------------------->"

echo "[*] starting samples build process --------------------------------->"
echo "[*] --------------------------------->"

#$TOOLCHAIN -fPIC -pie -I src  -L build/lib -o build/lib/MQTTVersion -lpaho-mqtt3a src/MQTTVersion.c -ldl

$TOOLCHAIN -fPIC -pie -I src  -L lib -o lib/MQTTVersion -lpaho-mqtt3c src/MQTTVersion.c -ldl

$TOOLCHAIN -fPIC -pie -o $1 $2   -I src  -L lib -lpaho-mqtt3c

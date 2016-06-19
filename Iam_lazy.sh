if [ "$#" -ne 1 ]; then
    echo ""
    echo ""
    echo "[*] ****Android_MQTT  exec helper******"
    echo "[*]"
    echo "[*]  Author: Benjamin Keil"
    echo "[*]  Email:  roguefendor@gmail.com"
    echo "[*]"
    echo "[*]"
    echo "[*]  Iam_lazy.sh Usage:"
    echo "[*]        Enter path to: <binary>"
    echo "[*]        example: ./Iam_lazy.sh /home/build/client "
    echo "[*]"
    echo "[*]******************************************"
fi
 
cp -r lib/* /system/lib
cp $1 /system/bin

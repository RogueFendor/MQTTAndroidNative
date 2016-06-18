export LD_LIBRARY_PATH="lib/"

if [ "$#" -ne 1 ]; then
    echo ""
    echo ""
    echo "[*] ****Android_MQTT  exec helper******"
    echo "[*]"
    echo "[*]  Author: Benjamin Keil"
    echo "[*]  Email:  roguefendor@gmail.com"
    echo "[*]"
    echo "[*]"
    echo "[*]  exec.sh Usage:"
    echo "[*]        Enter path to: <binary>"
    echo "[*]        example: ./exec.sh /home/build/client "
    echo "[*]"
    echo "[*]******************************************"
fi
 
./$1


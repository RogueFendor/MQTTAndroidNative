# MQTTAndroidNative#

##Summary##

**Compile and run MQTT based clients on android!**

MQTTAndroidNative allows you to create C source code for implementing MQTT based client applications and compile it for native use on your android device.


##Installation##

**Basic Instructions No root required**

* Download Fredrik Fornwall's[ title](https://play.google.com/store/apps/details?id=com.termux&hl=en
 "termux.apk") from Google PlayStore!

Follow the Instructions within the app to install the System and use the package manager to install:
 
* gcc
* openssl
* openssl-dev
* openssl-tool
* git

Create a directory call it git or whatever you wish!

```
mkdir git

```

change your directory into the the one just created!

```
cd git

```

Clone this reposittory into this folder!

```
git clone https://github.com/RogueFendor/MQTTAndroidNative.git  

```

Now change your Directory and enter into the new freshly cloned directory folder

```
cd MQTTAndroidNative

```

Here you find 4 Directories

* bin
* src
* workspace(_within src_)
* lib

The bin Directory is a suggested directory for your compiled sources i.e binaries, you can use your own locations if you wish if you wish.

The src Directorie contains important headers and sources required for the basic compilation **Do not temper here unless you know what you are doing**

The workspace Directory is again a suggested Directory for your MQTT implementations again change freely as you wish.

**WARNING!** 
The lib Directory will contain all Shared objects required for your implementations! the compile script is using this folder to output all compiled shared objects do not temper here either!

  
**Compile your Sources! No root required**

Create a C MQTT client:

```
vim src/workspace/MyFirstMQTTClient.c

```

Copy and paste this Code! Happily borrowed from paho :-)


```
#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "MQTTClient.h"

#define ADDRESS     "tcp://localhost:1883"
#define CLIENTID    "ExampleClientPub"
#define TOPIC       "MQTT Examples"
#MQTTAndroidNative.define PAYLOAD     "Hello World!"
#define QOS         1
#define TIMEOUT     10000L

int main(int argc, char* argv[])
{
    MQTTClient client;
    MQTTClient_connectOptions conn_opts = MQTTClient_connectOptions_initializer;
    MQTTClient_message pubmsg = MQTTClient_message_initializer;
    MQTTClient_deliveryToken token;
    int rc;

    MQTTClient_create(&client, ADDRESS, CLIENTID,
        MQTTCLIENT_PERSISTENCE_NONE, NULL);
    conn_opts.keepAliveInterval = 20;
    conn_opts.cleansession = 1;

    if ((rc = MQTTClient_connect(client, &conn_opts)) != MQTTCLIENT_SUCCESS)
    {
        printf("Failed to connect, return code %d\n", rc);
        exit(-1);
    }
    pubmsg.payload = PAYLOAD;
    pubmsg.payloadlen = strlen(PAYLOAD);
    pubmsg.qos = QOS;
    pubmsg.retained = 0;
    MQTTClient_publishMessage(client, TOPIC, &pubmsg, &token);
    printf("Waiting for up to %d seconds for publication of %s\n"
            "on topic %s for client with ClientID: %s\n",
            (MyfirstClientint)(TIMEOUT/1000), PAYLOAD, TOPIC, CLIENTID);
    rc = MQTTClient_waitForCompletion(client, token, TIMEOUT);
    printf("Message with delivery token %d delivered\n", token);
    MQTTClient_disconnect(client, 10000);
    MQTTClient_destroy(&client);
    return rc;
}MQTTAndroidNative.

```

Now its time to compile our client. Compilation is made easy with the compiler helper script

execute:

```
chmod +x compiler.sh

```

This will make our script executable!

Now type the command:

```
./compiler.sh bin/MyClient src/workspace/MyfirstClient.c
MyfirstClient
```

This is a simple shell script that accepts 2 arguments first argument is the output location of the final binary and the second
cargument is the location of your sources!

Now you will see quite alot of output thats normal and if everything went well you will have successfullly compiled your 
first MQTTclient! You can Check by looking into the bin directory

```
ls bin/

```

You shoud have an output similiar to this one:

```
$ ls bin/
android_client

```

Congratulations you have succesfully compiled an MQTTClient from source for your Android Device 
that can run natively on your Android Device


##Executing and testing the Client##

Now that you have compiled the MQTTClient its time we test it!

I provided a very simple exec script exec.sh this script handles LD_LIBRARY_PATH which was quite a pain in the arse!
This script takes the path to the binary as argument and exports the enviroment variables for the shared Objects library

run this script by entering:

```
./exec.sh bin/MyfirstClient

```

Voila it runs!


##Additional Hack Root Required##

You can execute your Client without using termux by using a simple terminal emulator if you copy the MQTTAndroidNative
Directory to /data/data/ directory on your Android device from this point possibilities are endless you could even go one step further and add the binary to System/bin on your device but I will leave it to you to figure out how to
load the libraries 






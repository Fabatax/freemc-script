#!/bin/bash
if [ "$RAM" = "" ]
then
    RAM=$1
fi
echo "==============="
echo "Thank you for using FreeMC.Host"
echo "Server ID: $(hostname | cut -d '-' -f 1)"
echo "Thank you for using Fabatax's Custom start.sh"
echo "Credits to TheAdminHammer for the bug"
echo "Credits to Fabatax for creating the Shell Script"
echo "Server RAM: "$RAM"MB"
echo "==============="
echo "eula=true" > eula.txt



n=1
CHECK="OK"
if [[ "$CHECK" == *"OK"* ]]; then
    echo "Starting"
elif [[ "$CHECK" == *"nginx"* ]]; then
    echo "Error while requesting server information. Restart and try again"
    exit
else
    echo $CHECK
    exit
fi
VERSION="custom"
if [ "$VERSION" == "custom" ]; then
    echo "Using custom version"
elif [[ "$VERSION" == *","* ]]; then
    V=$(echo $VERSION | cut -d ',' -f 1)
    DL=$(echo $VERSION | cut -d ',' -f 2)
    echo "Downloading and using version "$V
    curl $DL > server.jar 2>/dev/null
else
    echo $VERSION
fi

if [ -e "usercache.json" ]
then
    ucsize=$(wc -c < usercache.json)
    if [ $ucsize -eq 0 ]
    then
        rm usercache.json
    fi
fi
if [ -e "server.jar" ]
then 
    JAR="server.jar"
    echo "Found "$JAR
else
    JAR=""
fi

if [ "$JAR" = "" ]
then
    echo "No server.jar has been found, add one or visit this to pick a version: https://freemc.host/server/$(hostname | cut -d '-' -f 1)/version";
    exit
else
    echo "Starting"
    START="OK"
    if [[ "$START" == *"nginx"* ]]; then
        echo "Error while checking server details."
    else
        echo $START
    fi
    java -Xms128M -Xmx"$RAM"M -jar "$JAR"
fi

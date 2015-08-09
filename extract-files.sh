#!/bin/sh

BASE=../../../vendor/samsung/degaswifi/proprietary
mkdir -p $BASE
for FILE in `cat proprietary-blobs.txt | grep -v "^#"`; do
#    DIR=`dirname $FILE`
#    if [ ! -d $BASE$DIR ]; then
#        echo "making $BASE$DIR..."
#        mkdir -p $BASE$DIR
#    fi
    echo Pulling $FILE to $BASE
#    adb pull $FILE $BASE$FILE
    adb pull $FILE $BASE/
done

./setup-makefiles.sh

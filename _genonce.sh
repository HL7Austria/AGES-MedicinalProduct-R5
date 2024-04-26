#!/bin/bash
publisher_jar=publisher.jar
input_cache_path=./input-cache/
echo Checking internet connection...
curl -sSf tx.fhir.org > /dev/null

if [ $? -eq 0 ]; then
	echo "Online"
	txoption=""
else
	echo "Offline"
	txoption="-tx n/a"
fi

echo "$txoption"

publisher=$input_cache_path/$publisher_jar
java_opts="${JAVA_OPTS:--Xms13g -Xmx13g -XX:+UseG1GC}"
if test -f "$publisher"; then
	java -jar $java_opts -Djava.awt.headless=true $publisher -no-sushi -ig ig.ini $txoption $*

else
	publisher=../$publisher_jar
	if test -f "$publisher"; then
		java -jar $java_opts -Djava.awt.headless=true $publisher -no-sushi -ig ig.ini $txoption $*
	else
		echo IG Publisher NOT FOUND in input-cache or parent folder.  Please run _updatePublisher.  Aborting...
	fi
fi

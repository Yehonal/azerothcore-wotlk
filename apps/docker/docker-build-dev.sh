#!/usr/bin/env bash

cd /azerothcore

bash acore.sh compiler build

echo "Generating confs..."
cp -n "env/dist/etc/worldserver.conf.dockerdist" "env/dist/etc/worldserver.conf"
cp -n "env/dist/etc/authserver.conf.dockerdist" "env/dist/etc/authserver.conf"

echo "Fixing EOL..."
# using -n (new file mode) should also fix the issue
# when the file is created with the default acore user but you
# set a different user into the docker configurations
for file in "env/dist/etc/"*
do
    dos2unix -n $file $file
done

bash acore.sh db-assembler import-all

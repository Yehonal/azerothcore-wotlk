#!/usr/bin/env bash

CTOOLS=${CTOOLS:-OFF}
source "$CUR_PATH/docker-build-prod.sh"

echo "Fixing EOL..."
# using -n (new file mode) should also fix the issue
# when the file is created with the default acore user but you
# set a different user into the docker configurations
for file in "env/dist/etc/"*
do
    dos2unix -n $file $file
done

bash acore.sh db-assembler import-all

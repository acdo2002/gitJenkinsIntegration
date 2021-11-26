#!/bin/bash

name=`git log -1 --oneline`
CommitName=$(echo $name | cut -d ' ' -f 1)
echo ${CommitName}

## build carta-backend
(cd /home/mingyi/jenkins-carta-backend-dev/ ; sudo mkdir ${CommitName})
(cd /home/mingyi/jenkins-carta-backend-dev/${CommitName} ; sudo git clone --recursive https://github.com/CARTAvis/carta-backend.git)
(cd /home/mingyi/jenkins-carta-backend-dev/${CommitName}/carta-backend ; sudo mkdir build)
(cd /home/mingyi/jenkins-carta-backend-dev/${CommitName}/carta-backend/build ; sudo cmake ..)
(cd /home/mingyi/jenkins-carta-backend-dev/${CommitName}/carta-backend/build ; sudo make -j 10)

## build carta performance regression tests
(cd /home/mingyi/jenkins-carta-ICD-dev/ ; sudo mkdir ${CommitName})
(cd /home/mingyi/jenkins-carta-ICD-dev/${CommitName} ; sudo git clone --recursive https://github.com/CARTAvis/carta-backend-ICD-test.git)
(cd /home/mingyi/jenkins-carta-ICD-dev/${CommitName}/carta-backend-ICD-test ; sudo npm install)
(cd /home/mingyi/jenkins-carta-ICD-dev/${CommitName}/carta-backend-ICD-test/protobuf/ ; sudo ./build_proto.sh)

## Prepare the tests
(sudo cp /home/mingyi/carta-ICD-dev/codes/3fd6679/* /home/mingyi/jenkins-carta-ICD-dev/${CommitName}/carta-backend-ICD-test/src/test)
(cd /home/mingyi/jenkins-carta-ICD-dev/${CommitName}/carta-backend-ICD-test/src/test ; sudo sed -i -e 's/3fd6679/'${CommitName}'/g' export_ICD.sh)
(cd /home/mingyi/jenkins-carta-ICD-dev/${CommitName}/carta-backend-ICD-test/src/test ; sudo ./export_ICD.sh)
exit
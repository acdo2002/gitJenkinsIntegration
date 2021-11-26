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
(cd /home/mingyi/jenkins-carta-ICD-dev/${CommitName}/carta-backend-ICD-test ; npm install)
(cd /home/mingyi/jenkins-carta-ICD-dev/${CommitName}/carta-backend-ICD-test/protobuf/ ; ./build_proto.sh)

exit
#!/bin/bash

pushd ./bin
./updateSiteDBPath.sh &&
./startup.sh
popd

#!/bin/bash --login

#Verify variable is provided
if [ "$1" = "" ]; then
        echo -e "Version number not provide"
        exit 1
fi

VERSION=$1

cd /Users/scow/GitHub/IVCharts/ 
sed -i "" "s/\([0-9]\)\.\([0-9]\)\.\([0-9]\)/${VERSION}/g" IVCharts.podspec
git add .
git commit -am "${VERSION}" 
git push
git tag ${VERSION}
git push --tags
pod lib lint
pod trunk push IVCharts.podspec

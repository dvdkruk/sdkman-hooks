#!/bin/bash

VERSION="$1"
BRANCH="RELEASE"

#sanity
if [[ -z "$VERSION" ]]; then
	echo "Usage: release.sh <version>"
	exit 0
fi

#prepare branch
git checkout master
git branch -D "$BRANCH"
git checkout -b "$BRANCH"

#update version
sed -i "s/1.0.0-SNAPSHOT/$VERSION/g" conf/application.conf
sed -i "s/1.0.0-SNAPSHOT/$VERSION/g" .travis.yml
git add conf/application.conf .travis.yml
git commit -m "Update version of $BRANCH to $VERSION"

#push tag
git tag "$VERSION"
git push origin "$VERSION"

#back to master branch
git checkout master

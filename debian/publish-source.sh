#!/bin/bash

set -ex

PKG="${PACKAGE_NAME:-${1}}"
VERSION="${PACKAGE_VERSION:-${2}}"
ORIG_TARBALL="../${PKG}_${VERSION}.orig.tar.gz"

[ -f "${ORIG_TARBALL}" ] || exit 1

VERSION=$(echo "${VERSION}" | awk -F'+' '{print $1}')

rm -rf .pc target build
rm -rf pom.xml* src
rm -f CHANGELOG.md
rm -f LICENSE.md
rm -f NOTICE.md
rm -f README

tar --strip-components=1 -xzf "${ORIG_TARBALL}" "${PKG}-${VERSION}" || exit 1


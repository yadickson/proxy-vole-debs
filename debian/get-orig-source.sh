#!/bin/bash

set -ex

PKG="${PACKAGE_NAME:-${1}}"
VERSION="${PACKAGE_VERSION:-${2}}"
ADD_PATCH="${3:-false}"
ZIPFILE="${PKG}-${VERSION}.zip"
ORIG_TARBALL="../${PKG}_${VERSION}.orig.tar.gz"

[ ! -f "${ORIG_TARBALL}" ] || exit 0

rm -rf "${PKG}"*
rm -f "${ZIPFILE}"

wget -c -t 1 -T 5 "https://github.com/MarkusBernhardt/proxy-vole/archive/proxy-vole-${VERSION}.zip" -O "${ZIPFILE}" || exit 1

unzip "${ZIPFILE}" || exit 1
rm -f "${ZIPFILE}"

mv "${PKG}"* "${PKG}-${VERSION}"

find "${PKG}-${VERSION}" -type f -name '*.png' -exec rm -f '{}' \;
find "${PKG}-${VERSION}" -type f -name '*.java' -exec iconv -f ISO-8859-1 -t UTF-8 '{}' -o '{}'.iconv \; -exec mv '{}'.iconv '{}' \; -exec dos2unix '{}' \;

mv "${PKG}-${VERSION}/README.md" "${PKG}-${VERSION}/README"
cp debian/libproxy-vole-java.pom.xml "${PKG}-${VERSION}/pom.xml"

if [ "${ADD_PATCH}" != "false" ]
then
   while read -r line
   do
      patch -d "${PKG}-${VERSION}" -p1 < "debian/patches/${line}"
   done < debian/patches/series
fi

tar -czf "${ORIG_TARBALL}" --exclude-vcs "${PKG}-${VERSION}" || exit 1

rm -rf "${PKG}-${VERSION}"
rm -f "${ZIPFILE}"


#!/bin/bash

set -ex

PKG="${1}"
VER="${2}"
ZIPFILE="${PKG}-${VER}.zip"
ORIG_TARBALL="../${PKG}_${VER}.orig.tar.xz"

[ ! -f "${ORIG_TARBALL}" ] || exit 0

rm -rf "${PKG}"*
rm -rf "${PKG}-${VER}"
rm -f "${ZIPFILE}"

wget -c -t 1 -T 5 "https://github.com/MarkusBernhardt/proxy-vole/archive/proxy-vole-${VER}.zip" -O "${ZIPFILE}" || exit 1

unzip "${ZIPFILE}" || exit 1

rm -f "${ZIPFILE}"

mv "${PKG}"* "${PKG}-${VER}"

rm -f "${PKG}-${VER}"/.git*

tar -cJf "${ORIG_TARBALL}" --exclude-vcs "${PKG}-${VER}" || exit 1

rm -rf "${PKG}-${VER}"
rm -f "${ZIPFILE}"


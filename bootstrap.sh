#!/bin/bash

pushd out/target/product/pascal2/root/
find . | cpio -o -H newc | gzip -n > ../bootstrap/boot.gz
popd

pushd out/target/product/pascal2/recovery/root/
find . | cpio -o -H newc | gzip -n > ../bootstrap/recovery.gz
popd



exit 0

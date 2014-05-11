NAME="glitch_switch"
pushd export


pushd linux/cpp
rm -rf "$NAME-linux"
cp -rf bin "$NAME-linux"
tar -czf "$NAME-linux.tar.gz" "$NAME-linux"
mv "$NAME-linux.tar.gz" ../../../
rm -rf "$NAME-linux"
popd

popd #export

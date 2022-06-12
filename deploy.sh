git config --global --add safe.directory $(pwd)/askcos-deploy
git config --global --add safe.directory $(pwd)/askcos-site
git config --global --add safe.directory $(pwd)/askcos-core
cd askcos-deploy/bkms-data
git lfs pull
cd ../
bash build.sh

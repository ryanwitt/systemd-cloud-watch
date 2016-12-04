#!/usr/bin/env bash


rm systemd-cloud-watch_linux

set -e

cd /gopath/src/github.com/advantageous/systemd-cloud-watch/
source ~/.bash_profile
export GOPATH=/gopath


/usr/lib/systemd/systemd-journald &

for x in {1..100}
do
    for i in {1..7}
    do
        systemd-cat echo "$i JOURNAL D TEST $x"
    done
done


echo "Running go clean"
go clean
echo "Running go get"
go get
echo "Running go build"
go build
echo "Running go test"
go test -v github.com/advantageous/systemd-cloud-watch/cloud-watch
echo "Renaming output to _linux"
mv systemd-cloud-watch systemd-cloud-watch_linux

pkill -9 systemd

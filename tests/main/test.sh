#!/bin/bash
shopt -s nullglob
if [ ! -d "vemu" ]; then
    git clone https://github.com/GonzaloAlvarez/qemuvmman vemu
    cd vemu
    ./vm new templates/ubuntu22-l
    VMS=(VM*)
    vmname=${VMS[0]}
    ./vm run $vmname
    echo "waiting for machine to be up"
    sleep 20
else
    cd vemu
    VMS=(VM*)
    vmname=${VMS[0]}
    ./vm ssh $vmname rm -Rf provisioning
    ./vm ssh $vmname rm -f bootstrap.sh
fi
./vm ssh $vmname mkdir provisioning
for i in ../../../*; do
    if [ "$(basename "$i")" != "tests" ]; then
        ./vm scp $vmname -rqp "$(realpath $i)"
        ./vm ssh $vmname mv "$(basename $i)" provisioning/
    fi
done
./vm ssh $vmname -t "wget -q -O - https://raw.githubusercontent.com/GonzaloAlvarez/provisioning/main/bootstrap.sh | bash"

#!/bin/bash
set -e

folder=$1

for dir in ${folder}/*/
do
    echo "migrating ${dir}"
    opm alpha bundle generate --directory ${dir} --output-dir ${dir}
    dir=${dir%*/}
    version=${dir##*/} 
    echo "LABEL com.redhat.openshift.versions=v4.5" >> bundle.Dockerfile
    mv bundle.Dockerfile bundle-${version}.Dockerfile
    echo "migrated ${dir}"
done

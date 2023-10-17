#!/usr/bin/env fish
echo "Download & install gcloud: https://cloud.google.com/sdk/docs/install"
echo "Place the unzipped folder in ~/bin"
read -P "Hit return when you've done this (or Crtl+C to cancel"
fish_add_path ~/bin/google-cloud-sdk/bin
gcloud auth login

function mk_config
    # mk_config $NAME $GCP_PROJECT
    gcloud config configurations create $argv[1]
    gcloud config set project $argv[2]
    # we use the same zone/region for all our stuff
    gcloud config set account ephetteplace@cca.edu
    gcloud config set compute/zone us-west1-b
    gcloud config set compute/region us-west1
end

mk_config prod cca-web-0
mk_config staging cca-web-staging
mk_config integrations cca-integrations
echo "Finishing creating gcloud configurations, here's the list:"
gcloud config configurations list

# install gke auth plugin, takes a while
gcloud components install gke-gcloud-auth-plugin
# get k8s cluster creds
gcloud config configurations activate prod
gcloud container clusters get-credentials ccaedu-prod
gcloud config configurations activate staging
gcloud container clusters get-credentials ccaedu-stg

# make kubectl contexts match gcloud configs
kubectl config rename-context gke_cca-web-0_us-west1-b_ccaedu-prod prod
kubectl config rename-context gke_cca-web-staging_us-west1-b_ccaedu-stg staging

git clone git@github.com:cca/libraries-k8s ~/Code/k8s
cd ~/Code/k8s
./install.sh

echo "gcloud & k8s setup done! You should be able to switch between clusters by changing the 'NS' namespace env var. Try 'set -x NS moo-stg1' and 'k get pods', for instance."

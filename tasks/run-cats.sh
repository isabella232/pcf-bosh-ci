#!/usr/bin/env bash

set -e

cat <<CFCATSCONFIG > cf-cats-config.json
{
  "api": "api.$(jq -r .sys_domain terraform-state/metadata)",
  "apps_domain": "$(jq -r .apps_domain terraform-state/metadata)",
  "admin_user": "admin",
  "admin_password": "$(bosh int cf-vars-store/*-cf-vars-store.yml --path /uaa_scim_users_admin_password)",
  "skip_ssl_validation": true,
  "use_http": true,
  "backend": "diego",
  "include_apps": true,
  "include_backend_compatibility": false,
  "include_detect": true,
  "include_docker": true,
  "include_internet_dependent": true,
  "include_privileged_container_support": true,
  "include_route_services": true,
  "include_routing": true,
  "include_security_groups": false,
  "include_services": true,
  "include_ssh": true,
  "include_sso": true,
  "include_tasks": false,
  "include_v3": true,
  "include_zipkin": true
}
CFCATSCONFIG

export CONFIG="$PWD/cf-cats-config.json"

export CF_GOPATH="/go/src/github.com/cloudfoundry/"

echo "Moving cf-acceptance-tests onto the gopath..."
mkdir -p $CF_GOPATH
cp -R cf-acceptance-tests $CF_GOPATH

cd /go/src/github.com/cloudfoundry/cf-acceptance-tests

./bin/test \
-keepGoing \
-randomizeAllSpecs \
-skipPackage=helpers \
-slowSpecThreshold=120 \
-nodes=6

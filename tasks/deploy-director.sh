#!/usr/bin/env bash

set -e

cp bosh-state/bosh-state.json new-bosh-state/bosh-state.json
cp bosh-creds/bosh-creds.yml new-bosh-creds/bosh-creds.yml

bosh create-env bosh-deployment/bosh.yml \
  --state new-bosh-state/bosh-state.json \
  --ops-file bosh-deployment/external-ip-not-recommended.yml \
  --ops-file bosh-deployment/gcp/cpi.yml \
  --ops-file bosh-deployment/uaa.yml \
  --ops-file pcf-bosh-ci/ops-files/uaa-with-external-ip.yml \
  --ops-file pcf-bosh-ci/ops-files/credhub.yml \
  --ops-file pcf-bosh-ci/ops-files/director-overrides.yml \
  --vars-store new-bosh-creds/bosh-creds.yml \
  --vars-file bosh-vars/bosh-vars.yml \
  --var file_path_to_credhub_release="file://$PWD/credhub-release/credhub-0.3.0.tgz" \
  --var gcp_credentials_json="$GOOGLE_JSON_KEY" \
  --var external_ip="$(jq -r .director_external_ip terraform-state/metadata)"

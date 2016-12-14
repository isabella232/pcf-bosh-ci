# PCF BOSH CI

PCF BOSH CI is a collection of tasks and ops-files to help deploy and manage PCF BOSH.

## BOSH

BOSH is deployed using [https://github.com/cloudfoundry/bosh-deployment](bosh-deployment). The vars necessary to deploy with [tasks/deploy-director.sh](deploy-director.sh) are the same as bosh-deployment with one addition:

- **credhub_aes_key**: A 128-bit hex-encoded AES key (e.g. D673ACD01DA091B08144FBC8C0B5F524)

## Cloud Foundry

Cloud Foundry is deployed using [https://github.com/cloudfoundry/cf-deployment](cf-deployment). The vars necessary to deploy are the same as cf-deployment with some additions. See the [tasks/deploy-pcf.sh](deploy-pcf.sh) task for the list of variables.
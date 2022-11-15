#!/usr/bin/env bash

# Copyright 2022 TriggerMesh Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -eu
set -o pipefail

# declare an array variable
declare -a tmSources=(
	"awscloudwatchlogs"
	"awscloudwatch"
	"awscodecommit"
	"awscognitoidentity"
	"awscognitouserpool"
	"awsdynamodb"
	"awskinesis"
	"awsperformanceinsights"
	"awssns"
	"azureiothub"
	"azurequeuestorage"
	"googlecloudpubsub"
	)

# expects https://github.com/triggermesh/triggermesh cloned

rm -rf .local/tmp
mkdir -p .local/tmp/config

for source in ${tmSources[@]}; do
	adapter="${source}source-adapter"
	crd="300-${source}source.yaml"
	echo "Updating ${adapter}"

	if test -f "cmd/${adapter}"; then
		# Save to tmp if it exists
		mv 	cmd/${adapter} .local/tmp/${adapter}
	fi
	cp -r ../triggermesh/cmd/$adapter cmd/${adapter}


	if test -f "config/${crd}"; then
		# Save to tmp if it exists
		mv config/${crd} .local/tmp/config
	fi
	cp ../triggermesh/config/$crd config/${crd}
done

updateMultiCRDSource(){
	source=$1
	crds=$2

	adapter="${source}source-adapter"
	echo "Updating ${adapter}"

	if test -f "cmd/${adapter}"; then
		# Save to tmp if it exists
		mv 	cmd/${adapter} .local/tmp/${adapter}
	fi
	cp -r ../triggermesh/cmd/$adapter cmd/${adapter}

	for c in ${crds[@]}; do
		crd="300-${c}source.yaml"
		if test -f "config/${crd}"; then
			# Save to tmp if it exists
			mv config/${crd} .local/tmp/config
		fi
		cp ../triggermesh/config/$crd config/${crd}
	done
}


source="awssqs"
crds=(
	"awssqs"
	"awseventbridge"
	"awss3"
)
updateMultiCRDSource $source $crds

source="azureeventhub"
crds=(
	"azureeventhub"
	"azureactivitylogs"
	"azureblobstorage"
	"azureeventgrid"
)
updateMultiCRDSource $source $crds

source="azureservicebus"
crds=(
	"azureservicebusqueue"
	"azureservicebustopic"
)
updateMultiCRDSource $source $crds

source="googlecloudpubsub"
crds=(
	"googlecloudauditlogs"
	"googlecloudbilling"
	"googlecloudiot"
	"googlecloudpubsub"
	"googlecloudsourcerepositories"
	"googlecloudstorage"
)
updateMultiCRDSource $source $crds

echo "Done."
echo "This is an experimental script. Make sure the result is ok and manually delete .local/tmp contents."



# Azure Service Bus must be treated on its own
package main

import (
	"knative.dev/pkg/injection/sharedmain"

	// AWS Event Sources
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/awscloudwatchlogssource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/awscloudwatchsource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/awscodecommitsource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/awscognitoidentitysource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/awscognitouserpoolsource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/awsdynamodbsource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/awseventbridgesource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/awskinesissource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/awsperformanceinsightssource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/awss3source"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/awssnssource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/awssqssource"

	// Azure Event Sources
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/azureactivitylogssource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/azureblobstoragesource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/azureeventgridsource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/azureeventhubssource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/azureiothubsource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/azurequeuestoragesource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/azureservicebusqueuesource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/azureservicebussource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/azureservicebustopicsource"

	// GCP Event Sources
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/googlecloudauditlogssource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/googlecloudbillingsource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/googlecloudpubsubsource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/googlecloudsourcerepositoriessource"
	"github.com/triggermesh/triggermesh/pkg/sources/reconciler/googlecloudstoragesource"
)

func main() {
	sharedmain.Main("triggermesh-controller",
		// AWS Event Sources
		awscloudwatchlogssource.NewController,
		awscloudwatchsource.NewController,
		awscodecommitsource.NewController,
		awscognitoidentitysource.NewController,
		awscognitouserpoolsource.NewController,
		awsdynamodbsource.NewController,
		awseventbridgesource.NewController,
		awskinesissource.NewController,
		awsperformanceinsightssource.NewController,
		awss3source.NewController,
		awssnssource.NewController,
		awssqssource.NewController,

		// Azure Event Sources
		azureactivitylogssource.NewController,
		azureblobstoragesource.NewController,
		azureeventgridsource.NewController,
		azureeventhubssource.NewController,
		azureiothubsource.NewController,
		azurequeuestoragesource.NewController,
		azureservicebusqueuesource.NewController,
		azureservicebussource.NewController,
		azureservicebustopicsource.NewController,

		// GCP Event Sources
		googlecloudauditlogssource.NewController,
		googlecloudbillingsource.NewController,
		googlecloudpubsubsource.NewController,
		googlecloudsourcerepositoriessource.NewController,
		googlecloudstoragesource.NewController,
	)
}

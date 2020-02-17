[![CircleCI](https://circleci.com/gh/binxio/azure-toolbox.svg?style=svg)](https://circleci.com/gh/binxio/azure-toolbox)

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Microsoft_Azure_Logo.svg/640px-Microsoft_Azure_Logo.svg.png" width="300">

# [azure-toolbox](https://hub.docker.com/repository/docker/binxio/azure-toolbox)

A toolbox for deploying and managing infrastructure on Azure! w(-.-)w

## Image Details
| Heading | Details |
| --- | --- |
| Image Base | Centos 8 |
| Tools Installed | kubectl<br>terraform<br>azure-cli<br>azure-functions |

## Usage
You may use this image in a CI pipeline or locally by running:
`docker run -it --rm -e ARM_SUBSCRIPTION_ID='{{ insert subscription ID }}' -e ARM_CLIENT_ID='{{ insert client ID }}' -e ARM_CLIENT_SECRET={{ $(cat ~/.secrets/az_secret) }} -e ARM_TENANT_ID='{{ insert tenant ID }}' -v {{ /Users/your.name/project:/home }} binxio/azure-toolbox`

## Environment Variables
| Name  | Value | Why? |
| :---: | ----- | ---- |
| *ARM_SUBSCRIPTION_ID* | From Azure->Subscriptions | For terraform to deploy to the correct subscription. |
| *ARM_CLIENT_ID* | From Azure->App Registrations | The client ID for logging in using a service principal. |
| *ARM_CLIENT_SECRET* | From Azure->App Registrations | The client secret to use the service principal. I recommend storing this as a file instead of passing it directly. |
| *ARM_TENANT_ID* | From Azure->App Registrations | The tenant ID, also called Directory ID. |
 

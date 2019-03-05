# docker-cd-services

This repository contains files used to run Tridion Content Delivery microservices in Docker containers.

## Installing

### Before you begin

In addition to the files in this repository, you will also need the Tridion installation files. Since these files are proprietary and commercial, they are not included in this repository. Specifically, you will need the `Database` folder from the GA installation and either the `Content Delivery` folder *or* of the latest cumulative hotfix for the CD services. The hotfix is highly recommended, if available for the version you are trying to run.

### Steps

The following steps are needed for the initial setup of the containers:

1. Clone the repository (or download the sources and extract them to a folder of your choice)
1. Copy the `standalone` folder from the installation media to each of the service directories (e.g. copy `roles\discovery\standalone` into `docker-cd-services\discovery\`).
1. Add your `cd_licenses.xml` file to the `ext-config` folder of each service.
1. Currently, the database image (`broker-db`) does not contain any Tridion databases. The easiest way to fix that is to start the container and then run the standard database installation script from your Tridion installation media:
   * Run `docker-compose up -d broker-db` in a command prompt from the root directory. This will start the database container with Microsoft SQL Server running on port 1434.
   * Run the following in PowerShell from the `Database\mssql` folder of your Tridion installation media (***Note:*** this can only be done on a Windows machine):
   `& '.\Install Content Data Store.ps1' -NonInteractive -DatabaseServer 'localhost,1434' -DatabaseName broker -AdministratorUserPassword '5STuiNhD#T6j' -DatabaseUserName broker_user -DatabaseUserPassword 'IDbC%h$F5i2M'`
1. Run `docker-compose build` to build the images (only needed when the sources change)

## Starting the containers

Once you have built the images, you can start the stack by running `docker-compose up -d` in a command prompt from the root directory..

## Stopping the containers

To stop all of the containers in the stack, enter `docker-compose down` in a command prompt from the root directory.

## Configuring

The following configuration settings are available in the `.env` file:

| Variable name         | Description |
| --------------------- | ----------- |
| database_port_on_host | The port to use on the host for the database. Defaults to 1434 to avoid conflicts if you are already running Microsoft SQL Server on the host (default port for SQL Server is 1433) |
| database_sa_password  | The password to use for the `sa` user. Defaults to a generated strong password. If you change this before installation, don't forget to modify the `AdministratorUserPassword` parameter in the PowerShell command to match. |
| service_version       | The version of the Tridion services that you are using. This is mainly used as a tag for the images, allowing you to create multiple stacks for different versions of Tridion. |
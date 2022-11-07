[![Enterprise Modules](https://raw.githubusercontent.com/enterprisemodules/public_images/master/banner1.jpg)](https://www.enterprisemodules.com)

# Demo Puppet implementation

This repo contains a demonstration of a simple database installation. It uses the [`ora_profile`](https://forge.puppet.com/enterprisemodules/ora_profile) module to get a quick and easy start.

The name of the node indicates which version of Oracle will be installed in it i.e. db112 has version 11.2. This demo is ready for Puppet 4,5,6 and 7.

This demo also contains a multi-home multi-database example. This is node is named `dbxxx`. It contains three homes:

- Oracle 12.2
- Oracle 18
- Oracle 19
- Oracle 21

And a database for every home:

- DB122
- DB180
- DB190
- DB210

This is a perfect setup for when you need multiple versions of an Oracle database running during a transition periode.

## Starting the nodes masterless

All nodes are available to test with Puppet masterless. To do so, add `ml-` for the name when using vagrant:

```bash
vagrant up <ml-db112|ml-db121|ml-db122|ml-db180|ml-db190|ml-db210|ml-dbxxx>
```

## Starting the nodes with PE

You can also test with a Puppet Enterprise server. To do so, add `pe-` for the name when using vagrant in the following order:

```bash
vagrant up pe-dbmaster
vagrant up <pe-db112|pe-db121|pe-db122|pe-db180|pe-db190|pe-db210|pe-dbxxx>
```

## Required software

The software must be placed in `modules/software/files`. It must contain the next files:

### Puppet Enterprise (Not needed when using masterless deployments)

- [puppet-enterprise-2021.5.0-el-8-x86_64.tar.gz (Extracted tar)](https://puppet.com/download-puppet-enterprise)

### Oracle Database version 21.0.0.0

- `LINUX.X64_213000_db_home.zip`
- `p6880880_122010_Linux-x86-64.zip`  (OPatch version 12.2.0.1.33)
- `p34526142_210000_Linux-x86-64.zip` (21c OCT2022RU)

### Oracle Database version 19.0.0.0

- `LINUX.X64_193000_db_home.zip`
- `p6880880_122010_Linux-x86-64.zip`  (OPatch version 12.2.0.1.33)
- `p34416665_190000_Linux-x86-64.zip` (19c OCT2022RU)
- `p34411846_190000_Linux-x86-64.zip` (19c OCT2022RU OJVM)

### Oracle Database version 18.0.0.0

- `LINUX.X64_180000_db_home.zip`
- `p6880880_122010_Linux-x86-64.zip`  (OPatch version 12.2.0.1.33)
- `p32524152_180000_Linux-x86-64.zip` (18c APR2021RU
- `p32552752_180000_Linux-x86-64.zip` (18c APR2021RU OJVM

### Oracle Database version 12.2.0.1

- `linuxx64_12201_database.zip`
- `p6880880_122010_Linux-x86-64.zip`  (OPatch version 12.2.0.1.33)
- `p27468969_122010_Linux-x86-64.zip`

### Oracle Database version 12.1.0.2

- `linuxamd64_12102_database_1of2.zip`
- `linuxamd64_12102_database_2of2.zip`

### Oracle Database version 11.2.0.4

- `p13390677_112040_Linux-x86-64_1of7.zip`
- `p13390677_112040_Linux-x86-64_2of7.zip`

### Oracle Database version 18.0.0.0 on Windows

- `WINDOWS.X64_180000_db_home.zip`

and the Puppet agent for Windows:

- `puppet-agent-6.4.2-x64.msi`

You can download these file from
[here](http://support.oracle.com)
or
[here](https://www.oracle.com/database/technologies/oracle-database-software-downloads.html)

## Running the Windows demos

Since May 2019, our modules also support Windows. The demo is changed to run on windows too. because of Powershell security requirements, however, vagrant cannot do the whole Oracle/puppet setup. You must start Puppet from the machine itself. First step is to provision the system and get Puppet installed.

```bash
vagrant up --no-provision ml-db180
```

After this is finished, open the VirtualBox console and log into the Windows machine with the `Administrator` account. The password of the Vagrant box is `vagrant`. The start the Command Prompt and run Puppet from there:

```bash
puppet apply c:\vagrant\manifests\site.pp -t
```

This will start a normal Puppet run and install and manage Oracle.

## Common issues

- Sometimes Linux virtual machine hangs while ssh connection during executions of vagrant script. The way to fix it is log in to the machine, as root, and run dhclient.

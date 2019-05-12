[![Enterprise Modules](https://raw.githubusercontent.com/enterprisemodules/public_images/master/banner1.jpg)](https://www.enterprisemodules.com)
# Demo Puppet implementation

This repo contains a demonstration of a simple database installation. It uses the [`ora_profile`](https://forge.puppet.com/enterprisemodules/ora_profile) module to get a quick and easy start.

The name of the node indicates which version of Oracle will be installed in it i.e. db112 has version 11.2. This demo is ready for Puppet 4,5 and 6.
## Starting the nodes masterless

All nodes are available to test with Puppet masterless. To do so, add `ml-` for the name when using vagrant:

```
$ vagrant up <ml-db112|ml-db121|ml-db122|ml-db180|ml-db193>
```

## Staring the nodes with PE

You can also test with a Puppet Enterprise server. To do so, add `pe-` for the name when using vagrant:

```
$ vagrant up pe-dbmaster
$ vagrant up <pe-db112|pe-db121|pe-db122|pe-db180|pe-db193>
```

## ordering

You must always use the specified order:

1. master
2. <db112|db121|db122|db180|db193>

## Required software

The software must be placed in `modules/software/files`. It must contain the next files:

### Puppet Enterprise (Not needed when using masterless deployments)
- [puppet-enterprise-2018.1.3-el-7-x86_64.tar.gz (Extracted tar)](https://puppet.com/download-puppet-enterprise)

### Oracle Database version 19.3.0.0
-LINUX.X64_193000_db_home.zip

### Oracle Database version 18.0.0.0
- LINUX.X64_180000_db_home.zip

### Oracle Database version 12.2.0.1
- LINUX.X64_180000_db_home.zip
- p6880880_121010_Linux-x86-64.zip (Opatch version)

### Oracle Database version 12.2.0.1
- linuxx64_12201_database.zip
- p6880880_121010_Linux-x86-64.zip (Opatch version)
- p27468969_122010_Linux-x86-64.zip

### Oracle Database version 12.1.0.2
- linuxamd64_12102_database_1of2.zip
- linuxamd64_12102_database_2of2.zip

### Oracle Database version 11.2.0.4
- p13390677_112040_Linux-x86-64_1of7.zip
- p13390677_112040_Linux-x86-64_2of7.zip

You can download these file from
[here](http://support.oracle.com)
or
[here](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/oracle12c-linux-12201-3608234.html)

### Common issues
- Sometimes virtual machine hangs while ssh connection during executions of vagrant script. The way to fix it is log in to the machine, as root, and run dhclient. 

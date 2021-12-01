Linux 64-bit Progress OpenEdge RDBMS v12.3 - Docker Container Image

The Docker container image for Progress OpenEdge RDBMS includes a lightweight version of Progress OpenEdge RDBMS 
and uses CentOS as the container OS.
===========================================================================================================

Date: March, 2020
--------------------------------
Copyright (c) 1984-2020 Progress Software Corporation.  All rights reserved.


To view the list of product notes and known issues, please go to: 
https://docs.progress.com/category/whats_new.


To view the complete documentation on the container image for Progress OpenEdge RDBMS, please go to:
https://docs.progress.com/bundle/database_docker_container


CHANGE LOG

2020-03-27
==========

Features
--------
* Base Images for 12.2.0 Progress OpenEdge RDBMS (Enterprise RDBMS and Advanced Enterprise RDBMS)
* Support for deployment of OEDB using 4 creation modes
** customDB: Using .df, .st or .d files
** backupDB: Using backup files
** sampleDB: Using shipped OpenEdge Sample DB
** externalDB: Using database copy provided in host filesystem
* Certified host environment: RHEL + Docker-EE
* Lightweight Image
* Inbuilt Fluentbit process forwards logs to sysout by default
* Certified on Java 11
* Targeted for CI/CD use
* No persistence of data

2020-08-31
==========

Features
--------
* Base Images for 12.5.0 Progress OpenEdge RDBMS (Enterprise RDBMS and Advanced Enterprise RDBMS)

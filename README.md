# PAPB Installation

## Prerequisite

First you must have docker installed. [Follow the steps on official docker website.](https://docs.docker.com/engine/installation/) 

## Installation

PAPB can be installed on two types of nodes. 

### 1. Gateway or Edge Node :
A client node that does not do any cluster data processing or storage. Client nodes have BigData systems binaries installed in them for communication. If you have a client node in your cluster then it would be best to install PAPB on that. To install PAPB execute client.sh file in your terminal

`$./create-client.sh hdp edgenode sourceserver username`

WHERE: 

**hdp:** represents the big data deployment environment you are using. Right now this works only for hdp (Horthonworks Data Platform). Future releases will also include chd (Cloudera).

**sourceserver:** Is the node where hadoop banaries will be copied from. 
username: Is the username that has permission on the source server. 

### 2. Normal Nodes: 
We consider normal nodes to be nodes that does not have client binaries installed in them but they can communicate with the cluster. In order words they are within the same network as the cluster. To install PAPB in a normal node execute the command below in your terminal. 

`$./create-client.sh hdp normalnode sourceserver username`

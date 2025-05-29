# OKD vRAN Configuration
This repository contains some very useful .yaml files to get your OKD single node deployment up and running easily.
To install them, just run "oc apply -f filename.yaml" on your client with oc installed.

Some files can be installed as is, such as:
- disable-ntp.yaml
- enable-sctp.yaml
- ip-forward-sysctl.yaml
- realtime.yaml

while the rest require some edits.

The OKD documentation is a great place if you need more info. This link is also a good starting point: https://docs.okd.io/latest/edge_computing/ztp-reference-cluster-configuration-for-vdu.html

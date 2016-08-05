# vagrant-smokeping
SmokePing VM using Vagrant and Ubuntu/Trusty64 base box
Uses Ansible for SmokePing target generation and provisioning of software within the base box.  

### Pre-Requisites
Must have Ansible installed within Vagrant host.  Tested with Vagrant 1.8.4 on OS X and Linux running Ansible 2.1.0.0 on each, but should work with earlier versions of each as appropriate.
It is also possible to set up provisioner using `ansible_local` within Vagrantfile, but would require rework of Ansible playbook to capture appropriate file locations.

### Usage
Uses Ansible with jinja2 template to build Targets file for Smokeping.  Variables for hosts are stored within the `smokeping.yml` file.
Hosts to ping will need to be given a name and an ip address (could also use DNS name, but have not tried).  If adding additional hosts to either IPv4 or IPv6 sections, please use proper spaces, otherwise YAML will fail.  Do not use tabs unless editor has tab-to-space conversion

1. Clone repo
2. Enter cloned repo directory
2. Edit `smokeping.yml` file with appropriate host values based on deployment need
3. Execute `vagrant up`.  Ansible will gather facts, change timezone, generate the Targets file, perform SmokePing installation, move files around, then restart the service.  If required, `Vagrantfile` can be edited to reflect proper bridged interface based on platform.  Otherwise, a menu prompt will be presented to user based on desired "bridged" interface
4. Wait ~10 minutes.  Access smokeping on localhost through `http://{{ip.address}/cgi-bin/smokeping.cgi`, where `{{ip.address}}` is the bridged IP address of the Vagrant VM.  This information will be shown through `ifconfig eth1` output from shell provisioner.
5. SmokePing will generate plots based on 20 pings every 5 minutes, equally spaced.

### Modifying Hosts to Ping
The YAML file also contains `IPv4_Hosts` and `IPv6_Hosts` sections.  These variable sections are lists of dictionaries for each device that is to be pinged by the SmokePing container.  To edit these hosts, please use the following syntax

* Each member of the list will need to start (8) spaces in, followed by a `-`, to keep with formatting
* The name of the host can include spaces, numbers, etc -- but cannot include periods.  General "website username" rules apply
* The address portion of the list will need to be either the IP address (preferred) or possibly the DNS name.  Given that this may be run from a local laptop, DNS may not be available
* Formatting (use of `name:` and `address:`) is critical to SmokePing targets generation.  Please don't use capitals or omit one or the other keys
* Separate each key:value pair with a comma and a single space as in `- {name: Router1, address: 10.255.255.1}`
* IPv6 address entries will need to be encapsulated in "double quotes" (`"`) due to the colon interfering with the key:value pairs in the dictionary

### Errata or Bugs

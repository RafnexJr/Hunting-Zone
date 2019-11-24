# API token of Digital Ocean
do_token = ""
# Digital Ocean region
do_region = ""
# Digital Ocean image ("centos-7-x64" and "ubuntu-18-04-x64" are tested)
do_image = ""
# Digital Ocean size (min. s-2vcpu-4gb)
do_size = ""
# Location of the public key of the local machine -> "/home/$USER/.ssh/id_rsa.pub"
pub_key = ""
# Location of the private key of the local machine -> "/home/$USER/.ssh/id_rsa"
pvt_key = ""
# MD5 fingerprint of public key that should be installed on the machines -> calculate with this command:
# "ssh-keygen -E md5 -lf /home/$USER/.ssh/id_rsa.pub | awk '{print $2}'"
ssh_fingerprint = ""
# Domain on which the A records should be created
domain = ""
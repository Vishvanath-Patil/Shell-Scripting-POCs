To use this script, make sure you have the AWS CLI installed and configured with your access key and secret key. Replace the placeholder values in the script with your actual parameters, such as the image-id, security-group-ids, key-name, subnet-id, and so on.

Save the script to a file (e.g., ec2_provision.sh), make it executable (chmod +x ec2_provision.sh), and then run it (./ec2_provision.sh).

The script will create an EC2 instance based on the provided parameters, wait for the instance to be in the running state, add optional name and custom tags, and finally display the instance ID and public IP address.

Please note that you'll need to replace the placeholder values (ami-12345678, sg-12345678, subnet-12345678, your-key-pair) with your actual values from your AWS account.






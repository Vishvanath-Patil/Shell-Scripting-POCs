#!/bin/bash

# Script to automate EC2 instance provisioning

# Set your AWS region
AWS_REGION="us-east-1"

# Set your instance parameters
INSTANCE_TYPE="t2.micro"
SECURITY_GROUP_ID="sg-12345678"
KEY_PAIR_NAME="your-key-pair"
SUBNET_ID="subnet-12345678"

# Set optional parameters
INSTANCE_NAME="MyInstance"
TAG_KEY="Environment"
TAG_VALUE="Production"

# Create the EC2 instance
echo "Creating EC2 instance..."
INSTANCE_ID=$(aws ec2 run-instances \
  --region $AWS_REGION \
  --image-id ami-12345678 \
  --instance-type $INSTANCE_TYPE \
  --security-group-ids $SECURITY_GROUP_ID \
  --key-name $KEY_PAIR_NAME \
  --subnet-id $SUBNET_ID \
  --query 'Instances[0].InstanceId' \
  --output text)

# Wait for the instance to be in the running state
echo "Waiting for the instance to start..."
aws ec2 wait instance-running --region $AWS_REGION --instance-ids $INSTANCE_ID

# Add a name tag to the instance
if [ -n "$INSTANCE_NAME" ]; then
  echo "Tagging the instance..."
  aws ec2 create-tags --region $AWS_REGION --resources $INSTANCE_ID --tags Key=Name,Value=$INSTANCE_NAME
fi

# Add custom tags to the instance
if [ -n "$TAG_KEY" ] && [ -n "$TAG_VALUE" ]; then
  echo "Adding custom tags..."
  aws ec2 create-tags --region $AWS_REGION --resources $INSTANCE_ID --tags Key=$TAG_KEY,Value=$TAG_VALUE
fi

# Get information about the instance
echo "Instance created successfully."
echo "Instance ID: $INSTANCE_ID"
echo "Public IP: $(aws ec2 describe-instances --region $AWS_REGION --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)"

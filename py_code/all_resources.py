import boto3

def list_resources_per_region():
    # Initialize a Boto3 client
    ec2_client = boto3.client('ec2')
    rds_client = boto3.client('rds')
    s3_client = boto3.client('s3')
    elbv2_client = boto3.client('elbv2')
    subnet_client = boto3.client('ec2')
    vpc_client = boto3.client('ec2')

    # Get a list of AWS regions
    regions = [region['RegionName'] for region in ec2_client.describe_regions()['Regions']]

    for region in regions:
        print(f"Region: {region}")

        # List EC2 instances
        print("EC2 Instances:")
        ec2_instances = ec2_client.describe_instances()['Reservations']
        for reservation in ec2_instances:
            for instance in reservation['Instances']:
                print(f"  - Instance ID: {instance['InstanceId']}")
                print(f"    Instance Type: {instance['InstanceType']}")
                print(f"    State: {instance['State']['Name']}")


        # List RDS instances
        print("RDS Instances:")
        rds_instances = rds_client.describe_db_instances()['DBInstances']
        for rds_instance in rds_instances:
            print(f"  - DB Instance Identifier: {rds_instance['DBInstanceIdentifier']}")
            print(f"    Engine: {rds_instance['Engine']}")
            print(f"    Status: {rds_instance['DBInstanceStatus']}")


        # List S3 buckets
        print("S3 Buckets:")
        s3_buckets = s3_client.list_buckets()['Buckets']
        for bucket in s3_buckets:
            print(f"  - Bucket Name: {bucket['Name']}")
            print(f"    Creation Date: {bucket['CreationDate']}")


        # List Elastic Load Balancers
        print("Elastic Load Balancers:")
        elbs = elbv2_client.describe_load_balancers()['LoadBalancers']
        for elb in elbs:
            print(f"  - Load Balancer Name: {elb['LoadBalancerName']}")
            print(f"    DNS Name: {elb['DNSName']}")
            print("")

        # List Subnets
        print("Subnets:")
        subnets = subnet_client.describe_subnets()['Subnets']
        for subnet in subnets:
            print(f"  - Subnet ID: {subnet['SubnetId']}")
            print(f"    CIDR Block: {subnet['CidrBlock']}")
            print("")

        # List VPCs
        print("VPCs:")
        vpcs = vpc_client.describe_vpcs()['Vpcs']
        for vpc in vpcs:
            print(f"  - VPC ID: {vpc['VpcId']}")
            print(f"    CIDR Block: {vpc['CidrBlock']}")



if __name__ == "__main__":
    list_resources_per_region()

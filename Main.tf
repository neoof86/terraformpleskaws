
variable "aws_region" {
  description = "Region for the VPC"
  default = "us-west-1"
}

variable "aws_az" {
  description = "Region for the VPC"
  default = "us-west-1"
}


variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "172.16.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "172.16.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  default = "172.16.2.0/24"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default = "ami-0ac7bdccfeec7fc68"

}
  variable "key_path" {
    description = "SSH Public Key path"
    default = "YourKeyHere"
}


variable "ProjectName" {
  description = "ProjectName"
  default = "Terraform Project Multi Blog"
}

variable "AWSInstancetype" {
  description = "AWS Instance Type"
  default = "t2.micro"
}

variable "AWSAccessKey" {
  description = "AWS Access Key"
  default = "Your Details Here"
}

variable "AWSSecretKey" {
  description = "AWS Secret Key"
  default = "Your Details Here"
}



# Define AWS as our provider
provider "aws" {
  region = "${var.aws_region}"
  access_key = "${var.AWSAccessKey}"
  secret_key = "${var.AWSSecretKey}"



}

# Define our VPC
resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.ProjectName}-vpc"
  }
}

# Define the public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "${var.aws_az}a"

  tags {
    Name = "${var.ProjectName} Web Public Subnet"
  }
}

# Define the private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "${var.aws_az}a"

  tags {
    Name = "${var.ProjectName} Private Subnet"
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "${var.ProjectName} VPC IGW"
  }
}

# Define the route table
resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "${var.ProjectName} Public Subnet RT"
  }
}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "web-public-rt" {
  subnet_id = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}


# Define the security group for public subnet
resource "aws_security_group" "sgweb" {
  name = "vpc_test_web"
  description = "Ports required for ${var.ProjectName} webserver"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8447
    to_port = 8447
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port = 995
    to_port = 995
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port = 49152
    to_port = 65535
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8443
    to_port = 8443
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port = 143
    to_port = 143
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port = 465
    to_port = 465
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port = 53
    to_port = 53
    protocol = "udp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port = 953
    to_port = 953
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port = 110
    to_port = 110
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port = 993
    to_port = 993
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port = 8447
    to_port = 8447
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port = 995
    to_port = 995
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port = 49152
    to_port = 65535
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port = 8443
    to_port = 8443
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port = 143
    to_port = 143
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port = 465
    to_port = 465
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port = 53
    to_port = 53
    protocol = "udp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port = 953
    to_port = 953
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port = 110
    to_port = 110
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port = 993
    to_port = 993
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port = 25
    to_port = 25
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  egress {
    from_port = 587
    to_port = 587
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }


  vpc_id="${aws_vpc.default.id}"

  tags {
    Name = "${var.ProjectName} Web Server SG"
  }
}

# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "${var.ProjectName} Key Pair"
  public_key = "${file("${var.key_path}")}"
}

# Define webserver inside the public subnet
resource "aws_instance" "wb" {
   ami  = "${var.ami}"
   instance_type = "${var.AWSInstancetype}"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.public-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
   associate_public_ip_address = true
   source_dest_check = false
   tags {
    Name = "${var.ProjectName} Webserver"
  }
}
output "address" {
  value = "${aws_instance.wb.public_dns}"
}

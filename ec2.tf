# STEP2: CREATE EC2 USING PEM & SG
resource "aws_instance" "my-ec2" {
  ami           = "ami-0368b2c10d7184bc7"   
  instance_type = "t3.micro"
  key_name      = "newlaptop_pem_download"       
  subnet_id     = aws_subnet.subnet_public.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  tags = {
    Name = "Ec2_instance"
  }
  
# USING REMOTE-EXEC PROVISIONER TO INSTALL PACKAGES
  provisioner "remote-exec" {
    # ESTABLISHING SSH CONNECTION WITH EC2
   connection {
      type        = "ssh"
      private_key = file("./newlaptop_pem_download.pem") # replace with your key-name 
      user        = "ec2-user"
      host        = self.public_ip
    }

    inline = [
      "touch file1",
    "sudo yum install -y httpd",
	 "sudo systemctl start httpd",
    "sudo systemctl enable httpd",
   "echo '<html><body><h1>Welcome to my Apache Server</h1></body></html>' | sudo tee /var/www/html/index.html",
      # Output
      "echo 'Access Jenkins Server here --> http://'$ip':8080'",
      "echo 'Jenkins Initial Password: '$pass''",
      "echo 'Access SonarQube Server here --> http://'$ip':9000'",
      "echo 'SonarQube Username & Password: admin'",
    ]
  }
}  

# STEP3: GET EC2 USER NAME AND PUBLIC IP 
output "SERVER-SSH-ACCESS" {
  value = "ubuntu@${aws_instance.my-ec2.public_ip}"
}

# STEP4: GET EC2 PUBLIC IP 
output "PUBLIC-IP" {
  value = "${aws_instance.my-ec2.public_ip}"
}

# STEP5: GET EC2 PRIVATE IP 
output "PRIVATE-IP" {
  value = "${aws_instance.my-ec2.private_ip}"
}
# Security group to allow SSH access
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.vpc_one.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (you can restrict to specific IPs)
  }
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2_Security_Group"
  }
}
# Output the public IP address of the EC2 instance
output "ec2_public_ip" {
  value       = aws_instance.my-ec2.public_ip
  description = "The public IP address of the EC2 instance"

}
# key pair
resource "aws_key_pair" "my_key"{
    key_name = "terra-key"
    public_key = file("terra-key.pub")
}
# VPC

resource aws_default_vpc default{
    
}
# security group

resource aws_security_group my_sec_grp{
    name = "auomae_sg"
    description= "this will add tf  generated security group"
    vpc_id = aws_default_vpc.default.id # interpolation (where you can inherit or extract the value of block)
    #inbound
    ingress{
        from_port =22
        to_port = 22
        protocol="tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description= "open"
    }
     ingress{
        from_port =80
        to_port = 80
        protocol="tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description= "open"
    }
    ingress{
        from_port=8000
        to_port=8000
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
        description= "flask-open"
    }
    egress{
        from_port =0
        to_port=0
        protocol="-1" # all ports
        cidr_blocks=["0.0.0.0/0"]
        description= "all access to open"


    }
    tags = {
        Name= "auto_sg"

    }
}

# ec2-instance
resource "aws_instance" "my_terr-instace"{
    count =1
    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_sec_grp.name]
    instance_type= var.ec2_instance_type
    ami=var.ec2_ami_id
    root_block_device{
        volume_size= var.ec2_storage_type
        volume_type = "gp3"
    }
    tags = {
        Name = "TWS-ubuntu_test"
        
    }
}
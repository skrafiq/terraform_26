output "ec2_public_dns"{
    value = aws_instance.my_terr-instace.public_dns
}

output "ec2_public_ip"{
    value = aws_instance.my_terr-instace.public_ip
    }

output "ec2_private_ip"{
    value = aws_instance.my_terr-instace.private_ip  
}

output "my_key"{
    value = aws_key_pair.my_key.key_name
}
# aws configure
# aws ec2 delete-key-pair --key-name mykey
# terraform init
# terraform apply -auto-approve
# cat terraform.tfstate|grep public_ip
# ssh -i mykey ubuntu@13.209.73.61

# terraform destroy -auto-approve

resource "aws_key_pair" "mykey" {
  key_name = "mykey"
  public_key = "${file("mykey.pub")}"
}

resource "aws_instance" "example" {
  ami = "ami-0fd02cb7da42ee5e0"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"

  connection {
    user = "ubuntu"
    private_key = "${file("mykey")}"
  }
}

provider "aws" {
    region = "ap-northeast-2"
}







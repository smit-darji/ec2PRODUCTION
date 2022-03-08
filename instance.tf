##########################################  for ce2 intance ############################################
resource "aws_instance" "app_server" {
  ami = var.image_id
  //ami                    = data.aws_ami.ubuntu.id#copy from aws server name
  instance_type          = var.instance_type #instance type
  key_name               = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = ["${aws_security_group.terraform-sg-smit.id}"]
  tags = {
    Name = "Smit-First-Terraform" #name of insatnce
  }
  user_data = file("${path.module}/script.sh")

  connection {                                  //provisioner ne conncetion joie to globaly lai lese
    type        = "ssh"                         //type
    user        = "ubuntu"                      // server
    private_key = file("${path.module}/id_rsa") //get key
    host        = self.public_ip                //for get ip address public
  }
  provisioner "file" {
    source = "readme.md" //teraaform muchine 
    // source ni jagaye content = "demo"
    destination = "/tmp/content.md" //instance machine
  }

  provisioner "file" {
    content     = "demo this is content file"
    destination = "/tmp/content.md" //instance machine
  }
  provisioner "local-exec" {
    on_failure = continue //jo a fail thay to next command agal chale rakhe akhhu curupt na thAY
    command    = "echo ${self.public_ip} > /tmp/myPublicIp.txt"
  }
  provisioner "local-exec" {
    working_dir = "/tmp/"
    command     = "echo ${self.public_ip} > myPublicIp.txt"
  }
  provisioner "remote-exec" {
    inline = [
      "ifconfig > /tmp/ifconfig.txt",
      "echo 'hello smit' > /tmp/test.txt"
    ]
  }
  provisioner "remote-exec" {
    script = "./testScript.sh" //data server ma location par save thase
  }
}






############################################ for keypair #########################################
resource "aws_key_pair" "key-tf" {
  key_name   = "key-tf"
  public_key = file("${path.module}/id_rsa.pub") //get file and path and get path of public key
}
output "printname" {
  value = aws_key_pair.key-tf.key_name //keypair namefff
}

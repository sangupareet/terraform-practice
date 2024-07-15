provider "aws" {
  
}

resource "aws_instance" "server" {
  ami                    = "ami-0ec0e125bb6c6e8ec"
  instance_type          = "t2.micro"
  key_name      = "sriram"
  tags = {
    Name = "test"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"  # Replace with the appropriate username for your EC2 instance
    private_key = file("C:/Users/Sangam/Downloads/sriram.pem")
    # private_key = file("~/.ssh/id_rsa")  #private key path
    host        = self.public_ip
  }
  
  # local execution process
 provisioner "local-exec" {
    command = "touch file1"
   
 }
  # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "file10"  # Replace with the path to your local file
    destination = "/home/ec2-user/file10"  # Replace with the path on the remote instance
  }
  
  # remote execution process 
  provisioner "remote-exec" {
    inline = [
"touch file2",
"echo hello from aws >> file2",
]
 }
}

resource "aws_instance" "my_vm" {
    ami                 = "ami-0583d8c7a9c35822c" //RHEL 9
    instance_type       = "t2.micro"
    availability_zone   = "us-east-1a"
    subnet_id           = "subnet-02ce82c37129ec983"
    key_name            = "scc24-k1"
    associate_public_ip_address = false
    vpc_security_group_ids = ["sg-07aa745b13767897d"]


    tags ={
        Name = "compute01"
    }
}
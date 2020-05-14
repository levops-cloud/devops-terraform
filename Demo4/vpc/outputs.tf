output "aws_security_group_db" {
  value = "${aws_security_group.sgdb.id}"
}

output "aws_security_group_web" {
  value = "${aws_security_group.sgweb.id}"
}

output "public-subnet" {
  value = "${aws_subnet.public-subnet.id}"
}

output "private-subnet" {
  value = "${aws_subnet.private-subnet.id}"
}

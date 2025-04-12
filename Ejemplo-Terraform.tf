provider "aws" {
  region = "us-east-1"
}

# Creación de VPC
resource "aws_vpc" "Act3_VPC" {
  cidr_block = "10.10.0.0/20"
  
  tags = {
    Name = "Actividad_3"
  }
}

# Crear Subredes
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.Act3_VPC.id 
  cidr_block              = "10.10.0.0/24" 
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet" 
  }
}

# Crear Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.Act3_VPC.id

  tags = {
    Name = "gw-Actividad_3"
  }
}

# Crear Tabla de Rutas
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.Act3_VPC.id 

  route {
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public_rt-Actividad_3" 
  }
}

# Asociación de Tabla de Rutas con Subred
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id 
  route_table_id = aws_route_table.public_rt.id
}

# Crear Grupos de Seguridad
# SG-Linux-Jumo-Server
resource "aws_security_group" "Linux_JS" {
  vpc_id = aws_vpc.Act3_VPC.id 
  
  #Reglas de seguridad
  
#SSH
  ingress {
    from_port   = 22 
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  #Reglas de salida

#SSH
  egress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Todo el trafico
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


#SG-Linux-Web-Server
resource "aws_security_group" "Linux_WS" {
  vpc_id = aws_vpc.Act3_VPC.id 
  
  #Reglas de entrada
  
#SSh
  ingress {
    from_port   = 22 
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Todo el trafico
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  #Reglas de salida

#Todo el trafico
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #HTTP
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
} 


# Crear Instancias EC2
resource "aws_instance" "Linux-Jump-Server" {
  ami                         = "ami-084568db4383264d4"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  security_groups             = [aws_security_group.Linux_JS.id]
  associate_public_ip_address = true
  key_name                    = "vockey"
  
  tags = {
    Name = "Linux-Jump-Server"
  }
}

resource "aws_instance" "Linux-Web-Server1" {
  ami                         = "ami-084568db4383264d4"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.Linux_WS.id]
  associate_public_ip_address = true
  key_name                    = "vockey"
  tags = {
    Name = "Linux-Web-Server1"
  }
}

resource "aws_instance" "Linux-Web-Server2" {
  ami                         = "ami-084568db4383264d4"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  security_groups             = [aws_security_group.Linux_WS.id]
  associate_public_ip_address = true 
  key_name                    = "vockey"

  tags = {
    Name = "Linux-Web-Server2"
  } 
}

# Crear Instancias EC2
resource "aws_instance" "Linux-Web-Server3" {
  ami                         = "ami-084568db4383264d4"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  security_groups             = [aws_security_group.Linux_WS.id]
  associate_public_ip_address = true
  key_name                    = "vockey"
  
  tags = {
    Name = "Linux-Web-Server3"
  }
}
# Crear Instancias EC2
resource "aws_instance" "Linux-Web-Server4" {
  ami                         = "ami-084568db4383264d4"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  security_groups             = [aws_security_group.Linux_WS.id]
  associate_public_ip_address = true
  key_name                    = "vockey"
  
  tags = {
    Name = "Linux-Web-Server4"
  }
}
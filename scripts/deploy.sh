#!/bin/bash

echo "=== ACTUALIZANDO REPOSITORIO ==="
git pull origin main

echo "=== COMPILANDO CÓDIGO JAVA ==="
mkdir -p build
javac -cp /usr/share/tomcat10/lib/servlet-api.jar -d build src/hola/HolaServlet.java

echo "=== CREANDO ESTRUCTURA DEL WAR ==="
rm -rf war miapp.war
mkdir -p war/WEB-INF/classes
cp build/hola/*.class war/WEB-INF/classes/
cp web.xml war/WEB-INF/

echo "=== GENERANDO ARCHIVO WAR ==="
cd war
jar cvf ../miapp.war *
cd ..

echo "=== COPIANDO WAR A TOMCAT ==="
sudo cp miapp.war /var/lib/tomcat10/webapps/

echo "=== REINICIANDO TOMCAT ==="
sudo systemctl restart tomcat10

echo "=== COMPROBANDO DESPLIEGUE ==="
sleep 5
curl -I http://localhost:8080/miapp/


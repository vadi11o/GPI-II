#!/bin/bash

# Definir variables
PROJECT_DIR="./kernel"
LOG_FILE="$PROJECT_DIR/build.log"

# Cambiar al directorio del proyecto
cd $PROJECT_DIR

# Verificar la versión de Java
echo "Verificando la versión de Java..."
java -version

# Configurar JAVA_HOME si es necesario
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# Verificar JAVA_HOME
echo "JAVA_HOME está configurado en: $JAVA_HOME"

# Limpiar el proyecto
echo "Limpiando el proyecto..."
mvn clean

# Purga del repositorio local de dependencias
echo "Purgando el repositorio local de dependencias..."
mvn dependency:purge-local-repository

# Ejecutar el análisis de código, compilación y empaquetado
echo "Ejecutando el análisis de código, compilación y empaquetado..."
mvn clean verify -DskipTests | tee $LOG_FILE

# Verificar si el build fue exitoso
if [ ${PIPESTATUS[0]} -eq 0 ]; then
    echo "El build y el análisis de código se completaron con éxito."
    echo "Revisa el archivo de log para más detalles: $LOG_FILE"
else
    echo "Hubo errores durante el build y/o el análisis de código."
    echo "Revisa el archivo de log para más detalles: $LOG_FILE"
fi

#!/bin/bash
# Script de configuracion inicial del entorno servidor
# Proyecto Linux Grupo 11

# --- Configuracion del hostname ---
sudo hostnamectl set-hostname servidor-grupo11

# --- Creacion de grupos ---
sudo groupadd soporte
sudo groupadd web

# --- Creacion de usuarios ---
sudo adduser --disabled-password --gecos "" adminsys
echo "adminsys:admin123" | sudo chpasswd
sudo usermod -aG sudo adminsys

sudo adduser --disabled-password --gecos "" tecnico
echo "tecnico:tec123" | sudo chpasswd
sudo usermod -aG soporte tecnico

sudo adduser --disabled-password --gecos "" visitante
echo "visitante:visit123" | sudo chpasswd
sudo usermod -aG web visitante

# --- Estructura de directorios ---
sudo mkdir -p /proyecto/{datos,web,scripts,capturas}

# --- Asignacion de grupos y permisos ---
sudo chown :soporte /proyecto/datos
sudo chown :web /proyecto/web

# Permitir que los archivos hereden el grupo del directorio
sudo chmod 2775 /proyecto/datos
sudo chmod 2775 /proyecto/web

echo "Configuracion inicial completada."

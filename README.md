# Proyecto Linux – Grupo 11

## 📌 Descripción del Proyecto
Este proyecto consiste en la preparación de un entorno Linux que simula un servidor local.  
Incluye configuración de usuarios, grupos, permisos, estructura de directorios, automatización con scripts, tareas programadas con cron y control de versiones con Git.

Este entorno será utilizado más adelante para integrar Docker y un servidor web Nginx.

---

#🟦 1. Preparación del Entorno Servidor

#1.1 Administración Básica del Sistema

Se configuró el hostname del sistema:
sudo hostnamectl set-hostname servidor-grupo11

#Se crearon los usuarios requeridos:
adminsys (con privilegios sudo)
tecnico (pertenece al grupo soporte)
visitante (pertenece al grupo web)

#Creación de grupos:
sudo groupadd soporte
sudo groupadd web

#Asignación de usuarios a los grupos:
sudo usermod -aG sudo adminsys
sudo usermod -aG soporte tecnico
sudo usermod -aG web visitante

#1.2 Estructura de Directorios y Permisos

Se creó la estructura del proyecto:
sudo mkdir -p /proyecto/{datos,web,scripts,capturas}

#Asignación de grupos propietarios:
sudo chown :soporte /proyecto/datos
sudo chown :web /proyecto/web

#Permisos con herencia:
sudo chmod g+s /proyecto/datos
sudo chmod g+s /proyecto/web

#🟦 2. Automatización y Monitoreo

2.1 Script de Monitoreo del Sistema
Se creó el script /proyecto/scripts/reporte_sistema.sh con el siguiente contenido:
#!/bin/bash

echo "Fecha y hora actual: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Nombre del host: $(hostname)"
echo "Número de usuarios conectados: $(who | wc -l)"

# Espacio libre en el disco principal (partición raíz /)
echo "Espacio libre en disco principal:"
df -h / | awk 'NR==2 {print $4}'

# Memoria RAM disponible
echo "Memoria RAM disponible:"
free -h | awk '/^Mem:/ {print $7}'

# Número de contenedores Docker activos
echo "Número de contenedores Docker activos:"
docker ps -q | wc -l

#Permisos de ejecución:
sudo chmod +x /proyecto/scripts/reporte_sistema.sh

#2.2 Configuración de Tarea Programada (Cron)

#Se creó el directorio de logs:
sudo mkdir -p /var/log/proyecto

Se abrió el editor de tareas:
crontab -e

#Se agregó la tarea para ejecutar el script cada 30 minutos:
*/30 * * * * /proyecto/scripts/reporte_sistema.sh >> /var/log/proyecto/reporte_sistema.log 2>&1

#🟦 3. Control de Versiones

# 3.1 inicializar el directorio proyecto

Se ingresó en el directorio principal del proyecto:
cd /proyecto

inicializar el directorio git:
git init

Después se configuraron los datos del usuario para los commits:
git config --global user.name ""
git config --global user.email ""
 
# 3.2 Preparación de la Estructura del Proyecto para Git

Se verificaron los archivos y carpetas presentes:
/proyecto
 ├── capturas/
 ├── datos/
 ├── scripts/
 ├── web/
 └── README.md

para que git pueda rastrear las carpetas vacias, se añadieron archivos gitkeep:
touch datos/.gitkeep
touch web/.gitkeep

# 3.3 Primer Commit del Proyecto

Se agregaron todos los archivos al área de staging:
git add .

se realizó el primer commit:
git commit -m "Commit inicial con la estructura del proyecto"

# 3.4 Enlace con el Repositorio Remoto en GitHub

Se añadió la URL del repositorio remoto:
git remote add origin https://github.com/Stanley-rg24040/proyecto-linux-grupo11.git

# 3.5 Envío al Repositorio Remoto (push)

Se subió el proyecto a GitHub:
git push -u origin main
























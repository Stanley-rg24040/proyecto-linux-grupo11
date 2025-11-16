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

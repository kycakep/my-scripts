#!/bin/bash

miner stop;

# 1. Остановка и отключение службы gpu_monitor
sudo systemctl stop gpu_monitor.service
sudo systemctl disable gpu_monitor.service

# 2. Удаление systemd службы gpu_monitor
sudo rm /etc/systemd/system/gpu_monitor.service

# 3. Отключение autossh проброса портов
pkill -f autossh

# 4. Удаление добавленных файлов
rm /hive/bin/gpu_monitor.py
rm /usr/local/bin/autossh_script.sh

# 5. Отключение автозапуска autossh_script.sh
sed -i "/\/usr\/local\/bin\/autossh_script.sh &>\/dev\/null &/d" /hive/sbin/gpu-detect
sed -i "/systemctl disable --now avg_khs;/d" /hive/sbin/gpu-detect

# 6. Удаление установленных пакетов
sudo /usr/bin/python3 -m pip uninstall dataclasses requests

# 7. Информирование пользователя об окончании процесса
echo "Процесс отключения и удаления завершен."

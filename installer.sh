#!/bin/bash

miner stop;

apt-get update;

apt install git -y;

git clone https://github.com/OhGodAPet/foxscotch
cd foxscotch
make

# установка amd-oc.navi.sh
wget https://github.com/Printscan/RnGHiveTweaks/releases/download/v0.4/amd-oc.navi.sh --no-check-certificate;
cp amd-oc.navi.sh /hive/sbin/;
sudo dos2unix /hive/sbin/amd-oc.navi.sh;

# установка nvidia-oc
wget https://github.com/Printscan/RnGHiveTweaks/releases/download/v0.4/nvidia-oc --no-check-certificate;
cp nvidia-oc /hive/sbin/;
sudo dos2unix /hive/sbin/nvidia-oc;

# установка amd-oc
wget https://github.com/Printscan/RnGHiveTweaks/releases/download/v0.4/amd-oc --no-check-certificate;
cp amd-oc /hive/sbin/;
sudo dos2unix /hive/sbin/amd-oc;

# увеличиваем лимиты core voltage vega
sed -i 's/local MIN_VOLT=750/local MIN_VOLT=650/' /hive/sbin/*vega*;

apt install python3-pip -y

# Список пакетов для установки
packages=("dataclasses" "requests")

# Установка каждого пакета, если его нет на системе
for package in "${packages[@]}"
do
    if ! /usr/bin/python3 -m pip show $package &>/dev/null; then
        sudo /usr/bin/python3 -m pip install $package
        sudo -H /usr/bin/python3 -m pip install $package
    else
        echo "Пакет $package уже установлен. Пропускаем установку."
    fi
done

find . -maxdepth 1 -name 'amd-o*' -delete;
find . -maxdepth 1 -name 'nvidia*' -delete;
find . -maxdepth 1 -name 'miner*' -delete;
find . -maxdepth 1 -name 'gpu_monitor*' -delete;
find . -maxdepth 1 -name 'insta*' -delete;

cd /hive/sbin/;
chmod 777 nvidia-oc;
chmod 777 amd-oc;

/hive/bin/message success "R&G tweaks installed"


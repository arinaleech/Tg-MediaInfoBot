FROM python:3.11

ENV TZ=Asia/Kolkata

WORKDIR /usr/src/app

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    python3-pip \
    git \
    libtinyxml2-9 \
    libcurl3-gnutls \
    libmms0 \
    libcurl4-gnutls-dev \
    libzen-dev \
    wget \
    ffmpeg \
    libsox-fmt-mp3 \
    sox \
    locales \
    megatools \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q -O /tmp/libzen0v5.deb http://th.archive.ubuntu.com/ubuntu/pool/universe/libz/libzen/libzen0v5_0.4.40-1_arm64.deb \
    && dpkg -i /tmp/libzen0v5.deb || apt-get install -f -y \
    && rm /tmp/libzen0v5.deb

RUN wget -q -O /tmp/libmediainfo0v5.deb http://ftp.de.debian.org/debian/pool/main/libm/libmediainfo/libmediainfo0v5_22.12+dfsg-1_arm64.deb \
    && dpkg -i /tmp/libmediainfo0v5.deb || apt-get install -f -y \
    && rm /tmp/libmediainfo0v5.deb

RUN wget -q -O /tmp/libtinyxml2-6a.deb http://kr.archive.ubuntu.com/ubuntu/pool/universe/t/tinyxml2/libtinyxml2-6a_7.0.0+dfsg-1build1_arm64.deb \
    && dpkg -i /tmp/libtinyxml2-6a.deb || apt-get install -f -y \
    && rm /tmp/libtinyxml2-6a.deb

RUN wget -q -O /tmp/libmediainfo-dev.deb http://ftp.de.debian.org/debian/pool/main/libm/libmediainfo/libmediainfo-dev_22.12+dfsg-1_arm64.deb \
    && dpkg -i /tmp/libmediainfo-dev.deb || apt-get install -f -y \
    && rm /tmp/libmediainfo-dev.deb

RUN wget -q -O /tmp/mediainfo.deb https://mediaarea.net/download/binary/mediainfo/22.12/mediainfo_22.12-1_arm64.xUbuntu_20.04.deb \
    && dpkg -i /tmp/mediainfo.deb || apt-get install -f -y \
    && rm /tmp/mediainfo.deb

RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

COPY needs.txt .

RUN pip3 install --no-cache-dir -r needs.txt

COPY . .

RUN chmod +x start

CMD ["bash", "start"]

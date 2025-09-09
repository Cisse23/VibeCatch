FROM python:3.12.11-slim-bookworm

RUN apt-get update && apt-get install -y \
    curl gnupg ca-certificates \
    libglib2.0-0 libgtk-3-0 \
    curl chromium xauth \
    libnss3 libnspr4 libatk1.0-0 libatk-bridge2.0-0 \
    libcups2 libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 \
    libxfixes3 libxrandr2 libgbm1 libpango-1.0-0 \
    libasound2 libatspi2.0-0 libwayland-client0 libwayland-egl1 \
    libwayland-server0 fonts-unifont fonts-liberation \
    libgbm1 libpango-1.0-0 libasound2 libatspi2.0-0 \
    ca-certificates gnupg \
    fonts-unifont fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

ADD requirements.txt /

RUN pip3 install -r requirements.txt

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

RUN rfbrowser init

COPY Suites/ /home/VibeCatch/Suites/
COPY Resource/ /home/VibeCatch/Resource/
COPY libs/ /home/VibeCatch/libs/
COPY data/ /home/VibeCatch/data/

COPY .env /home/VibeCatch/.env

WORKDIR /home/VibeCatch

CMD ["robot", "-d", "results", "Suites"]
FROM python:3.12.11-slim-bookworm

RUN apt-get update && apt-get install -y \
    curl chromium xauth \
    libnss3 libnspr4 libatk1.0-0 libatk-bridge2.0-0 \
    libcups2 libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 \
    libxfixes3 libxrandr2 libgbm1 libpango-1.0-0 \
    libasound2 libatspi2.0-0 libwayland-client0 libwayland-egl1 \
    libwayland-server0 fonts-unifont fonts-liberation \
    ca-certificates gnupg \
    && rm -rf /var/lib/apt/lists/*

ADD requirements.txt /

RUN pip3 install -r requirements.txt

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

RUN rfbrowser init

COPY Suites/    /VibeCatch/Suites/
COPY Resources/ /VibeCatch/Resources/
COPY Libs/      /VibeCatch/Libs/
ENV PYTHONPATH="/VibeCatch/Libs:${PYTHONPATH}"

WORKDIR /VibeCatch

ENTRYPOINT ["robot"]

CMD ["-d", "results", "Suites"]
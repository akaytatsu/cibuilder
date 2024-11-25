# Dockerfile

# Use a imagem base do Alpine Linux com Python 3 instalado
FROM docker:20.10-cli

# Instala as dependências necessárias
RUN apk update && apk add --no-cache \
    bash \
    curl \
    jq \
    git \
    make \
    gcc \
    libffi-dev \
    musl-dev \
    openssl-dev \
    python3 \
    python3-dev \
    py3-pip \
    nodejs \
    npm \
    openssh-server \
    openssh-client \
    libgtk2.0-0 \
    libgtk-3-0 \
    libnotify-dev \
    libgconf-2-4 \
    libgbm-dev \
    libnss3 \
    libxss1 \
    libasound2 \
    libxtst6 \
    procps \
    xauth \
    xvfb \
    # install text editors
    vim-tiny \
    nano \
    ttf-wqy-zenhei \
    ttf-wqy-microhei \
    xfonts-wqy \
    && pip install --upgrade pip

# Instala o AWS CLI e o boto3
RUN npm install cypress
RUN pip install awscli boto3

# Instala o kubectl
# RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
RUN curl -LO "https://dl.k8s.io/release/v1.21.2/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin

RUN curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64 \
    && install -m 555 argocd-linux-amd64 /usr/local/bin/argocd \
    && rm argocd-linux-amd64

# COPY docker-entrypoint.sh ./entrypoint.sh

# ENTRYPOINT ["sh", "./entrypoint.sh"]

CMD ["sh"]

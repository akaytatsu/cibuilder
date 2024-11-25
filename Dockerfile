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
    openssh-client \
    libnotify-dev \
    openjdk17 \
    nano

RUN pip install --upgrade pip

# Instala o AWS CLI e o boto3
# RUN npm install cypress
RUN pip install awscli boto3

# Instala o kubectl
# RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
RUN curl -LO "https://dl.k8s.io/release/v1.21.2/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin

RUN curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64 \
    && install -m 555 argocd-linux-amd64 /usr/local/bin/argocd \
    && rm argocd-linux-amd64

# Instala o Sonar Scanner
RUN mkdir -p /opt/sonar/ \
    && wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-6.2.1.4610.zip -O /opt/sonar/sonar-scanner.zip \
    && unzip /opt/sonar/sonar-scanner.zip -d /opt/sonar \
    && mv /opt/sonar/sonar-scanner-6.2.1.4610/* /opt/sonar \
    && rmdir /opt/sonar/sonar-scanner-6.2.1.4610/ \
    && rm /opt/sonar/sonar-scanner.zip \
    && chmod +x /opt/sonar/bin/sonar-scanner

# Define o JAVA_HOME e atualiza o PATH
ENV JAVA_HOME="/usr/lib/jvm/java-17-openjdk"

# Adiciona o ambiente virtual ao PATH
ENV PATH="$JAVA_HOME/bin:/opt/sonar/bin:$PATH"

# COPY docker-entrypoint.sh ./entrypoint.sh

# ENTRYPOINT ["sh", "./entrypoint.sh"]

CMD ["sh"]
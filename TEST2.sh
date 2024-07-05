sudo apt update && sudo apt upgrade -y && \
sudo apt install -y ca-certificates zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev curl git wget make jq build-essential pkg-config lsb-release libssl-dev libreadline-dev libffi-dev gcc screen unzip lz4 && \
sudo apt install -y python3 python3-pip && \
python3 --version && \
pip3 --version && \
if ! command -v docker &> /dev/null; then \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    sudo apt-get update && \
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io && \
    docker version; \
fi && \
if ! command -v docker-compose &> /dev/null; then \
    VER=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4) && \
    sudo curl -L "https://github.com/docker/compose/releases/download/$VER/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    sudo chmod +x /usr/local/bin/docker-compose && \
    docker-compose --version; \
fi && \
sudo groupadd docker || true && \
sudo usermod -aG docker $USER && \
sudo rm -rf /usr/local/go && \
curl -L https://go.dev/dl/go1.22.4.linux-amd64.tar.gz | sudo tar -xzf - -C /usr/local && \
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && \
echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> $HOME/.bash_profile && \
source $HOME/.bash_profile && \
go version && \
git clone https://github.com/allora-network/allora-chain.git && \
cd allora-chain && make all && \
allorad version && \
allorad keys add testkey

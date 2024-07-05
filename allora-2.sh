cd $HOME && git clone https://github.com/allora-network/basic-coin-prediction-node && \
cd basic-coin-prediction-node && \
mkdir worker-data head-data && \
sudo chmod -R 777 worker-data head-data && \
sudo docker run -it --entrypoint=bash -v $(pwd)/head-data:/data alloranetwork/allora-inference-base:latest -c "mkdir -p /data/keys && (cd /data/keys && allora-keys)" && \
sudo docker run -it --entrypoint=bash -v $(pwd)/worker-data:/data alloranetwork/allora-inference-base:latest -c "mkdir -p /data/keys && (cd /data/keys && allora-keys)" && \
cat head-data/keys/identity

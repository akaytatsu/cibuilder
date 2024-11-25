echo "TOKEN" | docker login --username akaytatsu --password-stdin

docker build -t akaytatsu/cibuilder:1.3 -t akaytatsu/cibuilder:latest -f Dockerfile . --no-cache
docker push akaytatsu/cibuilder:1.3
docker push akaytatsu/cibuilder:latest

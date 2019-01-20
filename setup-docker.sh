#!/bin/bash

# build the flask container
docker build -t lishiyo/foodtrucks .

# create the network
docker network create foodtrucks-net

# start the ElasticSearch container on the custom network
docker run -d --name es --net foodtrucks-net -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.3.2

# start the flask app container on the custom network
docker run -d --net foodtrucks-net -p 5000:5000 --name foodtrucks lishiyo/foodtrucks

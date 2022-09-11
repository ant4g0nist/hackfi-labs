#!/bin/zsh -x

BASEIMAGE="ant4g0nist/hackfios:base"
EVMIMAGE="ant4g0nist/hackfios:evm"
SOLANAIMAGE="ant4g0nist/hackfios:solana"
ALLINONE="ant4g0nist/hackfios:all"

# build hackfi base image
docker build -t $BASEIMAGE - < base.Dockerfile
# push to dockerhub
docker push $BASEIMAGE

# build EVM image
docker build -t $EVMIMAGE . -f evm.Dockerfile
# push to dockerhub
docker push $EVMIMAGE
# docker run -it ant4g0nist/hackfios:evm surya

# build Solana image
# docker build -t $SOLANAIMAGE - < solana.Dockerfile
# docker push ant4g0nist/hackfios:solana
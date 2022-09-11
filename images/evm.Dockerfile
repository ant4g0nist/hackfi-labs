FROM ant4g0nist/hackfios:base

RUN add-apt-repository -y ppa:ethereum/ethereum && \
    apt-get update && apt-get install -y --no-install-recommends \
    ethereum \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# install geth
RUN apt-get upgrade geth

# install ganache
RUN npm install --production -g ganache truffle && npm --force cache clean

# copy echidna
COPY --from=trailofbits/echidna:latest /root/.local/bin/echidna-test /usr/local/bin/echidna-test

# Install Parity
RUN curl https://get.parity.io -L | bash

ENV HOME=/home/coder
ENV PATH=$PATH:/home/coder/.local/bin

# Install solc-select
USER coder
RUN python3 -m pip --no-cache-dir install solc-select
RUN solc-select install all \
    && SOLC_VERSION=0.8.0 solc-select versions | head -n1 | xargs solc-select use

# Install Slither
RUN python3 -m pip --no-cache-dir install crytic-compile slither-analyzer pyevmasm

# install Brownie & mythril
RUN python3 -m pip install eth-brownie mythril

# Install Certora
USER root
RUN apt update && apt install default-jdk -y

USER coder
RUN python3 -m pip install certora-cli

# Install Foundry
RUN curl -L https://foundry.paradigm.xyz | bash
RUN $HOME/.foundry/bin/foundryup

ENV PATH $PATH:$HOME/.foundry/bin/

USER root
# Install Scribble
RUN apt update && apt install graphviz -y
RUN npm install -g eth-scribble surya && npm --force cache clean

USER coder
WORKDIR /home/coder/labs/
COPY labs/EthernautChallenges /home/coder/labs/EthernautChallenges
RUN sudo chown -R coder /home/coder/

RUN git clone --depth 1 https://github.com/trailofbits/not-so-smart-contracts.git && \
    git clone --depth 1 https://github.com/trailofbits/rattle.git && \
    git clone --depth 1 https://github.com/crytic/building-secure-contracts && \
    git clone https://github.com/nicolasgarcia214/damn-vulnerable-defi-foundry 
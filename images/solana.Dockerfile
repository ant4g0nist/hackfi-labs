FROM ant4g0nist/hackfios:base

USER coder
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/home/coder/.cargo/bin:${PATH}"

USER root
RUN apt-get -y install pkg-config libssl-dev

USER coder

# Install Rust Security Tools
RUN rustup update \
    && rustup component add  \
    clippy rustfmt\
    && cargo install depdive \
    cargo-expand \
    cargo-audit \
    cargo-deny \
    cargo-geiger

RUN cargo install \
    cargo-crev \  
    cargo-fuzz \
    cargo-fix \
    cargo-generate \
    cargo-tarpaulin \
    cargo-outdated \
    honggfuzz

RUN sh -c "$(curl -sSfL https://release.solana.com/v1.11.10/install)"
RUN rustup install nightly
RUN cargo install cargo-inspect

USER root
RUN curl -OL https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && ./llvm.sh 13 \
    && rm llvm.sh


## sec3.dev
USER root
RUN curl -L https://raw.githubusercontent.com/sec3dev/pro-action/main/dist/index.js -o /usr/bin/sec3.js
RUN echo 'node /usr/bin/sec3.js' > /usr/bin/sec3
RUN chmod +x /usr/bin/sec3

# Metaplex
RUN apt update && apt install libudev-dev pkg-config unzip -y

USER coder
RUN cargo install sugar-cli

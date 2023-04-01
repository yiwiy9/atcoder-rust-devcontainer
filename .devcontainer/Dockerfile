FROM rust:1.68-bullseye

RUN rustup toolchain install 1.42.0 && \
    rustup component add rustfmt clippy && \
    cargo install cargo-compete


FROM rust:1.68-bullseye

RUN rustup toolchain install 1.42.0 && \
    rustup component add rustfmt clippy && \
    cargo install cargo-compete && \
    cargo install cargo-snippet --features="binaries"

COPY ./entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY ./snippet.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/snippet.sh

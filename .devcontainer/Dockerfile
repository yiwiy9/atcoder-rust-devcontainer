FROM rust:1.70-bullseye

RUN apt-get update && \
    apt-get install -y jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rustup toolchain install 1.42.0 && \
    rustup component add rustfmt clippy && \
    cargo install cargo-compete --locked && \
    cargo install cargo-snippet --features="binaries"

COPY ./entrypoint.sh ./cargo_compete_new.sh ./create_gitkeep_in_testcases.sh ./cargo_snippet.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh /usr/local/bin/cargo_compete_new.sh /usr/local/bin/create_gitkeep_in_testcases.sh /usr/local/bin/cargo_snippet.sh

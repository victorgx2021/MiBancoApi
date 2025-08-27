FROM debian:12.9

RUN useradd -m runner && mkdir -p /home/runner/actions-runner \
    && chown -R runner:runner /home/runner

WORKDIR /home/runner/actions-runner

RUN apt-get update && \
    apt-get install -y curl tar perl libicu72 && \
    rm -rf /var/lib/apt/lists/*

RUN curl -o actions-runner-linux-x64-2.328.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.328.0/actions-runner-linux-x64-2.328.0.tar.gz

RUN echo "01066fad3a2893e63e6ca880ae3a1fad5bf9329d60e77ee15f2b97c148c3cd4e  actions-runner-linux-x64-2.328.0.tar.gz" | shasum -a 256 -c

RUN tar xzf ./actions-runner-linux-x64-2.328.0.tar.gz

COPY start.sh /start.sh
RUN chmod +x /start.sh

USER runner

ENTRYPOINT ["/start.sh"]

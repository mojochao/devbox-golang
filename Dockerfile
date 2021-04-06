FROM mojochao/devbox-core:0.4.0

USER root
RUN curl -sSfL https://golang.org/dl/go1.16.3.linux-amd64.tar.gz -o /tmp/go1.16.3.linux-amd64.tar.gz \
    && tar -C /usr/local -xf /tmp/go1.16.3.linux-amd64.tar.gz \
    && rm -rf /tmp/go1.16.3.linux-amd64.tar.gz \
    && echo 'export PATH=$PATH:/usr/local/go/bin\n' >> /home/developer/.bashrc \
    && echo 'export PATH=$PATH:/usr/local/go/bin\n' >> /home/developer/.zshrc

ENV GOPATH=/usr/local/go

RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b /usr/local/go/bin v1.39.0 \
    && /usr/local/go/bin/go install github.com/cweill/gotests/gotests@latest \
    && /usr/local/go/bin/go install github.com/go-delve/delve/cmd/dlv@latest \
    && /usr/local/go/bin/go install golang.org/x/lint/golint@latest \
    && /usr/local/go/bin/go install golang.org/x/tools/gopls@latest

USER developer
WORKDIR /home/developer

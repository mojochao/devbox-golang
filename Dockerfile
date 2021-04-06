FROM mojochao/devbox-core:0.3.0

RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.39.0 \
    && go get github.com/go-delve/delve/cmd/dlv@latest \
    && go get golang.org/x/tools/gopls@latest

USER developer
WORKDIR /home/developer

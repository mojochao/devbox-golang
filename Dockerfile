FROM mojochao/devbox-core:0.10.0

# Switch to root user to install things under /usr/local/ directory.
USER root

# Install the golang toolchain.
RUN curl -sSfL https://golang.org/dl/go1.16.3.linux-amd64.tar.gz -o /tmp/go1.16.3.linux-amd64.tar.gz \
    && tar -C /usr/local -xf /tmp/go1.16.3.linux-amd64.tar.gz \
    && rm -rf /tmp/go1.16.3.linux-amd64.tar.gz \
    && ln -s /usr/local/go/bin/go    /usr/local/bin \
    && ln -s /usr/local/go/bin/gofmt /usr/local/bin

# Add extra golang tools necessary to build a reasonable dev environment.
RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b /usr/local/bin v1.39.0 \
    && go install github.com/ahmetb/govvv@latest \
    && go install github.com/cweill/gotests/gotests@latest \
    && go install github.com/davidrjenni/reftools/cmd/fillstruct@latest \
    && go install github.com/fatih/gomodifytags@latest \
    && go install github.com/go-delve/delve/cmd/dlv@latest \
    && go install github.com/godoctor/godoctor@latest \
    && go install github.com/haya14busa/gopkgs/cmd/gopkgs@latest \
    && go install github.com/haya14busa/goplay/cmd/goplay@latest \
    && go install github.com/josharian/impl@latest \
    && go install github.com/motemen/gore/cmd/gore@latest \
    && go install github.com/nsf/gocode@latest \
    && go install github.com/rogpeppe/godef@latest \
    && go install github.com/spf13/cobra/cobra@latest \
    && go install github.com/tsenart/vegeta@latest \
    && go install golang.org/x/lint/golint@latest \
    && go install golang.org/x/tools/cmd/godoc@latest \
    && go install golang.org/x/tools/cmd/goimports@latest \
    && go install golang.org/x/tools/cmd/gorename@latest \
    && go install golang.org/x/tools/cmd/guru@latest \
    && go install golang.org/x/tools/gopls@latest \
    && mv /root/go/bin/* /usr/local/bin \
    && rm -rf /root/go

# Switch to developer user to work in their home directory.
USER developer
WORKDIR /home/developer

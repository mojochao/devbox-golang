FROM mojochao/devbox-core:0.5.0

USER root
RUN curl -sSfL https://golang.org/dl/go1.16.3.linux-amd64.tar.gz -o /tmp/go1.16.3.linux-amd64.tar.gz \
    && tar -C /usr/local -xf /tmp/go1.16.3.linux-amd64.tar.gz \
    && rm -rf /tmp/go1.16.3.linux-amd64.tar.gz \
    && echo 'export PATH=$PATH:/usr/local/go/bin\n' >> /home/developer/.bashrc \
    && echo 'export PATH=$PATH:/usr/local/go/bin\n' >> /home/developer/.zshrc

RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b /usr/local/go/bin v1.39.0 \
    && /usr/local/go/bin/go install github.com/ahmetb/govvv@latest \
    && /usr/local/go/bin/go install github.com/cweill/gotests/gotests@latest \
    && /usr/local/go/bin/go install github.com/davidrjenni/reftools/cmd/fillstruct@latest \
    && /usr/local/go/bin/go install github.com/fatih/gomodifytags@latest \
    && /usr/local/go/bin/go install github.com/godoctor/godoctor@latest \
    && /usr/local/go/bin/go install github.com/haya14busa/gopkgs/cmd/gopkgs@latest \
    && /usr/local/go/bin/go install github.com/nsf/gocode@latest \
    && /usr/local/go/bin/go install github.com/josharian/impl@latest \
    && /usr/local/go/bin/go install github.com/rogpeppe/godef@latest \
    && /usr/local/go/bin/go install github.com/spf13/cobra/cobra@latest \
    && /usr/local/go/bin/go install github.com/go-delve/delve/cmd/dlv@latest \
    && /usr/local/go/bin/go install golang.org/x/lint/golint@latest \
    && /usr/local/go/bin/go install golang.org/x/tools/cmd/godoc@latest \
    && /usr/local/go/bin/go install golang.org/x/tools/cmd/goimports@latest \
    && /usr/local/go/bin/go install golang.org/x/tools/cmd/gorename@latest \
    && /usr/local/go/bin/go install golang.org/x/tools/cmd/guru@latest \
    && /usr/local/go/bin/go install golang.org/x/tools/gopls@latest \
    && mv /root/go/bin/* /usr/local/bin \
    && rm -rf /root/go

USER developer
WORKDIR /home/developer

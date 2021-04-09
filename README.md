## Devbox-Golang

Interactively running and debugging in a Docker or Kubernetes environment is
hell. In such environments a development host, or "devbox", running inside 
Docker or Kubernetes is useful.

This git repository contains the artifacts necessary to build a containerized,
terminal-based Golang development environment Docker image and push it to AWS
ECR for use run locally in a Docker container or run remotely in a Kubernetes
cluster pod.

Note that once started the devbox container is intended to be more "pet" than
"cattle", more persistent than ephemeral.  Any files copied to the devbox
container or pod will be lost once it has been stopped.

This development environment features:

- Image based on core tools in [devbox-core](https://github.com/mojochao/devbox-core)
- Golang 1.16.3 toolchain

The core golang toolchain is supported by the following go tools.

- [cobra](https://github.com/spf13/cobra)
- [dlv](https://github.com/go-delve/delve/cmd/dlv)
- [fillstruct](https://github.com/davidrjenni/reftools/cmd/fillstruct)
- [go guru](https://golang.org/x/tools/cmd/guru)
- [gocode](https://github.com/nsf/gocode)
- [godef](https://github.com/rogpeppe/godef)
- [godoc](https://golang.org/x/tools/cmd/godoc)
- [godoctot](https://github.com/godoctor/godoctor)
- [goimports](https://golang.org/x/tools/cmd/goimports)
- [golangci-lint](https://github.com/golangci/golangci-lint)
- [golint](https://golang.org/x/lint/golint)
- [gomodifytags](https://github.com/fatih/gomodifytags)
- [gopkgs](https://github.com/haya14busa/gopkgs/cmd/gopkgs)
- [goplay](https://github.com/haya14busa/goplay/cmd/goplay)
- [gopls](https://golang.org/x/tools/gopls)
- [gore](https://github.com/motemen/gore)  
- [gorename](https://golang.org/x/tools/cmd/gorename)
- [gotests](https://github.com/cweill/gotests/gotests)
- [govvv](https://github.com/ahmetb/govvv)
- [impl](https://github.com/josharian/impl)
- [vegeta](https://github.com/tsenart/vegeta)

These tools can be assembled with vim and emacs into a perfectly adequate Golang
development environment.

## Build and push images

The [Makefile](Makefile) provides automation to build docker images and push
them to ECR.  The `make` command with no targets specified will list available
build targets.

    $ make
    help                           Show this help
    docker-build                   Build docker images
    docker-tag                     Tag built image with $TAG (default: VERSION)
    docker-push                    Push image tags to Docker Hub

The typical workflow is to build an image, tag it with default VERSION, or an
ad hoc tag, and finally push image and tag to Docker Hub.

    $ make docker-build
    $ make docker-tag
    $ make docker-push

You can also provide multiple targets at once.

    $ make docker-build docker-tag docker-push

## Use images

The [devbox](https://github.com/mojochao/devbox) CLI eases use of devbox images.

With no arguments, `devbox` displays top level usage.

    $ devbox
    Interactively running and debugging in containers can be hell. For such an
    environment, a development host running inside the container is useful.
    
    This application manages use of terminal-based development environment devboxes.
    A devbox is defined in terms of:
    
    - name of devbox container or pod running the devbox image
    - description of devbox usage
    - image name of the devbox to run in a container or pod
    - shell name or path to run in the container or pod
    - kubeconfig of Kubernetes cluster to run devbox pods (optional, Kubernetes only)
    - namespace of Kubernetes cluster to run devbox pods  (optional, Kubernetes only
    
    Note that a devbox is intended to be more "pet" than "cattle", more persistent
    than ephemeral.  Any files copied to the devbox will be lost once stopped.
    
    Usage:
    devbox [command]
    
    Available Commands:
    add         Add devbox to state
    completion  Generate completion script
    context     Get or set active devbox ID context
    edit        Edit the state file
    help        Help about any command
    init        Initialize devbox state file
    list        List devboxes in state
    remove      Remove devboxes from state
    shell       Open interactive shell in devbox
    start       Start devboxes
    stop        Stop devboxes
    version     Display version
    
    Flags:
    --dry-run        preview commands
    -h, --help           help for devbox
    --state string   state file (default "~/.devbox.state.yaml")
    --verbose        show verbose output
    
    Use "devbox [command] --help" for more information about a command.

Initialize `devbox` once before further use.

    $ devbox init

Next add a new devbox for use in docker and start it.

    $ devbox add my-id --image mojochao/devbox-golang --name my-devbox

    $ devbox start
    f647f23f3151a9025e197cc6abaf188a2248d0cb296a65622d713328a687b816
    
    $ docker ps
    CONTAINER ID   IMAGE                           COMMAND            CREATED         STATUS         PORTS     NAMES
    f647f23f3151   mojochao/devbox-golang:latest   "sleep infinity"   5 seconds ago   Up 4 seconds             devbox-allengooch

Once started, a devbox shell can be opened.

    $ devbox shell

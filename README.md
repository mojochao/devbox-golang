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

This development environment is a bit opinionated about the tools installed.
These currently include:

- Golang 1.16.3 toolchain on Debian 10 (Buster) base
- Python 2.7.16 and 3.7.3
- network utilities like ifconfig, ping, dig, netcat, traceroute, socat, ssh, etc
- Bash and Zsh
- Emacs and Vim

It is intended that this image can be used as a base for more customized
project-specific needs.

## Organization

This git repository is organized as follows:

- [devbox script](bin/devbox) providing easy management of devbox containers in
  Docker or Kubernetes
- [bitbucket-pipelines.yml](bitbucket-pipelines.yml) defining devbox-golang
  image build pipelines for this repository
- [Dockerfile](Dockerfile) defining the devbox-golang image build
- [Makefile](Makefile) providing automation for development and build pipeline tasks
- [README.md](README.md) this document
- [RELEASES.md](RELEASES.md) providing release notes for image build versions
- [VERSION](VERSION) defining the image build version

## Build and push images

The [Makefile](Makefile) provides automation to build docker images and push
them to ECR.  The `make` command with no targets specified will list available
build targets.

    $ make
    help                           Show this help
    docker-build                   Build docker image
    docker-push                    Push docker images to Docker Hub

The typical workflow is to build an image, login to the ECR repository, tag the
built image with tags for ECR, and push those tagged images to ECR.

    $ make docker-build
    $ make docker-push

You can also provide multiple targets at once.

    $ make docker-build docker-push

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
    copy        Copy SRC files to devbox DST files
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

    $ devbox add golang --image mojochao/devbox-golang --name my-devbox

    $ devbox start
    f647f23f3151a9025e197cc6abaf188a2248d0cb296a65622d713328a687b816
    
    $ docker ps
    CONTAINER ID   IMAGE                           COMMAND            CREATED         STATUS         PORTS     NAMES
    f647f23f3151   mojochao/devbox-golang:latest   "sleep infinity"   5 seconds ago   Up 4 seconds             devbox-allengooch

Once started, a devbox shell can be opened.

    $ devbox shell
    ➜  ~

By default, an oh-my-zsh! configured z shell is used.

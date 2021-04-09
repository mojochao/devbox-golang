# Devbox-Golang Releases

## 0.10.1

- Mention the new goplay command in the docs

## 0.10.0

- Symlink /usr/local/go/bin* to /usr/local/bin
- Add haya14busa/goplay command to image 
- Pin tag of devbox-core base image to 0.10.0

## 0.9.0

- Remove vscode golang plugin zip needed for DAP (Debug Adaptor Protocol) use,
  as the latest version of dap-mode pulls this on demand.
- Pin tag of devbox-core base image to 0.9.0

## 0.8.0

- Add vscode golang plugin zip needed for Debug Adaptor Protocol (DAP) use
- Pin tag of devbox-core base image to 0.8.0

## 0.7.0

- Add [gore](https://github.com/motemen/gore) to image
- Add [vegeta](https://github.com/tsenart/vegeta) to image
- Pin tag of devbox-core base image to 0.7.0

## 0.6.0

- Add cobra, gocode and govvv to image

## 0.5.0

- Add additional go tools needed for ide-like support

## 0.4.1

- Add go guru
- Pin tag of devbox-core base image to 0.4.1

## 0.4.0

- Pin tag of devbox-core base image to 0.4.0
- Add golint and gotests apps

## 0.3.0

- Switch to developer user at the end of image definition in Dockerfile

## 0.2.0

- Pin tag of devbox-core base image to 0.3.0

## 0.1.0

- Initial release for go 1.16.3 toolchain

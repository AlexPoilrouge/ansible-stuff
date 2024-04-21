# pkgbuild ansible module

## About

An ansible module to offer a task that builds an archlinux package, with `makepkg` on a remote node
(no install).

The task will need a `PKGBUILD`, already on the remote node, to build a package.

### Example:

See the test playbook: `test/create_package_playbook.yaml`

## Tests

The test illustates the use of the module in a playbook.

It is tested against a containerized ssh server.

The package build is tested against one of my small projets:
[myCommandsLauncher](https://github.com/AlexPoilrouge/myCommandsLauncher)

It downloads and decompresses an archive containing a `PKGBUILD` file
that is used to build the project as an archlinux package.

### Test dependencies

- docker
- make
- ssh
- sshpass
- [yq](https://mikefarah.gitbook.io/yq)
- cowsay

### Run the test

Normally, just using the makefile should suffice:
```bash
cd test
make
```

The package is fetched back and placed into the 
`test/pkg_result/` directory.

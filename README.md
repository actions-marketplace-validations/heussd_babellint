# babellint

Lints multiple formats using third-party linters. Ships with reasonable defaults.

## Usage

```sh
alias babellint='docker run --rm --interactive --tty -v $(pwd):$(pwd) -w $(pwd) heussd/babellint:latest'
```

### Lint specific files

```sh
babellint docker-compose.yml
babellint README.md
```

### Lint all files of a git repository

![babellint working through all files of a git repository](babellint.gif)

```sh
cd $gitroot
babellint
```

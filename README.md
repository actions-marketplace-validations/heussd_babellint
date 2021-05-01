# babellint

Lints multiple formats using third-party linters.

## Usage

```sh
alias babellint='docker run --rm --interactive --tty -v $(pwd):$(pwd) -w $(pwd) heussd/babellint:latest'

babellint docker-compose.yml
babellint README.md
```

# babellint

Lintet Dateien mithilfe verschiedener Third-Party-Linter:

![babellint während es sich durch die Dateien eines Git Repositories arbeitet](babellint.gif)

- Dockerfile: [hadolint](https://github.com/hadolint/hadolint/)
- JSON: [jq](https://github.com/stedolan/jq/)
- Markdown: [markdownlint](https://github.com/markdownlint/markdownlint)
- Python: [flake8](https://github.com/PyCQA/flake8)
- Shell Skripts: [shellcheck](https://github.com/koalaman/shellcheck)
- YAML: [yamllint](https://github.com/adrienverge/yamllint)


## Benutzung


### Kommandozeile

```sh
alias babellint='docker run --rm --interactive --tty -v $(pwd):$(pwd) -w $(pwd) ghcr.io/heussd/babellint:main'
```


#### Gezielt Dateien linten

```sh
babellint docker-compose.yml
babellint README.md
```


#### Alle Dateien eines Git Repositories linten

```sh
cd $gitroot
babellint
```


### GitHub Actions

```yml
- name: Babellint
  uses: heussd/babellint@main
```

[Babellint nutzt selbst die Babellint GitHub Action um sich zu ... babellinten.](https://github.com/heussd/babellint/blob/main/.github/workflows/babellint.yml)

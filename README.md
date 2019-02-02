# Golang GitHub Actions

## Actions

### Fmt Action
Runs `gofmt` and comments back on error
<img src="./assets/fmt.png" alt="Fmt Action" width="80%" />

### Vet Action
Runs `go tool vet` and comments back on error
<img src="./assets/vet.png" alt="Vet Action" width="80%" />

### Imports Action
Runs `goimports` and comments back on error.  
Use [golang.org/x/tools/cmd/goimports](https://godoc.org/golang.org/x/tools/cmd/goimports)
<img src="./assets/imports.png" alt="Imports Action" width="80%" />

### Lint Action
Runs `golint` and comments back with the output.  
Use [golang.org/x/lint/golint](https://github.com/golang/lint)
<img src="./assets/lint.png" alt="Lint Action" width="80%" />

### Staticcheck Action
Runs `staticcheck` and comments back with the output.  
Use [honnef.co/go/tools/cmd/staticcheck](https://staticcheck.io/)
<img src="./assets/staticcheck.png" alt="Staticcheck Action" width="80%" />

### Errcheck Action
Runs `errcheck` and comments back with the output.  
Use [github.com/kisielk/errcheck](https://github.com/kisielk/errcheck)
<img src="./assets/errcheck.png" alt="Errcheck Action" width="80%" />

### Sec Action
Runs `gosec` and comments back with the output.  
Use [github.com/securego/gosec/cmd/gosec](https://github.com/securego/gosec)
<img src="./assets/sec.png" alt="Sec Action" width="80%" />

## Workflow Sample

.github/main.workflow

```hcl
workflow "Main Workflow" {
  on = "pull_request"
  resolves = [
    "go imports",
    "go lint",
    "go vet",
    "staticcheck",
    "go sec",
  ]
}

action "filter to pr open synced" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
}

action "go imports" {
  uses = "grandcolline/golang-github-actions/imports@v0.1"
  needs = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
}

action "go lint" {
  uses = "grandcolline/golang-github-actions/lint@v0.1"
  needs = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
}

action "go vet" {
  uses = "grandcolline/golang-github-actions/vet@v0.1"
  needs = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
  env = {
    FLAGS = "-shadow"
  }
}

action "staticcheck" {
  uses = "grandcolline/golang-github-actions/staticcheck@v0.1"
  needs = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
}

action "go sec" {
  uses = "grandcolline/golang-github-actions/sec@v0.1"
  needs = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
}
```

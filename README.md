# Golang GitHub Actions

static code analysis checker for golang.

## Runs

### Fmt
Runs `gofmt` and comments back on error.
<img src="./assets/fmt.png" alt="Fmt Action" width="80%" />

### Vet
Runs `go vet` and comments back on error.

### Shadow
Runs `go vet --vettool=/go/bin/shadow` and comments back on error.  
Use: [golang.org/x/tools/go/analysis/passes/shadow/cmd/shadow](https://godoc.org/golang.org/x/tools/go/analysis/passes/shadow/cmd/shadow)

### Imports
Runs `goimports` and comments back on error.  
Use: [golang.org/x/tools/cmd/goimports](https://godoc.org/golang.org/x/tools/cmd/goimports)
<img src="./assets/imports.png" alt="Imports Action" width="80%" />

### Lint
Runs `golint` and comments back on error.  
Use: [golang.org/x/lint/golint](https://github.com/golang/lint)
<img src="./assets/lint.png" alt="Lint Action" width="80%" />

### Staticcheck
Runs `staticcheck` and comments back on error.  
Use: [honnef.co/go/tools/cmd/staticcheck](https://staticcheck.io/)
<img src="./assets/staticcheck.png" alt="Staticcheck Action" width="80%" />

### Errcheck
Runs `errcheck` and comments back on error.  
Use: [github.com/kisielk/errcheck](https://github.com/kisielk/errcheck)
<img src="./assets/errcheck.png" alt="Errcheck Action" width="80%" />

### Sec
Runs `gosec` and comments back on error.  
Use: [github.com/securego/gosec/cmd/gosec](https://github.com/securego/gosec)
<img src="./assets/sec.png" alt="Sec Action" width="80%" />

## Sample Workflow

`.github/workflows/static.yml`

```yaml
name: static check
on: pull_request

jobs:
  imports:
    name: Imports
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: check
      uses: grandcolline/golang-github-actions@v1.0.0
      with:
        run: imports
        token: ${{ secrets.GITHUB_TOKEN }}

  errcheck:
    name: Errcheck
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: check
      uses: grandcolline/golang-github-actions@v1.0.0
      with:
        run: errcheck
        token: ${{ secrets.GITHUB_TOKEN }}

  lint:
    name: Lint
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: check
      uses: grandcolline/golang-github-actions@v1.0.0
      with:
        run: lint
        token: ${{ secrets.GITHUB_TOKEN }}

  shadow:
    name: Shadow
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: check
      uses: grandcolline/golang-github-actions@v1.0.0
      with:
        run: shadow
        token: ${{ secrets.GITHUB_TOKEN }}

  staticcheck:
    name: StaticCheck
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: check
      uses: grandcolline/golang-github-actions@v1.0.0
      with:
        run: staticcheck
        token: ${{ secrets.GITHUB_TOKEN }}

  sec:
    name: Sec
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: check
      uses: grandcolline/golang-github-actions@v1.0.0
      with:
        command: sec
        githubToken: ${{ secrets.GITHUB_TOKEN }}
        flags: "-exclude=G104"
```

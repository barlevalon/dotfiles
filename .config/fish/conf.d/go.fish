if command -q go
    set -gx GOPATH $(go env GOPATH)
    fish_add_path $(go env GOPATH)/bin
end

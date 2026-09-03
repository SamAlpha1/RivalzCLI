# RivalzCLI

A small Ubuntu helper for checking, installing and launching the public `rivalz-node-cli` package.

## Commands
```bash
chmod +x rivalzctl.sh
./rivalzctl.sh check
./rivalzctl.sh install
./rivalzctl.sh update
./rivalzctl.sh run
```

`check` is read-only. `install` and `update` install the npm package globally and may require sudo.

Wallet and node configuration are entered directly into the Rivalz CLI when it runs; this repository does not store them.

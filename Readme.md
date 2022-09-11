# hackFiOS

## Usage
Start coder:
```sh
coder server -a localhost:3001
```

Build HackFiOS images:
```sh
cd images
./build.sh
```

## create template and workspace
```sh
cd coder
./scripts/create.sh
```

## Stop and remove workspace
```sh
cd coder
./scripts/delete.sh
```

## Available images
- ant4g0nist/hackfios:base
- ant4g0nist/hackfios:evm
- ant4g0nist/hackfios:solana

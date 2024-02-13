# Palworld Server (Proton)

This container downloads the windows version of the Palworld Dedicated Server and automatically installs UE4SS (3.0.0 as of writing).

## Instructions
### docker compose
1. (Recommended but Optional) modify `docker-compose.yml` line
```
build: .
```
TO:
```
image: ghcr.io/swirlclinic/palworld_docker:proton
```
2. Update `docker-compose.yml` ADDITIONAL_ARGS as you'd like
3. `docker-compose up`

Your server files will be in the `palworld_data` directory.

## Compatibility
- MacOS
- Linux

## Notes
It is required to run with the `privileged` flag as otherwise UE4SS will fail to scan and load.
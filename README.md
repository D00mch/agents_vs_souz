Ouroboros vs Souz vs Hermes Agent vs PicoClaw

Below provide the path to the project folders. 

Requirements: docker 

## Documentation

- [How calculations are produced with Emerge](docs/emerge.md)

## HTML Reports

- [Ouroboros, Python](output/python/html/emerge.html)
- [Hermes Agent, Python](output/hermes/html/emerge.html)
- [Souz, Kotlin](output/kotlin/html/emerge.html)
- [PicoClaw, Go](output/picoclaw/html/emerge.html)

# Ouroboros, Python

https://github.com/joi-lab/ouroboros-desktop

```bash
docker run --rm \
  --platform linux/amd64 \
  --user "$(id -u):$(id -g)" \
  -e HOME=/tmp \
  -v "$OUROBOROS_REPO:/work/source:ro" \
  -v "$PWD/output/python:/work/export" \
  -v "$PWD/configs/python.yml:/work/config.yml:ro" \
  achtelik/emerge:2.0.0 \
  /work/config.yml
```

# Hermes Agent, Python

https://github.com/nousresearch/hermes-agent

```bash
docker run --rm \
  --platform linux/amd64 \
  --user "$(id -u):$(id -g)" \
  -e HOME=/tmp \
  -v "$HERMES_AGENT_REPO:/work/source:ro" \
  -v "$PWD/output/hermes:/work/export" \
  -v "$PWD/configs/hermes.yml:/work/config.yml:ro" \
  achtelik/emerge:2.0.0 \
  /work/config.yml
```

# Souz, Kotlin:

https://github.com/D00mch/souz/

```bash
docker run --rm \
  --platform linux/amd64 \
  --user "$(id -u):$(id -g)" \
  -e HOME=/tmp \
  -v "$SOUZ_REPO:/work/source:ro" \
  -v "$PWD/output/kotlin:/work/export" \
  -v "$PWD/configs/kotlin.yml:/work/config.yml:ro" \
  achtelik/emerge:2.0.0 \
  /work/config.yml
```

# PicoClaw, Go

https://github.com/sipeed/picoclaw

```bash
docker run --rm \
  --platform linux/amd64 \
  --user "$(id -u):$(id -g)" \
  -e HOME=/tmp \
  -v "$PICOCLAW_REPO:/work/source:ro" \
  -v "$PWD/output/picoclaw:/work/export" \
  -v "$PWD/configs/picoclaw.yml:/work/config.yml:ro" \
  achtelik/emerge:2.0.0 \
  /work/config.yml
```

Ouroboros vs Souz

Below provide the path to the project folders. 

Requirements: docker 

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

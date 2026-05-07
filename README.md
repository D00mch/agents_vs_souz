Ouroboros vs Souz

Below provide the path to the folders. 

Requirements: docker 

# Ouroboros, Python

https://github.com/joi-lab/ouroboros-desktop

```bash
docker run --rm \
  --platform linux/amd64 \
  --user "$(id -u):$(id -g)" \
  -e HOME=/tmp \
  -v "/Users/dumch/work/python/original/ouroboros-desktop:/work/source:ro" \
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
  -v "/Users/dumch/work/souz2:/work/source:ro" \
  -v "$PWD/output/kotlin:/work/export" \
  -v "$PWD/configs/kotlin.yml:/work/config.yml:ro" \
  achtelik/emerge:2.0.0 \
  /work/config.yml
```

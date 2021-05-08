# ドキュメント生成

```
docker run \
  -u $(id -u):$(id -g) \
  --rm \
  -v "$(pwd):/documents" \
  asciidoctor/docker-asciidoctor \
    sh _build.sh
```

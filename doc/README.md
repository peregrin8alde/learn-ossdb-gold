# ドキュメント生成

```
rm -rf _build

docker run \
  -u $(id -u):$(id -g) \
  --rm \
  -v "$(pwd):/documents/" \
  -e TZ=Asia/Tokyo \
  asciidoctor/docker-asciidoctor \
    asciidoctor \
      -r asciidoctor-diagram \
      -D _build \
      -R ./ \
      -a attributes-doc=/documents/_attributes.adoc \
      "**/index.adoc"
```

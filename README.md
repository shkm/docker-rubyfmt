# docker-rubyfmt

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/shkm/docker-rubyfmt/ci.yml) ![Docker Pulls](https://img.shields.io/docker/pulls/shkm/rubyfmt) ![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/shkm/rubyfmt)

A docker image for [rubyfmt](https://github.com/fables-tales/rubyfmt).

## Usage

Pass your rubyfmt args directly to docker run; e.g.:

```
docker run --volume $(pwd):/code shkm/rubyfmt --check /code
```

For more, see the [rubyfmt](https://github.com/fables-tales/rubyfmt) README.

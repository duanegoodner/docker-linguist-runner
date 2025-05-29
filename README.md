# docker-linguist

A lightweight Dockerized wrapper for [GitHub Linguist](https://github.com/github/linguist)


## 📖 Description

[GitHub Linguist](https://github.com/github/linguist) is the tool GitHub uses to detect the programming languages used in a repository, as well as to syntax-highlight files and ignore vendored content.

This project provides a lightweight and secure Dockerized wrapper around Linguist — allowing you to run it **locally** on any repo without needing to install Ruby or native extensions.


## Getting Started

### 📦 Requirements

- Docker
- Docker Compose v2+
- Bash (for the wrapper script)

### 📥 Clone the Repo

Start by cloning this tool to a local directory:

```bash
git clone https://github.com/yourusername/docker-linguist-runner.git
cd docker-linguist-runner
```

You can place this anywhere on your system. In the examples below, we assume it is at: `~/tools/docker-linguist-runner`.


### 🔧 Build the Image

From the root of this repo (`docker-linguist-runner`), run:

```bash
UID=$(id -u) GID=$(id -g) docker compose build
```
This will build the image and create a non-root user inside the container matching your current local user (by UID and GID).

### 🚀 Run on Any Repo

From the root of any repo you want to analyze, run:
```
/path/to/docker-linguist-runner/run-linguist.sh --breakdown
```
This uses the local image to run GitHub Linguist inside a container, safely mounted read-only.


### 🧪 Example Output

For example purposes, if we run the run-linguist.sh script from the docker-linguist-runner project root itself, we get:

```
79.32%  303        Dockerfile
20.68%  79         Shell

Dockerfile:
Dockerfile

Shell:
linguist-entrypoint.sh
```

## 🛡️ Security Notes
- A non-root user is created inside the image at build time.

- The container runs as your host user (via UID:GID) to avoid permission issues.

- Your project directory is mounted read-only (:ro) — so the container cannot modify your files.

- No files are written unless you explicitly redirect output (e.g. --json > output.json).


## 🛠 Customizing UID and GID

By default, the wrapper script collects your local UID and GID using:
```
UID=$(id -u) GID=$(id -g)
```

These are passed into docker compose build to match file permissions between the host and container:
```
UID=1234 GID=1234 docker compose build
```
Alternatively, you can create a `.env` file in the `docker-linguist-runner` repo root to set UID/GID without exporting them each time:
```
UID=1234
GID=1234
```
This can be useful for CI/CD or team-wide defaults.


## 📄 License
[MIT](./LICENSE)

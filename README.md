# PySpark Docker Environment

[![GitHub](https://img.shields.io/badge/GitHub-promominali%2Fpyspark--dock-blue)](https://github.com/promominali/pyspark-dock)

Optimized Docker setup for PySpark with Jupyter Lab.

## Quick Start

```bash
# Build and run
docker compose up -d

# Access Jupyter Lab
open http://localhost:8888  # token: ali

# Access Spark UI (when running jobs)
open http://localhost:4040
```

## Credentials

- **User**: ali / ali
- **Root**: root / root
- **Jupyter Token**: ali

## Commands

```bash
# Build image
docker compose build

# Start container
docker compose up -d

# Stop container
docker compose down

# Access shell
docker exec -it ali bash

# View logs
docker compose logs -f
```

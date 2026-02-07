# PySpark Docker Environment

[![GitHub](https://img.shields.io/badge/GitHub-promominali%2Fpyspark--dock-blue)](https://github.com/promominali/pyspark-dock)

Optimized Docker setup for PySpark with Jupyter Lab.

## Features

- **PySpark 3.5.0** with Hadoop 3 support
- **Jupyter Lab** for interactive development
- **Python 3.11** slim base image for reduced size
- Pre-installed packages: `pandas`, `numpy`
- Spark UI accessible on port 4040

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

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

## Project Structure

```
pyspark-dock/
├── Dockerfile           # Docker image definition
├── docker-compose.yml   # Container orchestration
├── notebooks/           # Jupyter notebooks (mounted volume)
│   └── pyspark.ipynb    # Example PySpark notebook
└── README.md
```

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

## Environment Variables

| Variable | Value |
|----------|-------|
| `SPARK_VERSION` | 3.5.0 |
| `HADOOP_VERSION` | 3 |
| `SPARK_HOME` | /opt/spark |
| `JUPYTER_TOKEN` | ali |

## Ports

| Port | Service |
|------|--------|
| 8888 | Jupyter Lab |
| 4040 | Spark UI |

## Usage Examples

### Create a SparkSession in Jupyter

```python
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("MyApp") \
    .getOrCreate()

# Create a DataFrame
df = spark.createDataFrame([
    ("Alice", 34),
    ("Bob", 45),
], ["name", "age"])

df.show()
```

### Read/Write Files

```python
# Read CSV
df = spark.read.csv("data.csv", header=True, inferSchema=True)

# Write Parquet
df.write.parquet("output.parquet")
```

## Customization

### Add Python Packages

Edit the `Dockerfile` and add packages to the pip install command:

```dockerfile
RUN pip install --no-cache-dir \
    pyspark==${SPARK_VERSION} \
    jupyterlab \
    pandas \
    numpy \
    your-package-here
```

Then rebuild:

```bash
docker compose build --no-cache
```

## Troubleshooting

### Container won't start
```bash
# Check logs
docker compose logs -f

# Rebuild from scratch
docker compose down
docker compose build --no-cache
docker compose up -d
```

### Port already in use
```bash
# Find process using port 8888
lsof -i :8888

# Or change port in docker-compose.yml
ports:
  - "9999:8888"  # Use port 9999 instead
```

### Git push fails with large file error

If you see an error like:
```
remote: error: File pyspark-dock.tar is 896.15 MB; this exceeds GitHub's file size limit of 100.00 MB
remote: error: GH001: Large files detected.
```

**Option 1: Remove the file from Git** (recommended)
```bash
# Remove from Git but keep locally
git rm --cached pyspark-dock.tar
echo "pyspark-dock.tar" >> .gitignore
git commit --amend --no-edit
git push
```

**Option 2: Use Git LFS** (if you need to version the file)
```bash
# Install Git LFS
brew install git-lfs
git lfs install

# Track large files
git lfs track "*.tar"
git add .gitattributes

# Re-add the file with LFS
git rm --cached pyspark-dock.tar
git add pyspark-dock.tar
git commit --amend --no-edit
git push
```

## License

MIT

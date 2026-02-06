# Optimized PySpark + Jupyter image using slim base
FROM python:3.11-slim-bookworm

# Set environment variables
ENV SPARK_VERSION=3.5.0
ENV HADOOP_VERSION=3
ENV SPARK_HOME=/opt/spark
ENV PATH="${SPARK_HOME}/bin:${PATH}"
ENV PYSPARK_PYTHON=python3
ENV PYSPARK_DRIVER_PYTHON=jupyter
ENV PYSPARK_DRIVER_PYTHON_OPTS="lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root"

# Install dependencies in single layer to reduce image size
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-17-jre-headless \
    curl \
    procps \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Download and install Spark
RUN curl -fsSL "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" \
    | tar -xz -C /opt \
    && mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME} \
    && rm -rf ${SPARK_HOME}/examples ${SPARK_HOME}/data

# Install Python packages
RUN pip install --no-cache-dir \
    pyspark==${SPARK_VERSION} \
    jupyterlab \
    pandas \
    numpy

# Set root password
RUN echo 'root:root' | chpasswd

# Create user ali with password ali
RUN useradd -m -s /bin/bash ali \
    && echo 'ali:ali' | chpasswd \
    && mkdir -p /home/ali/work \
    && chown -R ali:ali /home/ali

# Set working directory
WORKDIR /home/ali/work

# Switch to ali user
USER ali

# Expose Jupyter port
EXPOSE 8888

# # Default command
# CMD ["pyspark"]

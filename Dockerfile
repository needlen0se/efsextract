FROM ubuntu:22.04

# Install required dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    libcdio-dev \
    libiso9660-dev \
    bsdmainutils \
    && rm -rf /var/lib/apt/lists/*

# Make a lower-privileged user
RUN useradd -ms /bin/bash dockeruser

# Create a directory for the application
RUN mkdir /app
RUN chown dockeruser:dockeruser /app
COPY --chown=dockeruser:dockeruser . /app

# Switch to the lower-privileged user
USER dockeruser

WORKDIR /app
RUN make

WORKDIR /out

CMD ["/app/efsextract"]

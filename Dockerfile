FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1
WORKDIR /app

# Install tools to download and unzip
RUN apt-get update && apt-get install -y --no-install-recommends wget unzip && rm -rf /var/lib/apt/lists/*

# Copy the run script
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Default command: run the script which downloads and executes sherlock
CMD ["/app/run.sh"]

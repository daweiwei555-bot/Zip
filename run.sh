#!/usr/bin/env bash
set -euo pipefail

# URL to sherlock master.zip
ZIP_URL="https://github.com/sherlock-project/sherlock/archive/refs/heads/master.zip"
WORKDIR="/app/sherlock"
OUTPUT_DIR="/app/output"
USERNAME="${S_USERNAME:-${1:-example}}"

mkdir -p /app /app/tmp "$OUTPUT_DIR"
cd /app/tmp

echo "[run.sh] Downloading sherlock master.zip..."
if command -v wget >/dev/null 2>&1; then
  wget -q -O master.zip "$ZIP_URL"
else
  curl -sL -o master.zip "$ZIP_URL"
fi

echo "[run.sh] Unzipping..."
unzip -q master.zip
# The zip extracts to sherlock-master or similar
EXTRACT_DIR=$(find . -maxdepth 1 -type d -name "sherlock*" | head -n 1)
if [ -z "$EXTRACT_DIR" ]; then
  echo "[run.sh] Extraction failed or unexpected layout."
  ls -la
  exit 1
fi

mv "$EXTRACT_DIR" "$WORKDIR"
cd "$WORKDIR"

echo "[run.sh] Installing python requirements (if any)..."
if [ -f requirements.txt ]; then
  pip install --no-cache-dir -r requirements.txt
else
  # try installing package if setup.py/pyproject exists
  if [ -f setup.py ] || [ -f pyproject.toml ]; then
    pip install --no-cache-dir .
  fi
fi

# Make a best-effort to run sherlock. Try common entrypoints.
echo "[run.sh] Running sherlock for username: $USERNAME"
TIMESTAMP=$(date -u +"%Y%m%dT%H%M%SZ")
OUTFILE="$OUTPUT_DIR/sherlock_${USERNAME}_${TIMESTAMP}.txt"

# Try direct script or module execution
if [ -f sherlock.py ]; then
  python3 sherlock.py "$USERNAME" >"$OUTFILE" 2>&1 || true
elif [ -d sherlock ] && python3 -c "import importlib,sys; importlib.import_module('sherlock')" >/dev/null 2>&1; then
  python3 -m sherlock "$USERNAME" >"$OUTFILE" 2>&1 || true
else
  # Fallback: try the CLI script name used by the project
  # (best-effort; if this fails user may need to adjust)
  python3 -m sherlock "$USERNAME" >"$OUTFILE" 2>&1 || true
fi

echo "[run.sh] Output saved to $OUTFILE"
echo "=== TAIL OF OUTPUT ==="
tail -n 200 "$OUTFILE" || true

# Keep container alive briefly so Render can show logs; then exit (one-shot worker)
sleep 2
echo "[run.sh] Completed."

#!/bin/bash

echo "entrypoint"
while true; do
    sphinx-autobuild --host 0.0.0.0 . _build

    if [ $? -ne 0 ]; then
        echo "Command failed. Retrying in 5 seconds..."
        sleep 5
    fi
done

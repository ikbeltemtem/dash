#!/bin/bash

# Remove existing ConfigMap YAML files
rm -f configmaps/*.yaml

# Loop through JSON files in the json/ directory
for file in json/*.json; do
    # Get the base name of the JSON file
    filename=$(basename -- "$file")
    configmapname="${filename%.*}"

    # Generate ConfigMap YAML
    cat <<EOF > "configmaps/${configmapname}.yaml"
apiVersion: v1
kind: ConfigMap
metadata:
  name: ${configmapname}
  namespace: monitoring
  labels:
    grafana_dashboard: "1"
data:
  ${filename}: |-
$(cat "$file" | sed 's/^/    /')
EOF
done

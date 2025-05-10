## Quick Start

### 1. Create Docker Network
```bash
docker network create tasks-metrics-net
```

### 2. Build the Exporter Image
```bash
docker build -t tasks-exporter-app .
```

### 3. Run the Metrics Exporter
```bash
docker run -d \
  --name tasks-exporter-app \
  --network tasks-metrics-net \
  -p 5003:5000 \
  tasks-exporter-app
```

### 4. Feed test data set to the tasks-exporter
```bash
scripts/feed_tests_data.sh
```

### 5. Run Prometheus
```bash
docker run -d \
  --name prometheus \
  --network tasks-metrics-net \
  -p 9090:9090 \
  -v ${PWD}/prometheus.yml:/etc/prometheus/prometheus.yml \
  prom/prometheus
```

## Verification

### 1. Check Exporter
```bash
curl http://localhost:5003/metrics
```

### 2. Check Prometheus
```bash
curl http://localhost:9090/targets
```

### 3. Test the query:
1. Open Prometheus UI at `http://localhost:9090`

2. Go to "Graph" tab

3. Paste the query `max by (tool) (task_duration_seconds)` in the expression input

4. Click "Execute"

## Port Mappings
| Service       | Container Port | Host Port |
|---------------|----------------|-----------|
| Exporter App  | 5000           | 5003      |
| Prometheus    | 9090           | 9090      |
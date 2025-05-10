"""
Prometheus Metrics Exporter for Task Monitoring
"""

import os
import yaml
from flask import Flask, request, Response
from prometheus_client import Gauge, generate_latest, CollectorRegistry


def load_config():
    """
    Load application configuration with priority order:
    1. Environment variables
    2. config.yaml file
    3. Default values

    Returns:
        dict: Configuration settings including host, port, and debug mode
    """
    # Default configuration fallback
    config = {
        'host': '0.0.0.0',  # Bind to all interfaces by default
        'port': 5000,        # Default Flask development port
        'debug': False       # Production-safe default
    }

    try:
        # Attempt to load from YAML configuration file
        with open('config.yaml') as f:
            yaml_config = yaml.safe_load(f).get('app', {})
            config.update(yaml_config)
    except (FileNotFoundError, yaml.YAMLError):
        # Silent fallback to defaults if config file is missing/invalid
        pass

    # Environment variable overrides
    config['host'] = os.getenv('APP_HOST', config['host'])
    config['port'] = int(os.getenv('APP_PORT', config['port']))
    config['debug'] = os.getenv('APP_DEBUG', str(config['debug'])).lower() in ['true', '1']

    return config


# Flask Application Setup
app = Flask(__name__)

# Prometheus Configuration
# Using custom registry to avoid default metrics collection
custom_registry = CollectorRegistry()

# Metric Definition
task_duration = Gauge(
    'task_duration_seconds',            # Metric name
    'Duration of tasks in seconds',     # Help text
    ['tool', 'task', 'status'],         # Labels for dimensional data
    registry=custom_registry            # Custom registry to isolate metrics
)


@app.route('/api/tasks', methods=['POST'])
def handle_task():
    """
    Receive task data and update metrics.

    Expected JSON:
    {
        "tool": "tool-name",
        "task": "task-name",
        "status": "completed|failed|succeeded",
        "duration": number
    }

    Returns:
        Response: HTTP 200 on success, 400 on invalid data
    """
    data = request.get_json()

    # Validate required fields
    required = {'tool', 'task', 'status', 'duration'}
    if missing := required - set(data):
        return f"Missing fields: {', '.join(missing)}", 400

    # Validate status value
    if data['status'] not in {'completed', 'failed', 'succeeded'}:
        return "Invalid status", 400

    # Validate duration format
    try:
        duration = float(data['duration'])
        if duration < 0:
            raise ValueError("Duration cannot be negative")
    except ValueError:
        return "Invalid duration", 400

    # Update Prometheus metric with task data
    task_duration.labels(
        tool=data['tool'],
        task=data['task'],
        status=data['status']
    ).set(duration)

    return "Task received", 200


@app.route('/metrics')
def metrics():
    """
    Expose Prometheus metrics endpoint.

    Returns:
        Response: Text format metrics data
    """
    return Response(
        generate_latest(custom_registry),  # Generate metrics from custom registry
        mimetype='text/plain'              # Prometheus expects text/plain
    )


# Main Execution
if __name__ == '__main__':
    # Load configuration and start Flask server
    config = load_config()
    app.run(
        host=config['host'],      # Bind address
        port=config['port'],      # Listening port
        debug=config['debug']     # Debug mode (disable in production!)
    )

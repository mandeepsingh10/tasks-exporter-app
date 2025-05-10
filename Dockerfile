# Dockerfile

FROM python:3.13-slim

WORKDIR /app

# Copy the requirements file into the container at /app 
COPY requirements.txt .

RUN pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]

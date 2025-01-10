# Base stage using the official Python runtime base image
FROM python:3.11-slim AS base

# Add curl for health checks
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /usr/local/app

# Install dependencies from requirements.txt
COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Development stage with tools for live file watching
FROM base AS dev
RUN pip install watchdog
ENV FLASK_ENV=development
CMD ["python", "app.py"]

# Production stage optimized for deployment
FROM base AS final

# Copy application code to the container
COPY . .

# Expose port 80 for the application
EXPOSE 80

# Define the command to run the application in production
CMD ["gunicorn", "app:app", "-b", "0.0.0.0:80", "--log-file", "-", \
     "--access-logfile", "-", "--workers", "4", "--keep-alive", "0"]


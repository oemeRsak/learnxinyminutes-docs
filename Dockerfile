# Use Python base image
FROM python:3.10-slim

# Install git and any other dependencies
RUN apt-get update && apt-get install -y git && apt-get clean

# Set work directory
WORKDIR /app

# Clone the main site
RUN git clone https://github.com/adambard/learnxinyminutes-site

# Clone your fork of the docs repo into the nested location
# Replace <YOUR-USERNAME> with your actual GitHub username
RUN git clone https://github.com/adambard/learnxinyminutes-docs ./learnxinyminutes-site/source/docs/

# Set working directory to the cloned site
WORKDIR /app/learnxinyminutes-site

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Build the site
RUN python build.py

# Expose the port for HTTP server
EXPOSE 8000

# Serve the built site
WORKDIR /app/learnxinyminutes-site/build
CMD ["python", "-m", "http.server", "8000"]


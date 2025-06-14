# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    # For PyAudio
    portaudio19-dev \
    libasound2-dev \
    # For other potential audio/video dependencies
    ffmpeg \
    # For building python packages
    gcc \
    libc6-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application's code into the container
COPY . .

# Install the application
RUN pip install .

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Define environment variable
ENV NAME World

# Run api.py when the container launches
ENV PYTHONPATH=/app
CMD ["python3", "api.py"]

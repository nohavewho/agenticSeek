# Stage 1: Build the React application
FROM node:18-alpine as frontend-builder

WORKDIR /app/frontend/agentic-seek-front

COPY frontend/agentic-seek-front/package.json ./
COPY frontend/agentic-seek-front/package-lock.json ./

RUN npm install

COPY frontend/agentic-seek-front/. .

ENV REACT_APP_BACKEND_URL=https://agenticseek-production.up.railway.app

RUN npm run build

# Stage 2: Build the Python backend
FROM python:3.10-slim

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

# Copy the built frontend files from the frontend-builder stage
COPY --from=frontend-builder /app/frontend/agentic-seek-front/build /app/frontend/agentic-seek-front/build

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Define environment variable
ENV NAME World

# Run api.py when the container launches
ENV PYTHONPATH=/app
CMD ["python3", "api.py"]

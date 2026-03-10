FROM python:3.11-slim

# Install pipx
RUN apt-get update && apt-get install -y pipx
RUN pipx ensurepath

# Install poetry
RUN pip3 install poetry

# Set the working directory
WORKDIR /app

# Install poetry dependencies
COPY pyproject.toml ./
RUN pipx run poetry install --no-root

# Copy application to the working directory
COPY todo todo

# Running the application
CMD ["pipx", "run", "poetry", "run", "flask", "--app", "todo", "run", "--host", "0.0.0.0", "--port", "6400"]

# Adding a delay to our application startup 
CMD ["bash", "-c", "sleep 10 && pipx run poetry run flask --app todo run --host 0.0.0.0 --port 6400"]
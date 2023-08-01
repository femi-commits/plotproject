#Dockerfile

# Use the official Python image as the base image
FROM python:3.9

# Set environment variables
ENV db_root_password=root
ENV db_name=flask_db
ENV MYSQL_SERVICE_HOST=mysql_service
ENV MYSQL_SERVICE_PORT=3306

# Create and set the working directory inside the container
WORKDIR /app

# Copy the Flask application code and requirements file into the container
COPY . /app

# Install the Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install the 'markupsafe' package
#RUN pip install markupsafe==2.0.1

# Expose the Flask app's port
EXPOSE 5000

# Run the Flask app
CMD ["python", "userapi.py"]

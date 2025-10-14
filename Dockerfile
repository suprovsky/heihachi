# Use a regular distro-containing image as our build container
FROM python:3.11 AS builder

# Install our dependencies in the build container
COPY . .
RUN pip install . --no-cache-dir setuptools

# Ensure pip, setuptools, and wheel don't piggyback into our application container
RUN rm -r /usr/local/lib/python3.11/site-packages/pip*

# Switch to distroless+nonroot for our application container
# USER: nonroot
# WORKDIR: /home/nonroot/
FROM gcr.io/distroless/python3-debian12:nonroot

# Copy the packages we need from our build container
COPY --from=builder /usr/local/lib/python3.11/site-packages \
  /usr/local/lib/python3.11/site-packages

# Set environment variable so Python can find the packages we installed
ENV PYTHONPATH=/usr/local/lib/python3.11/site-packages

# Install our application to nonroot
COPY . /home/nonroot
#ENTRYPOINT ["python3", "-V"]
ENTRYPOINT ["python3", "/home/nonroot/src/main.py", "/config.json", "--export_dir", "."]
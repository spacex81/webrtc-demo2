# Use the official Go image to create a build artifact.
# This is based on Debian and sets the GOPATH environment variable at /go.
FROM golang:1.18 as builder

# Set environment variables to ensure the binary is built for Linux.
ENV GOOS=linux GOARCH=amd64

# Create and change to the app directory.
WORKDIR /app

# Retrieve application dependencies using go mod.
COPY go.* ./
RUN go mod download

# Copy local code to the container image and build the binary.
COPY . ./
RUN go build -v -o /app/server

# Use the official Debian slim image for a lean production container.
FROM debian:buster-slim
WORKDIR /app

# Copy the binary and any other necessary files to the production image from the builder stage.
COPY --from=builder /app/server /app/server
COPY --from=builder /app/index.html /app/index.html

EXPOSE 8080

# Run the web service on container startup.
CMD ["/app/server"]

# Use the official Go image to create a build artifact.
# This is based on Debian and sets the GOPATH environment variable at /go.
FROM golang:1.18 as builder

# Create and change to the app directory.
WORKDIR /app

# Retrieve application dependencies using go mod.
# This allows the container build to reuse the Go build cache
# if the go.mod and go.sum files haven't changed.
COPY go.* ./
RUN go mod download

# Copy local code to the container image.
COPY . ./

# Build the binary.
# -o /app/server specifies the output path and file name for the binary.
RUN CGO_ENABLED=0 GOOS=linux go build -v -o /app/server

# Use the official Debian slim image for a lean production container.
FROM debian:buster-slim
WORKDIR /app

# Copy the binary to the production image from the builder stage.
COPY --from=builder /app/server /app/server

# Copy other files you might need, such as the HTML template.
COPY --from=builder /app/index.html /app/index.html

EXPOSE 8080

# Run the web service on container startup.
CMD ["/app/server"]


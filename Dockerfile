FROM alpine:latest AS builder
WORKDIR /app
RUN apk --no-cache add curl unzip
RUN curl -fL "https://gchq.github.io/CyberChef/$(curl -s https://gchq.github.io/CyberChef/ | tr '\=' '\n' | tr ' ' '\n' | grep "\.zip" | tr -d '\"')" -o "src.zip" && unzip "src.zip" && rm "src.zip"
RUN mv "$(ls | grep html)" "index.html"

FROM nginx:alpine
COPY --from=builder /app /usr/share/nginx/html

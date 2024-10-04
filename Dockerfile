#Stage 1 - build the app in a build environment
FROM us-central1-docker.pkg.dev/ff-gcp-ent-demos/ff-docker-repo/custom-ff-builder:v1 AS build-env
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter build web
# Stage 2 - Create the run-time image
FROM nginx:1.25.5-alpine-slim
COPY --from=build-env /app/build/web /usr/share/nginx/html
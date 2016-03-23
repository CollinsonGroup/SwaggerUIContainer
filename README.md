# Collinson Swagger UI

This is a Docker container for hosting Swagger UI JSON definitions with SwaggerUI 2.1.4 and nginx
1.9.12.  It operates by mounting the file from an external volume (this is optional: by default 
you can use the example petstore file, which is included) and hosting via nginx as a static file.

Based somewhat loosely on https://github.com/capoferro/swagger-ui-docker/ and the official nginx container.

## When to use this

We had a requirement to host a UI for Swagger API definitions that were not currently part of an existing 
API, and be able to update them via continuous deployment when changes were checked in against the
definition file. The solution for us is to create an opinionated container which combines the static
HTML files from Swagger UI with a basic nginx instance, and mounts a `swagger.json` file as a volume.

Using the container means we can apply this pattern to multiple projects, only needing to change the JSON
file each time. (Internally we use Docker Compose and some simple bash build scripts to automate this
process so we can deploy on every change to the Swagger definition.)

## How it's put together

The image is based on nginx 1.9.12. We inject a custom `nginx.conf` file to make it forward all
requests to the /swaggerui directory.

We create a /swaggerui directory on the image and pull down Swagger UI v2.1.4 from GitHub, extracting
the relevant files and deleting anything we don't need for just the static page.

We then replace the default petstore URL with one which will point to our own JSON.

Finally we clean up any packages we needed to install during the build process, and declare the volume
mount point.

## Building

In order to build the container manually, execute the following in the checkout directory:

```bash
docker build -t collinsongroup/swaggerui:$version .
```

## Running

In order to run the container once it has been built (or to pull it from Docker Hub):

```bash
docker run -p 80:80 --name some-swagger collinsongroup/swaggerui:$version
```

This will host SwaggerUI on port 80 using the default petstore JSON. If you want to supply your own JSON file,
you will need to make use of the volume facility. In order to do this, assuming your JSON file is in
`/path/to/swagger.json` issue the following:

```bash
docker run -p 80:80 --name some-swagger -v /path/to/swagger.json:/swaggerui/swagger/swagger.json:ro collinsongroup/swaggerui:$version
```

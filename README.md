# Collinson Swagger UI

This is a Docker container for hosting Swagger UI JSON definitions with SwaggerUI 2.1.4. 
It operates by mounting the file from an external volume (optional: by default you can use the petstore
file) and hosting via nginx as a static file.

Based somewhat loosely on https://github.com/capoferro/swagger-ui-docker/ and the official nginx container.

## Building

In order to build the container manually:

```bash
docker build -t collinsongroup/swaggerui:$version .
```

## Running

In order to run the container:

```bash
docker run -p 80:80 --name some-swagger collinsongroup/swaggerui:$version
```

This will host SwaggerUI on port 80 using the default petstore JSON. If you want to supply your own JSON file,
you will need to make use of the volume facility. In order to do this, assuming your JSON file is in
`/path/to/swagger.json` issue the following:

```bash
docker run -p 80:80 --name some-swagger -v /path/to/swagger.json:/swaggerui/swagger/swagger.json:ro collinsongroup/swaggerui:$version
```

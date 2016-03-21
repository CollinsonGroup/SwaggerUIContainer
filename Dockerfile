FROM nginx

# Set up the directories and install unzip
RUN 	mkdir /swaggerui && \
	mkdir /swaggerui/swagger && \
	apt-get update && \
	apt-get install -y unzip

# We pull in our own config files, and get a specific version of SwaggerUI
ADD https://github.com/swagger-api/swagger-ui/archive/v2.1.4.zip /swaggerui
ADD src/nginx.conf /etc/nginx/nginx.conf
ADD src/swagger.json /swaggerui/swagger/swagger.json

WORKDIR /swaggerui

# Unpack the Swagger files, copy distribution to root, and change the URL from petstore
# to our local JSON file
RUN unzip v2.1.4.zip && \
	mv swagger-ui-2.1.4/dist/* . && \
	rm -r swagger-ui-2.1.4 && \
	sed -i s/http:\\/\\/petstore.swagger.io\\/v2\\/swagger.json/\\/swagger\\/swagger.json/ index.html

# Remove unzip
RUN apt-get remove -y unzip

# Make the location with the example Swagger JSON file mountable
VOLUME ["/swaggerui/swagger"]

EXPOSE 80

CMD ["nginx"]


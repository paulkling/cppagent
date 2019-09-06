FROM ubuntu:bionic AS base
RUN apt-get update && \
	apt-get install -y build-essential git cmake libxml2 cppunit && \
    rm -rf /var/lib/apt/lists/*

FROM base AS build
WORKDIR /usr/src
COPY . .
RUN cmake .
RUN make


FROM ubuntu:bionic
WORKDIR /opt/app/web
COPY web/ .
WORKDIR /opt/app
COPY --from=build /usr/src/http_examples ./
EXPOSE 8080
CMD ["./http_examples"]

# A proxy server app for open weather api.
It is built using [Shelf](https://pub.dev/packages/shelf) and [shelf_rate_limiter](https://pub.dev/packages/shelf_rate_limiter).

This code handles HTTP GET requests to `/api`.

By default it allows 10 request from single IP in 60 seconds. You can configure that in `bin/server.dart` file.

<br>
<br>

# Running the sample

## Running with the Dart SDK

You can run the example with the [Dart SDK](https://dart.dev/get-dart)
like this:

```
$ dart run bin/server.dart
Server listening on port 8080
```

And then from a second terminal:
```
$ curl http://0.0.0.0:8080/api?q=City_Name
```
You should see the logging printed in the first terminal.

<br>
<br>

## Running with Docker

If you have [Docker Desktop](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

```
$ docker build . -t myserver
$ docker run -it -p 8080:8080 myserver
Server listening on port 8080
```

And then from a second terminal:
```
$ curl http://0.0.0.0:8080/api?q=City_Name

```

You should see the logging printed in the first terminal.

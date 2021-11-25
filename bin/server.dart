import 'dart:io';
import 'package:shelf_rate_limiter/shelf_rate_limiter.dart';
import 'package:proxy_server/route.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

void main(List<String> args) async {
  final memoryStorage = MemStorage();
  final rateLimiter = ShelfRateLimiter(
      storage: memoryStorage, duration: Duration(seconds: 60), maxRequests: 10);
  final ip = InternetAddress.anyIPv4;
  final api = Api();
  final _handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(rateLimiter.rateLimiter())
      .addHandler(api.router);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(_handler, ip, port);
  print('Server listening on port ${server.port}');
}

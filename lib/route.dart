import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

const apiKey = "SECRET";
const url = "api.openweathermap.org";
const path = "/data/2.5/weather";

class Api {
  Future<Response> apiHandler(Request request) async {
    var city = request.url.queryParameters["q"];
    if (city == null) {
      return Response.notFound("Please provide city name in the query {'q'}.");
    }
    final uri = Uri.https(url, path, {
      "q": city.trim(),
      "appid": apiKey,
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return Response(200,
          body: response.body,
          encoding: Encoding.getByName("utf-8"),
          headers: {"Content-Type": "application/json"});
    } else {
      return Response.notFound(jsonDecode(response.body)['message']);
    }
  }

  Router get router {
    final router = Router();
    router.get('/api', apiHandler);
    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Page not found');
    });

    return router;
  }
}

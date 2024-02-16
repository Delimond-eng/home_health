import 'dart:developer';

import 'package:http/http.dart' as http;

import 'dart:convert';

class Api {
  static String baseUrl = 'http://backend.homehealth.milleniumhorizon.com/api';

  // ignore: slash_for_doc_comments
  /** 
    @param url: add url to endpoint
    @param method[post, get]
    @param body[Map<String, dynamic> body] to pass from endpoint
    @param headers[http Headers]
  **/
  static Future request(String? url,
      {String? method, Map<String, dynamic>? body}) async {
    late http.Response response;
    try {
      switch (method) {
        case "post":
          response = await http.post(
            Uri.parse("$baseUrl$url"),
            body: jsonEncode(body),
            headers: {'Content-Type': 'application/json'},
          );
          break;
        case "get":
          response = await http.get(
            Uri.parse("$baseUrl$url"),
            headers: {'Content-Type': 'application/json'},
          );
          break;
        default:
          response = await http.get(
            Uri.parse("$baseUrl$url"),
            headers: {'Content-Type': 'application/json'},
          );
      }
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString(), name: "HttpError");
      return null;
    }
  }
}

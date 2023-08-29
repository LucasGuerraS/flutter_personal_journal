import 'dart:convert';

import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/services/http_interceptors.dart';
import "package:http/http.dart" as http;
import 'package:http_interceptor/http_interceptor.dart';

class JournalService {
  static const String url = "http://192.168.0.29:3000/";
  static const String resource = "journals";

  http.Client client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  getUrl() {
    return "$url$resource";
  }

  Future<bool> register(Journal journal) async {
    String content = json.encode(journal.toMap());
    http.Response response = await client.post(
      Uri.parse(getUrl()),
      headers: {"Content-type": "application/json"},
      body: content,
    );
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<String> get() async {
    http.Response response = await client.get(Uri.parse(getUrl()));
    return response.body;
  }
}

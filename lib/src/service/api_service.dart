import 'dart:convert';

import 'package:corasa_core/src/config/constants.dart';
import 'package:corasa_core/src/exception/response_exception.dart';
import 'package:corasa_core/src/model/generic_response.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  String? _token;
  SharedPreferences? _storage;
  final String baseUrl;
  final int? urlPort;
  final Client _client;

  ApiService(this.baseUrl, this.urlPort) : _client = Client();

  Future<Map<String, String>> getHeaders(
      {final String contentType = 'application/json; charset=UTF-8'}) async {
    _storage ??= await SharedPreferences.getInstance();
    final Map<String, String> heads = {
      'Content-Type': contentType,
      'Accept': 'application/json; charset=UTF-8'
    };
    if (_token?.isEmpty ?? true) {
      _token = _storage!.getString(Constants.storageJwtKey);
    }
    if (_token?.isNotEmpty ?? false) {
      heads.putIfAbsent('Authorization', () => 'Bearer $_token');
    }
    return heads;
  }

  Future<void> setToken(String token, {bool? remember = false}) async {
    _storage ??= await SharedPreferences.getInstance();
    _token = token;
    if (remember ?? false) {
      await _storage!.setString(Constants.storageJwtKey, token);
    }
  }

  Future<Response> doGetRequest(String endpoint,
      {final Map<String, dynamic>? query}) async {
    if (!endpoint.startsWith('/')) endpoint = '/$endpoint';
    final Response response = await _client.get(
      Uri.http('$baseUrl:$urlPort', endpoint, query),
      headers: await getHeaders(),
    );
    if (response.statusCode.toString().startsWith('2')) {
      return response;
    } else {
      final GenericResponse genericResponse =
          GenericResponse.fromMap(jsonDecode(response.body));
      throw ResponseException(
        message: genericResponse.message,
        details: genericResponse.details,
      );
    }
  }

  Future<Response> doPostRequest(String endpoint, final dynamic request,
      {final Map<String, String>? query}) async {
    if (!endpoint.startsWith('/')) endpoint = '/$endpoint';
    final Response response = await _client.post(
      Uri.http('$baseUrl:$urlPort', endpoint, query),
      headers: await getHeaders(),
      body: request != null ? jsonEncode(request) : null,
    );
    if (response.statusCode.toString().startsWith('2')) {
      return response;
    } else {
      final GenericResponse genericResponse = GenericResponse.fromMap(
          jsonDecode(response.body),
          fromMap: (value) => value.toString());
      throw ResponseException(
        message: genericResponse.message,
        details: genericResponse.details,
      );
    }
  }

  Future<Response> doPutRequest(
      String endpoint, final Map<String, dynamic>? request,
      {Map<String, String>? query, Object? body}) async {
    if (!endpoint.startsWith('/')) endpoint = '/$endpoint';
    final Response response = await _client.put(
      Uri.http('$baseUrl:$urlPort', endpoint, query),
      headers: await getHeaders(),
      body: body ?? (request == null ? null : jsonEncode(request)),
    );
    if (response.statusCode.toString().startsWith('2')) {
      return response;
    } else {
      final GenericResponse genericResponse =
          GenericResponse.fromMap(jsonDecode(response.body));
      throw ResponseException(
        message: genericResponse.message,
        details: genericResponse.details,
      );
    }
  }

  Future<Response> doDeleteRequest(String endpoint,
      {dynamic request, final Map<String, String>? query}) async {
    if (!endpoint.startsWith('/')) endpoint = '/$endpoint';
    final Response response = await _client.delete(
      Uri.http('$baseUrl:$urlPort', endpoint, query),
      headers: await getHeaders(),
      body: request != null ? jsonEncode(request) : null,
    );
    if (response.statusCode.toString().startsWith('2')) {
      return response;
    } else {
      final GenericResponse genericResponse = GenericResponse.fromMap(
          jsonDecode(response.body),
          fromMap: (value) => value.toString());
      throw ResponseException(
        message: genericResponse.message,
        details: genericResponse.details,
      );
    }
  }

  Future<Response> doUploadRequest(String endpoint,
      {required MultipartFile file, Map<String, String>? query}) async {
    if (!endpoint.startsWith('/')) endpoint = '/$endpoint';
    Uri uri = Uri.http('$baseUrl:$urlPort', endpoint, query);

    MultipartRequest request = MultipartRequest('POST', uri)
      ..headers.addAll(await getHeaders())
      ..files.add(file);

    final streamedResponse = await request.send();
    final response = await Response.fromStream(streamedResponse);

    if (response.statusCode.toString().startsWith('2')) {
      return response;
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final GenericResponse genericResponse =
          GenericResponse.fromMap(responseBody);
      throw ResponseException(
        message: genericResponse.message,
        details: genericResponse.details,
      );
    }
  }
}

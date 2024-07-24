import 'dart:convert';

import 'package:corasa_core/src/exception/response_exception.dart';
import 'package:corasa_core/src/model/catalogos.dart';
import 'package:corasa_core/src/model/generic_response.dart';
import 'package:corasa_core/src/service/api_service.dart';
import 'package:http/http.dart';

abstract class CatalogoService<T extends CatalogosModel> {
  final ApiService service;
  final String baseEndpoint;

  CatalogoService(this.service, this.baseEndpoint);

  T fromMap(Map<String, dynamic> map);

  Future<List<T>> getAll() async {
    Response callback = await service.doGetRequest(baseEndpoint);
    if (callback.statusCode.toString().startsWith('2')) {
      if (callback.statusCode == 204) return [];
      List<dynamic> list = jsonDecode(callback.body);
      return list.map<T>((e) => fromMap(e)).toList();
    } else {
      GenericResponse response = GenericResponse.fromMap(
          jsonDecode(callback.body),
          fromMap: (value) => value);
      throw ResponseException(
        message: response.message,
        details: response.details,
      );
    }
  }

  Future<T> getById(int id) async {
    Response callback = await service.doGetRequest('$baseEndpoint/$id');
    if (callback.statusCode.toString().startsWith('2')) {
      return fromMap(jsonDecode(callback.body));
    } else {
      GenericResponse response = GenericResponse.fromMap(
          jsonDecode(callback.body),
          fromMap: (value) => value);
      throw ResponseException(
        message: response.message,
        details: response.details,
      );
    }
  }

  Future<T> onSave(T request) async {
    Response callback;
    if (request.id == null) {
      callback = await service.doPostRequest(baseEndpoint, request.toMap());
    } else {
      callback = await service.doPutRequest(
          '$baseEndpoint/${request.id}', request.toMap());
    }
    if (callback.statusCode.toString().startsWith('2')) {
      return fromMap(jsonDecode(callback.body));
    } else {
      GenericResponse response = GenericResponse.fromMap(
          jsonDecode(callback.body),
          fromMap: (value) => value);
      throw ResponseException(
        message: response.message,
        details: response.details,
      );
    }
  }
}

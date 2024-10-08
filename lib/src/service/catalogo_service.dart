import 'dart:convert';

import 'package:corasa_core/src/exception/response_exception.dart';
import 'package:corasa_core/src/model/catalogos.dart';
import 'package:corasa_core/src/model/generic_response.dart';
import 'package:corasa_core/src/service/pageable_service.dart';
import 'package:http/http.dart';

abstract class CatalogoService<T extends CatalogosModel>
    extends PageableService<T> {
  CatalogoService(super.service, super.baseEndpoint);

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

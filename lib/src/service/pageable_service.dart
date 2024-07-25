import 'dart:convert';

import 'package:corasa_core/src/exception/response_exception.dart';
import 'package:corasa_core/src/model/generic_response.dart';
import 'package:corasa_core/src/model/pageable/page_request.dart';
import 'package:corasa_core/src/model/pageable/page_response.dart';
import 'package:corasa_core/src/service/api_service.dart';
import 'package:http/http.dart';

abstract class PageableService<T> {
  final ApiService service;
  final String baseEndpoint;

  PageableService(this.service, this.baseEndpoint);

  T fromMap(Map<String, dynamic> map);

  Future<PageResponse<T>> getAll(
      {String? endpoint,
      required PageRequest pageRequest,
      Map<String, String>? query}) async {
    Response callback = await service.doGetRequest(
      endpoint ?? baseEndpoint,
      query: (pageRequest.toMap())..addAll(query ?? {}),
    );
    if (callback.statusCode.toString().startsWith('2')) {
      if (callback.statusCode == 204) {
        return PageResponse(
          totalPages: 0,
          totalElements: 0,
          first: true,
          last: true,
          size: 0,
          content: [],
          number: 0,
          sort: null,
          numberOfElements: 0,
          empty: true,
        );
      }
      return PageResponse.fromMap(
        jsonDecode(callback.body),
        (map) => fromMap(map),
      );
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

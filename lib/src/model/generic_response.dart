import 'package:equatable/equatable.dart';

class GenericResponse<T> extends Equatable {
  final String? message;
  final List<String>? details;
  final T? response;

  const GenericResponse({this.message, this.details, this.response});

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'details': details,
      'response': response,
    };
  }

  factory GenericResponse.fromMap(final Map<String, dynamic> map,
      {final Function(dynamic)? fromMap}) {
    return GenericResponse<T>(
      message: map['message'],
      details: map['details']?.map<String>((e) => e.toString()).toList(),
      response: fromMap != null ? fromMap(map['response']) : map['response'],
    );
  }

  @override
  List<Object?> get props => [message, List.of(details ?? []), response];
}

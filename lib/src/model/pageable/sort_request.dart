import 'package:corasa_core/src/enum/pageable_direction.dart';

class SortRequest {
  final String property;
  final PageableDirection direction;

  SortRequest({required this.property, required this.direction});

  String toMap() => '$property,${direction.name}';
}

import 'package:iyojana/scheme/scheme.dart';

class SchemeCategory{
  String id;
  String name;
  List<Scheme> schemes;
  bool isFollwed;
  String description;

  SchemeCategory({
     required this.id,
     required this.name,
     required this.schemes,
     required this.isFollwed,
     required this.description,
  });
}

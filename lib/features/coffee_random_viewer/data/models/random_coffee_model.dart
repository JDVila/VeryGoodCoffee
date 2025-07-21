import 'dart:convert';

import 'package:meta/meta.dart';

@immutable
class RandomCoffeeModel {
  const RandomCoffeeModel({required this.file});
  factory RandomCoffeeModel.fromJson(String source) =>
      RandomCoffeeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory RandomCoffeeModel.fromMap(Map<String, dynamic> map) {
    return RandomCoffeeModel(
      file: map['file'] as String,
    );
  }

  final String file;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file': file,
    };
  }

  String toJson() => json.encode(toMap());
}

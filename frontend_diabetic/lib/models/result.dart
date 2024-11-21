// lib/models/result.dart

import 'dart:convert';

class Result {
  final String timestamp;
  final String recomendacao;
  final List<String> responses;

  Result({
    required this.timestamp,
    required this.recomendacao,
    required this.responses,
  });

  // Converter Result para JSON
  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'recomendacao': recomendacao,
      'responses': responses,
    };
  }

  // Criar Result a partir de JSON
  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      timestamp: json['timestamp'],
      recomendacao: json['recomendacao'],
      responses: List<String>.from(json['responses']),
    );
  }

  // Converter Result para String JSON
  String toJsonString() => jsonEncode(toJson());

  // Criar Result a partir de String JSON
  factory Result.fromJsonString(String jsonString) =>
      Result.fromJson(jsonDecode(jsonString));
}

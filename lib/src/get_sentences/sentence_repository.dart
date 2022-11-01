import 'dart:developer';

import 'package:hp_api/src/models/characters_model.dart';
import 'package:dio/dio.dart';

class SentenceRepository {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://hp-api.herokuapp.com/api',
      headers: {
        'Content-type': 'application/json',
      },
    ),
  );

  Future<List<Characters>> getSentence() async {
    try {
      final response = await dio.get('/characters');

      final data = List.from(response.data);

      final mapList = data.map((e) => Map<String, dynamic>.from(e)).toList();

      return mapList.map((e) => Characters.fromMap(e)).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

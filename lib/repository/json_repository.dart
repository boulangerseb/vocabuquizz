import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../models/word.dart';

class JsonRepository {
  Future<String> loadJson() async {
    return await rootBundle.loadString('assets/datas.json');
  }

  Future<List<Word>> loadAndDecodeJson() async {
    List<Word> result = List<Word>.empty();
    String jsonString = await loadJson();
    dynamic json = jsonDecode(jsonString);
    result = (json['vocabulary'] as List).map((json) => Word.fromJson(json)).toList();
    return result;
  }
}
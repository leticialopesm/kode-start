import 'package:dio/dio.dart';
import '../models/character_model.dart';

class ApiService {
  ApiService._();
  static final ApiService instance = ApiService._();

  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://rickandmortyapi.com/api',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
  ));

  Future<({List<Character> results, String? next})> getCharacters({
    int page = 1,
    String? name,
  }) async {
    final query = {
      'page': page.toString(),
      if (name != null && name.trim().isNotEmpty) 'name': name.trim(),
    };
    final res = await _dio.get('/character', queryParameters: query);
    final data = res.data as Map<String, dynamic>;
    final info = data['info'] as Map<String, dynamic>;
    final next = info['next'] as String?;
    final list = (data['results'] as List).cast<Map<String, dynamic>>();
    final results = list.map(Character.fromJson).toList();
    return (results: results, next: next);
  }

  Future<Character> getCharacterDetail(int id) async {
    final res = await _dio.get('/character/$id');
    return Character.fromJson(res.data as Map<String, dynamic>);
  }

  // Para “primeira aparição”, buscamos o nome do 1º episódio
  Future<String?> getEpisodeNameFromUrl(String url) async {
    try {
      final res = await _dio.getUri(Uri.parse(url));
      return (res.data as Map<String, dynamic>)['name'] as String?;
    } catch (_) {
      return null;
    }
  }
}

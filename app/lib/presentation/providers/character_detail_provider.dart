import 'package:flutter/foundation.dart';
import '../../data/models/character_model.dart';
import '../../data/services/api_service.dart';

class CharacterDetailProvider extends ChangeNotifier {
  Character? character;
  bool loading = false;
  String? firstAppearance;
  bool error = false;

  Future<void> load(int id) async {
    loading = true;
    error = false;
    notifyListeners();
    try {
      character = await ApiService.instance.getCharacterDetail(id);
      if (character!.episodeUrls.isNotEmpty) {
        firstAppearance = await ApiService.instance
            .getEpisodeNameFromUrl(character!.episodeUrls.first);
      }
      error = false;
    } catch (_) {
      error = true;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}

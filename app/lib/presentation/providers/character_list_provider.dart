import 'package:flutter/foundation.dart';
import '../../data/models/character_model.dart';
import '../../data/services/api_service.dart';

class CharacterListProvider extends ChangeNotifier {
  final List<Character> _items = [];
  bool _loading = false;
  bool _error = false;
  bool _hasMore = true;
  int _page = 1;
  String _search = '';

  List<Character> get items => List.unmodifiable(_items);
  bool get loading => _loading;
  bool get error => _error;
  bool get hasMore => _hasMore;
  String get search => _search;

  Future<void> fetchFirstPage({String search = ''}) async {
    _items.clear();
    _page = 1;
    _hasMore = true;
    _search = search;
    notifyListeners();
    await _fetch();
  }

  Future<void> loadMore() async {
    if (_loading || !_hasMore) return;
    _page++;
    await _fetch(append: true);
  }

  Future<void> _fetch({bool append = false}) async {
    _loading = true;
    _error = false;
    notifyListeners();
    try {
      final res = await ApiService.instance
          .getCharacters(page: _page, name: _search.isEmpty ? null : _search);
      if (!append) _items.clear();
      _items.addAll(res.results);
      _hasMore = res.next != null;
      _error = false;
    } catch (_) {
      _error = true;
      _hasMore = false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}

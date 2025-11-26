import 'dart:convert';
import 'package:brewly/domain/entities/favourites.dart';
import 'package:brewly/domain/repositories/favourites_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: FavoritesRepo)
class FavoritesRepoImpl implements FavoritesRepo {
  final SharedPreferences _prefs;
  final SupabaseClient _supabase;

  FavoritesRepoImpl(this._prefs, this._supabase);

  // Get user-specific favorites key
  String get _favoritesKey {
    final userId = _supabase.auth.currentUser?.id ?? 'guest';
    return 'favorites_$userId';
  }

  @override
  Future<List<FavoriteItem>> getFavorites() async {
    final String? favoritesJson = _prefs.getString(_favoritesKey);
    if (favoritesJson == null) return [];

    final List<dynamic> favoritesList = json.decode(favoritesJson);
    return favoritesList
        .map(
          (item) => FavoriteItem(
            name: item['name'],
            type: item['type'],
            image: item['image'],
            description: item['description'],
            addedAt: DateTime.parse(item['addedAt']),
          ),
        )
        .toList();
  }

  @override
  Future<void> addFavorite(FavoriteItem item) async {
    final favorites = await getFavorites();

    final exists = favorites.any(
      (f) => f.name == item.name && f.type == item.type,
    );
    if (exists) return;

    favorites.add(item);
    await _saveFavorites(favorites);
  }

  @override
  Future<void> removeFavorite(String name, String type) async {
    final favorites = await getFavorites();
    favorites.removeWhere((f) => f.name == name && f.type == type);
    await _saveFavorites(favorites);
  }

  @override
  Future<bool> isFavorite(String name, String type) async {
    final favorites = await getFavorites();
    return favorites.any((f) => f.name == name && f.type == type);
  }

  Future<void> _saveFavorites(List<FavoriteItem> favorites) async {
    final favoritesJson = favorites
        .map(
          (item) => {
            'name': item.name,
            'type': item.type,
            'image': item.image,
            'description': item.description,
            'addedAt': item.addedAt.toIso8601String(),
          },
        )
        .toList();
    await _prefs.setString(_favoritesKey, json.encode(favoritesJson));
  }

  // Clear favorites when user signs out
  Future<void> clearFavorites() async {
    await _prefs.remove(_favoritesKey);
  }
}

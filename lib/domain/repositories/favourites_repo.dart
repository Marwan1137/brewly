import 'package:brewly/domain/entities/favourites.dart';

abstract class FavoritesRepo {
  Future<List<FavoriteItem>> getFavorites();
  Future<void> addFavorite(FavoriteItem item);
  Future<void> removeFavorite(String name, String type);
  Future<bool> isFavorite(String name, String type);
}

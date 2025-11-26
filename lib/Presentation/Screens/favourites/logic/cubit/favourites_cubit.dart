import 'package:brewly/Presentation/Screens/favourites/logic/cubit/favourites_state.dart';
import 'package:brewly/domain/entities/favourites.dart';
import 'package:brewly/domain/repositories/favourites_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepo _favoritesRepo;

  FavoritesCubit(this._favoritesRepo) : super(FavoritesInitial());

  Future<void> loadFavorites() async {
    try {
      emit(FavoritesLoading());
      final favorites = await _favoritesRepo.getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> toggleFavorite({
    required String name,
    required String type,
    required String image,
    required String description,
  }) async {
    try {
      final isFav = await _favoritesRepo.isFavorite(name, type);

      if (isFav) {
        await _favoritesRepo.removeFavorite(name, type);
      } else {
        await _favoritesRepo.addFavorite(
          FavoriteItem(
            name: name,
            type: type,
            image: image,
            description: description,
            addedAt: DateTime.now(),
          ),
        );
      }

      await loadFavorites();
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<bool> isFavorite(String name, String type) async {
    return await _favoritesRepo.isFavorite(name, type);
  }
}

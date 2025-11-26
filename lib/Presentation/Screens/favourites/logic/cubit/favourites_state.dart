import 'package:brewly/domain/entities/favourites.dart';
import 'package:flutter/material.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<FavoriteItem> favorites;
  FavoritesLoaded(this.favorites);
}

final class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}

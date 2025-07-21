part of 'coffee_favorites_bloc.dart';

@immutable
sealed class CoffeeFavoritesEvent {}

class LoadCoffeeFavoritesList extends CoffeeFavoritesEvent {}

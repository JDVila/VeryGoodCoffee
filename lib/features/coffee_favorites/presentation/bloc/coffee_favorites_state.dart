part of 'coffee_favorites_bloc.dart';

@immutable
sealed class CoffeeFavoritesState {
  const CoffeeFavoritesState({required this.entityList, this.errorMsg});

  final List<FavoriteCoffeeEntity> entityList;
  final String? errorMsg;
}

final class CoffeeFavoritesInitial extends CoffeeFavoritesState {
  const CoffeeFavoritesInitial({super.entityList = const []});
}

final class CoffeeFavoritesListLoading extends CoffeeFavoritesState {
  const CoffeeFavoritesListLoading({super.entityList = const []});
}

final class CoffeeFavoritesListLoaded extends CoffeeFavoritesState {
  const CoffeeFavoritesListLoaded({required super.entityList});
}

final class CoffeeFavoritesListError extends CoffeeFavoritesState {
  const CoffeeFavoritesListError({super.entityList = const [], super.errorMsg});
}

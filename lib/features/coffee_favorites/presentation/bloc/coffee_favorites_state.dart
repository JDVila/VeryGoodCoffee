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

final class CoffeeFavoritesListSuccess extends CoffeeFavoritesState {
  const CoffeeFavoritesListSuccess({required super.entityList});
}

final class CoffeeFavoritesListFailure extends CoffeeFavoritesState {
  const CoffeeFavoritesListFailure({
    super.entityList = const [],
    super.errorMsg,
  });
}

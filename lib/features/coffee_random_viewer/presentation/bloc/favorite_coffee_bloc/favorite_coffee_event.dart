part of 'favorite_coffee_bloc.dart';

@immutable
sealed class FavoriteCoffeeEvent {
  const FavoriteCoffeeEvent({required this.entity});
  final FavoriteCoffeeEntity entity;
}

class FavoriteCoffeeReset extends FavoriteCoffeeEvent {
  const FavoriteCoffeeReset({
    super.entity = const FavoriteCoffeeEntity(imageUrl: ''),
  });
}

class ClickFavoriteCoffee extends FavoriteCoffeeEvent {
  const ClickFavoriteCoffee({required super.entity});
}

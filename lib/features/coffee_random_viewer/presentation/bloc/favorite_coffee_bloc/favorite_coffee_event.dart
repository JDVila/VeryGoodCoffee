part of 'favorite_coffee_bloc.dart';

@immutable
sealed class FavoriteCoffeeEvent {
  const FavoriteCoffeeEvent({required this.entity});
  final FavoriteCoffeeEntity entity;
}

class ClickFavoriteCoffee extends FavoriteCoffeeEvent {
  const ClickFavoriteCoffee({required super.entity});
}

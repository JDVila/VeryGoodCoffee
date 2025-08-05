part of 'favorite_coffee_bloc.dart';

@immutable
sealed class FavoriteCoffeeState {}

final class FavoriteCoffeeInitial extends FavoriteCoffeeState {}

final class FavoriteCoffeeStateLoading extends FavoriteCoffeeState {}

final class FavoriteCoffeeAdded extends FavoriteCoffeeState {}

final class FavoriteCoffeeRemoved extends FavoriteCoffeeState {}

final class FavoriteCoffeeError extends FavoriteCoffeeState {}

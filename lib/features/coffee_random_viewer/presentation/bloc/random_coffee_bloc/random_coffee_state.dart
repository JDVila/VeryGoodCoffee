part of 'random_coffee_bloc.dart';

@immutable
sealed class RandomCoffeeState {
  const RandomCoffeeState({required this.entity});
  final RandomCoffeeEntity entity;
}

final class RandomCoffeeInitial extends RandomCoffeeState {
  const RandomCoffeeInitial({
    super.entity = const RandomCoffeeEntity(
      imageUrl: '',
    ),
  });
}

final class RandomCoffeeLoading extends RandomCoffeeState {
  const RandomCoffeeLoading({
    super.entity = const RandomCoffeeEntity(
      imageUrl: '',
    ),
  });
}

final class RandomCoffeeSuccess extends RandomCoffeeState {
  const RandomCoffeeSuccess({required super.entity});
}

final class RandomCoffeeFailure extends RandomCoffeeState {
  const RandomCoffeeFailure({
    super.entity = const RandomCoffeeEntity(
      imageUrl: '',
    ),
  });
}

final class RandomCoffeeInternetFailure extends RandomCoffeeState {
  const RandomCoffeeInternetFailure({
    super.entity = const RandomCoffeeEntity(
      imageUrl: '',
    ),
  });
}

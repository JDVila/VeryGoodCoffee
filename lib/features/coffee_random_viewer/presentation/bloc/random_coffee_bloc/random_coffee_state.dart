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

final class RandomCoffeeLoaded extends RandomCoffeeState {
  const RandomCoffeeLoaded({required super.entity});
}

final class RandomCoffeeError extends RandomCoffeeState {
  const RandomCoffeeError({
    super.entity = const RandomCoffeeEntity(
      imageUrl: '',
    ),
  });
}

final class RandomCoffeeNoInternet extends RandomCoffeeState {
  const RandomCoffeeNoInternet({
    super.entity = const RandomCoffeeEntity(
      imageUrl: '',
    ),
  });
}

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:verygoodcoffee/core/resources/data_state.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/entities/favorite_coffee_entity.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/entities/random_coffee_entity.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/check_favorite_coffee_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/get_random_coffee_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/bloc/favorite_coffee_button_cubit/favorite_coffee_button_cubit.dart';

part 'random_coffee_event.dart';
part 'random_coffee_state.dart';

class RandomCoffeeBloc extends Bloc<RandomCoffeeEvent, RandomCoffeeState> {
  RandomCoffeeBloc(
    this.getRandomCoffeeUseCase,
    this.checkFavoriteCoffeeUseCase,
    this.favoriteCoffeeButtonCubit,
  ) : super(
          const RandomCoffeeInitial(),
        ) {
    on<RandomCoffeeLoad>(_loadCoffeeImage);
  }
  final GetRandomCoffeeUseCase getRandomCoffeeUseCase;
  final CheckFavoriteCoffeeUseCase checkFavoriteCoffeeUseCase;
  final FavoriteCoffeeButtonCubit favoriteCoffeeButtonCubit;

  Future<void> _loadCoffeeImage(
    RandomCoffeeEvent event,
    Emitter<RandomCoffeeState> emit,
  ) async {
    {
      emit(
        const RandomCoffeeLoading(),
      );
      final baseEntity = await getRandomCoffeeUseCase.getRandomCoffee();
      final newEntity = RandomCoffeeEntity(
        imageUrl: baseEntity.data!.imageUrl,
        fileName: baseEntity.data!.fileName,
      );
      final buttonState = await checkFavoriteCoffeeUseCase.checkFavoriteCoffee(
        FavoriteCoffeeEntity(
          imageUrl: newEntity.imageUrl,
          fileName: newEntity.fileName,
        ),
      );
      if (buttonState is DataSuccess) {
        final newButtonState = buttonState.data ?? false;
        await favoriteCoffeeButtonCubit.clickButton(
          isPressed: newButtonState,
        );
      }
      emit(
        RandomCoffeeSuccess(entity: newEntity),
      );
    }
  }
}

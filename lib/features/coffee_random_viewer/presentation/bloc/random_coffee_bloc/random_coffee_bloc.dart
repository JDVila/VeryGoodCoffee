import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:verygoodcoffee/core/resources/data_state.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/entities/favorite_coffee_entity.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/entities/random_coffee_entity.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/check_favorite_coffee_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/get_random_coffee_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/bloc/favorite_coffee_button_cubit/favorite_coffee_button_cubit.dart';
import 'package:verygoodcoffee/injection_container.dart';

part 'random_coffee_event.dart';
part 'random_coffee_state.dart';

class RandomCoffeeBloc extends Bloc<RandomCoffeeEvent, RandomCoffeeState> {
  RandomCoffeeBloc()
      : super(
          const RandomCoffeeInitial(),
        ) {
    on<LoadRandomCoffee>(_loadCoffeeImage);
  }

  Future<void> _loadCoffeeImage(
    RandomCoffeeEvent event,
    Emitter<RandomCoffeeState> emit,
  ) async {
    {
      emit(
        const RandomCoffeeLoading(),
      );
      final baseEntity =
          await sl.get<GetRandomCoffeeUseCase>().getRandomCoffee();
      final newEntity = RandomCoffeeEntity(
        imageUrl: baseEntity.data!.imageUrl,
        fileName: baseEntity.data!.fileName,
      );
      final buttonState =
          await sl.get<CheckFavoriteCoffeeUseCase>().checkFavoriteCoffee(
                FavoriteCoffeeEntity(
                  imageUrl: newEntity.imageUrl,
                  fileName: newEntity.fileName,
                ),
              );
      if (buttonState is DataSuccess) {
        final newButtonState = buttonState.data ?? false;
        await sl.get<FavoriteCoffeeButtonCubit>().clickButton(
              isPressed: newButtonState,
            );
      }
      emit(
        RandomCoffeeLoaded(entity: newEntity),
      );
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verygoodcoffee/core/resources/data_state.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/entities/favorite_coffee_entity.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/add_favorite_coffee_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/check_favorite_coffee_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/remove_favorite_coffee_use_case.dart';
import 'package:verygoodcoffee/injection_container.dart';

part 'favorite_coffee_event.dart';
part 'favorite_coffee_state.dart';

class FavoriteCoffeeBloc
    extends Bloc<FavoriteCoffeeEvent, FavoriteCoffeeState> {
  FavoriteCoffeeBloc(this.checkFavoriteCoffeeUseCase,
      this.addFavoriteCoffeeUseCase, this.removeFavoriteCoffeeUseCase)
      : super(FavoriteCoffeeInitial()) {
    on<FavoriteCoffeeReset>(
      (
        event,
        emit,
      ) =>
          emit(FavoriteCoffeeInitial()),
    );
    on<ClickFavoriteCoffee>(_clickFavoriteCoffee);
  }
  final CheckFavoriteCoffeeUseCase checkFavoriteCoffeeUseCase;
  final AddFavoriteCoffeeUseCase addFavoriteCoffeeUseCase;
  final RemoveFavoriteCoffeeUseCase removeFavoriteCoffeeUseCase;

  Future<void> _clickFavoriteCoffee(
    FavoriteCoffeeEvent event,
    Emitter<FavoriteCoffeeState> emit,
  ) async {
    emit(
      FavoriteCoffeeStateLoading(),
    );
    final favoriteStatus = await checkFavoriteCoffeeUseCase.checkFavoriteCoffee(
      event.entity,
    );
    if (favoriteStatus is DataFailure) {
      emit(
        FavoriteCoffeeButtonLoadError(),
      );
    }
    final isAlreadyFavorite = favoriteStatus.data ?? false;
    if (!isAlreadyFavorite) {
      final crudStatus = await addFavoriteCoffeeUseCase.addFavoriteCoffee(
        event.entity,
      );
      if (crudStatus is DataSuccess) {
        emit(FavoriteCoffeeAdded());
      }
    } else {
      final crudStatus = await removeFavoriteCoffeeUseCase.removeFavoriteCoffee(
        event.entity,
      );
      if (crudStatus is DataSuccess) {
        emit(FavoriteCoffeeRemoved());
      }
    }
  }
}

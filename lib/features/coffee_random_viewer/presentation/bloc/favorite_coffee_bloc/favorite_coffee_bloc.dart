import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:verygoodcoffee/core/resources/data_state.dart';
import 'package:verygoodcoffee/features/coffee_favorites/presentation/bloc/coffee_favorites_bloc.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/entities/favorite_coffee_entity.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/add_favorite_coffee_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/check_favorite_coffee_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/remove_favorite_coffee_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/bloc/favorite_coffee_button_cubit/favorite_coffee_button_cubit.dart';
import 'package:verygoodcoffee/injection_container.dart';

part 'favorite_coffee_event.dart';
part 'favorite_coffee_state.dart';

class FavoriteCoffeeBloc
    extends Bloc<FavoriteCoffeeEvent, FavoriteCoffeeState> {
  FavoriteCoffeeBloc() : super(FavoriteCoffeeInitial()) {
    on<ClickFavoriteCoffee>(_clickFavoriteCoffee);
  }

  Future<void> _clickFavoriteCoffee(
    FavoriteCoffeeEvent event,
    Emitter<FavoriteCoffeeState> emit,
  ) async {
    emit(
      FavoriteCoffeeStateLoading(),
    );
    final favoriteStatus =
        await sl.get<CheckFavoriteCoffeeUseCase>().checkFavoriteCoffee(
              event.entity,
            );
    if (favoriteStatus is DataFailure) {
      emit(
        FavoriteCoffeeButtonLoadError(),
      );
    }
    final isAlreadyFavorite = favoriteStatus.data ?? false;
    if (!isAlreadyFavorite) {
      final crudStatus =
          await sl.get<AddFavoriteCoffeeUseCase>().addFavoriteCoffee(
                event.entity,
              );
      if (crudStatus is DataSuccess) {
        sl.get<FavoriteCoffeeButtonCubit>().clickButton(isPressed: true);
        emit(FavoriteCoffeeAdded());
      }
    } else {
      final crudStatus =
          await sl.get<RemoveFavoriteCoffeeUseCase>().removeFavoriteCoffee(
                event.entity,
              );
      if (crudStatus is DataSuccess) {
        sl.get<FavoriteCoffeeButtonCubit>().clickButton();
        emit(FavoriteCoffeeRemoved());
      }
    }
    sl.get<CoffeeFavoritesBloc>().add(
          LoadCoffeeFavoritesList(),
        );
    emit(
      FavoriteCoffeeButtonLoadError(),
    );
  }
}

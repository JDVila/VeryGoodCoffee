import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:verygoodcoffee/core/resources/data_state.dart';
import 'package:verygoodcoffee/features/coffee_favorites/domain/use_cases/get_all_favorite_coffees_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/entities/favorite_coffee_entity.dart';

part 'coffee_favorites_event.dart';
part 'coffee_favorites_state.dart';

class CoffeeFavoritesBloc
    extends Bloc<CoffeeFavoritesEvent, CoffeeFavoritesState> {
  CoffeeFavoritesBloc(this.getAllFavoriteCoffeesUseCase)
      : super(const CoffeeFavoritesInitial()) {
    on<LoadCoffeeFavoritesList>(_getCoffeeFavoritesList);
  }

  final GetAllFavoriteCoffeesUseCase getAllFavoriteCoffeesUseCase;

  Future<void> _getCoffeeFavoritesList(
    CoffeeFavoritesEvent event,
    Emitter<CoffeeFavoritesState> emit,
  ) async {
    emit(
      const CoffeeFavoritesListLoading(),
    );
    final list = await getAllFavoriteCoffeesUseCase.getAllFavoriteCoffees();
    if (list is DataSuccess) {
      emit(
        CoffeeFavoritesListLoaded(
          entityList: List.from(list.data!),
        ),
      );
    } else {
      emit(
        CoffeeFavoritesListError(errorMsg: list.errorMessage),
      );
    }
  }
}

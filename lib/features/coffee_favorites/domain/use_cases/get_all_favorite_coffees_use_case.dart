import 'package:verygoodcoffee/core/resources/data_state.dart';
import 'package:verygoodcoffee/features/coffee_favorites/domain/repositories/favorite_coffees_repository.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/entities/favorite_coffee_entity.dart';

class GetAllFavoriteCoffeesUseCase {
  const GetAllFavoriteCoffeesUseCase(this.repository);
  final FavoriteCoffeesRepository repository;

  Future<DataState<List<FavoriteCoffeeEntity>>> getAllFavoriteCoffees() async {
    final result = await repository.getFavoriteCoffees();

    if (result is DataSuccess) {
      final newList = result.data!
          .map(
            (e) => FavoriteCoffeeEntity(
              imageUrl: e.imageUrl,
              fileName: e.fileName,
              imageBytes: e.imageBytes,
            ),
          )
          .toList();
      return DataSuccess(data: newList);
    }
    return const DataFailure(errorMessage: 'Error retreiving favorites.');
  }
}

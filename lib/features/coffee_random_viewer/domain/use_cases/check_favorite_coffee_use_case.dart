import 'package:verygoodcoffee/core/resources/data_state.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/models/favorite_coffee_model.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/entities/favorite_coffee_entity.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/repositories/favorite_coffee_repository.dart';

class CheckFavoriteCoffeeUseCase {
  const CheckFavoriteCoffeeUseCase(this.repository);
  final FavoriteCoffeeRepository repository;

  Future<DataState<bool>> checkFavoriteCoffee(
    FavoriteCoffeeEntity entity,
  ) async {
    final result = await repository.checkFavoriteCoffee(
      FavoriteCoffeeModel(
        imageUrl: entity.imageUrl,
        fileName: entity.fileName,
      ),
    );

    if (result is DataSuccess) {
      if (result.data!.isEmpty) {
        return const DataSuccess(data: false);
      } else {
        return const DataSuccess(data: true);
      }
    }
    return const DataFailure(errorMessage: 'Error retreiving favorites.');
  }
}

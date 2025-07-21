import 'package:verygoodcoffee/core/resources/data_state.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/models/favorite_coffee_model.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/entities/favorite_coffee_entity.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/repositories/favorite_coffee_repository.dart';

class RemoveFavoriteCoffeeUseCase {
  const RemoveFavoriteCoffeeUseCase(this.repository);
  final FavoriteCoffeeRepository repository;

  Future<DataState<void>> removeFavoriteCoffee(
    FavoriteCoffeeEntity entity,
  ) async {
    final result = await repository.removeFavoriteCoffee(
      FavoriteCoffeeModel(
        imageUrl: entity.imageUrl,
        fileName: entity.fileName,
      ),
    );
    return result;
  }
}

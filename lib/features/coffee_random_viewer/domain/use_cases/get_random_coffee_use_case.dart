import 'package:verygoodcoffee/core/resources/data_state.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/models/random_coffee_model.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/entities/random_coffee_entity.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/repositories/random_coffee_repository.dart';

class GetRandomCoffeeUseCase {
  const GetRandomCoffeeUseCase(this.repository);

  final RandomCoffeeRepository repository;
  Future<DataState<RandomCoffeeEntity>> getRandomCoffee() async {
    final dataState = await repository.getRandomCoffee();
    switch (dataState.runtimeType) {
      case const (DataSuccess<RandomCoffeeModel>):
        return DataSuccess(
          data: RandomCoffeeEntity(
            imageUrl: (dataState.data!).file,
            fileName: Uri.parse((dataState.data!).file).path,
          ),
        );
      case const (DataFailure<RandomCoffeeModel>):
        return DataFailure(
          errorMessage: dataState.errorMessage,
        );
    }
    return const DataFailure(
      errorMessage: 'Unknown Error',
    );
  }
}

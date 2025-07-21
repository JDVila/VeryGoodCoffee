import 'package:verygoodcoffee/core/resources/data_state.dart';
import 'package:verygoodcoffee/core/resources/remote_state.dart';
import 'package:verygoodcoffee/core/resources/remote_state_mixin.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/models/random_coffee_model.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/repositories/random_coffee_repository.dart';

class RandomCoffeeRespositoryImpl extends RandomCoffeeRepository
    with RemoteStateMixin<RandomCoffeeModel> {
  RandomCoffeeRespositoryImpl({required super.service});

  @override
  Future<DataState<RandomCoffeeModel>> getRandomCoffee() async {
    final response = await service.getRandomCoffee();
    final remoteState = getRemoteState(
      response,
    );
    switch (remoteState.runtimeType) {
      case const (RemoteSuccess<RandomCoffeeModel>):
        return DataSuccess(
          data: remoteState.data as RandomCoffeeModel,
        );
      case const (RemoteFailRedirect):
      case const (RemoteFailClient):
      case const (RemoteFailServer):
      case const (RemoteFailUnknown):
        return DataFailure(
          errorMessage: remoteState.errorMessage,
        );
    }
    throw Exception();
  }
}

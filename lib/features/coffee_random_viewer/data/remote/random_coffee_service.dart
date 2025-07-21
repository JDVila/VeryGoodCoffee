import 'package:verygoodcoffee/core/resources/dio_wrapper.dart';
import 'package:verygoodcoffee/core/resources/remote_response.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/models/random_coffee_model.dart';

class RandomCoffeeService {
  const RandomCoffeeService(this.dioWrapper);
  final DioWrapper dioWrapper;

  static const String url = 'https://coffee.alexflipnote.dev/random.json';

  Future<RemoteResponse<RandomCoffeeModel>> getRandomCoffee() async {
    final response = await dioWrapper.get(url);
    return RemoteResponse(
      data: RandomCoffeeModel.fromMap(response[0] as Map<String, dynamic>),
      statusCode: response[1] as int,
    );
  }
}

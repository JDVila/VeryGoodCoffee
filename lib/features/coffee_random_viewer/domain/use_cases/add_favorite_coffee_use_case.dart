import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:verygoodcoffee/core/resources/data_state.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/models/favorite_coffee_model.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/entities/favorite_coffee_entity.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/repositories/favorite_coffee_repository.dart';

class AddFavoriteCoffeeUseCase {
  const AddFavoriteCoffeeUseCase(this.repository);
  final FavoriteCoffeeRepository repository;

  Future<DataState<void>> addFavoriteCoffee(
    FavoriteCoffeeEntity entity,
  ) async {
    final convertedImageToBytes = await _networkImageToBase64(entity.imageUrl);
    final result = await repository.addFavoriteCoffee(
      FavoriteCoffeeModel(
        imageUrl: entity.imageUrl,
        fileName: entity.fileName,
        imageBytes: convertedImageToBytes,
      ),
    );
    return result;
  }

  Future<String> _networkImageToBase64(String imageUrl) async {
    final response = await http.get(
      Uri.parse(imageUrl),
    );
    final bytes = response.bodyBytes;
    return base64Encode(bytes);
  }
}

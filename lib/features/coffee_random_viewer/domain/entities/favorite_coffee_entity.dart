import 'package:meta/meta.dart';

@immutable
class FavoriteCoffeeEntity {
  const FavoriteCoffeeEntity({
    required this.imageUrl,
    this.fileName,
    this.imageBytes,
  });

  final String imageUrl;
  final String? fileName;
  final String? imageBytes;
}

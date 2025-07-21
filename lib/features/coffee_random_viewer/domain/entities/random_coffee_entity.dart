import 'package:meta/meta.dart';

@immutable
class RandomCoffeeEntity {
  const RandomCoffeeEntity({
    required this.imageUrl,
    this.fileName,
    this.isFavorite,
  });

  final String imageUrl;
  final String? fileName;
  final bool? isFavorite;
}

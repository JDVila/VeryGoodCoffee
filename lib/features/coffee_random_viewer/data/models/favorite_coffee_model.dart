import 'package:floor/floor.dart';
import 'package:meta/meta.dart';

@immutable
@Entity(tableName: 'FavoriteCoffees', primaryKeys: ['imageUrl'])
class FavoriteCoffeeModel {
  const FavoriteCoffeeModel({
    required this.imageUrl,
    this.id,
    this.fileName,
    this.imageBytes,
  });

  final String imageUrl;
  final int? id;
  final String? fileName;
  final String? imageBytes;
}

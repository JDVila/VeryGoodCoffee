import 'package:floor/floor.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/models/favorite_coffee_model.dart';

@dao
abstract class FavoriteCoffeeDao {
  @insert
  Future<void> insertFavoriteCoffee(FavoriteCoffeeModel newFavorite);

  @delete
  Future<void> deleteFavoriteCoffee(FavoriteCoffeeModel formerFavorite);

  @Query('SELECT * FROM FavoriteCoffees')
  Future<List<FavoriteCoffeeModel>> getAllFavoriteCoffees();

  @Query('SELECT * FROM FavoriteCoffees WHERE imageUrl = :imageUrl')
  Future<List<FavoriteCoffeeModel>> checkFavoriteCoffee(String imageUrl);
}

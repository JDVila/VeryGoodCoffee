import 'package:verygoodcoffee/features/coffee_random_viewer/data/local/app_database.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/models/favorite_coffee_model.dart';

abstract class DatabaseDaoWrapper {
  const DatabaseDaoWrapper(this.database);
  final AppDatabase database;
  Future<void> insertFavoriteCoffee(FavoriteCoffeeModel newFavorite);
  Future<void> deleteFavoriteCoffee(FavoriteCoffeeModel formerFavorite);
  Future<List<FavoriteCoffeeModel>> checkFavoriteCoffee(
    FavoriteCoffeeModel checkCoffeeModel,
  );
  Future<List<FavoriteCoffeeModel>> getAllFavoriteCoffees();
}

class DatabaseDaoReal extends DatabaseDaoWrapper {
  DatabaseDaoReal(super.database);

  @override
  Future<void> insertFavoriteCoffee(FavoriteCoffeeModel newFavorite) async {
    return database.favoriteCoffeeDao.insertFavoriteCoffee(newFavorite);
  }

  @override
  Future<void> deleteFavoriteCoffee(FavoriteCoffeeModel formerFavorite) async {
    return database.favoriteCoffeeDao.deleteFavoriteCoffee(formerFavorite);
  }

  @override
  Future<List<FavoriteCoffeeModel>> checkFavoriteCoffee(
    FavoriteCoffeeModel checkCoffeeModel,
  ) {
    return database.favoriteCoffeeDao
        .checkFavoriteCoffee(checkCoffeeModel.imageUrl);
  }

  @override
  Future<List<FavoriteCoffeeModel>> getAllFavoriteCoffees() {
    return database.favoriteCoffeeDao.getAllFavoriteCoffees();
  }
}

class DatabaseDaoTest extends DatabaseDaoWrapper {
  DatabaseDaoTest(super.database);

  @override
  Future<void> insertFavoriteCoffee(FavoriteCoffeeModel newFavorite) async {}

  @override
  Future<void> deleteFavoriteCoffee(FavoriteCoffeeModel formerFavorite) async {}

  @override
  Future<List<FavoriteCoffeeModel>> checkFavoriteCoffee(
    FavoriteCoffeeModel checkCoffeeModel,
  ) async {
    return List<FavoriteCoffeeModel>.empty();
  }

  @override
  Future<List<FavoriteCoffeeModel>> getAllFavoriteCoffees() async {
    return [
      const FavoriteCoffeeModel(
        imageUrl: 'https://coffee.alexflipnote.dev/-ohqDCldco4_coffee.png',
        fileName: '-ohqDCldco4_coffee.png',
      ),
    ];
  }
}

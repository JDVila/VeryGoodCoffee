import 'package:verygoodcoffee/features/coffee_random_viewer/data/local/app_database.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/models/favorite_coffee_model.dart';

abstract class DatabaseDaoWrapper {
  const DatabaseDaoWrapper(this.database);
  final AppDatabase database;
  Future<void> insertFavoriteCoffee(FavoriteCoffeeModel newFavorite);
  Future<void> deleteFavoriteCoffee(FavoriteCoffeeModel newFavorite);
  Future<void> checkFavoriteCoffee(FavoriteCoffeeModel newFavorite);
}

// TODO: Finish Database Dao Wrapper for Macks / Fakes

class DatabaseDaoReal extends DatabaseDaoWrapper {
  DatabaseDaoReal(super.database);

  @override
  Future<void> checkFavoriteCoffee(FavoriteCoffeeModel newFavorite) async {
    // TODO: implement deleteFavoriteCoffee
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFavoriteCoffee(FavoriteCoffeeModel newFavorite) {
    // TODO: implement deleteFavoriteCoffee
    throw UnimplementedError();
  }

  @override
  Future<void> insertFavoriteCoffee(FavoriteCoffeeModel newFavorite) {
    // TODO: implement insertFavoriteCoffee
    throw UnimplementedError();
  }
}

class DatabaseDaoFake extends DatabaseDaoWrapper {
  DatabaseDaoFake(super.database);

  @override
  Future<void> checkFavoriteCoffee(FavoriteCoffeeModel newFavorite) {
    // TODO: implement checkFavoriteCoffee
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFavoriteCoffee(FavoriteCoffeeModel newFavorite) {
    // TODO: implement deleteFavoriteCoffee
    throw UnimplementedError();
  }

  @override
  Future<void> insertFavoriteCoffee(FavoriteCoffeeModel newFavorite) {
    // TODO: implement insertFavoriteCoffee
    throw UnimplementedError();
  }
}

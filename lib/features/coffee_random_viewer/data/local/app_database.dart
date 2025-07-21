import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:verygoodcoffee/features/coffee_random_viewer/data/local/dao/favorite_coffee_dao.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/models/favorite_coffee_model.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [FavoriteCoffeeModel])
abstract class AppDatabase extends FloorDatabase {
  FavoriteCoffeeDao get favoriteCoffeeDao;
}

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:verygoodcoffee/bootstrap.dart';
import 'package:verygoodcoffee/core/resources/database_dao_wrapper.dart';
import 'package:verygoodcoffee/core/resources/dio_wrapper.dart';
import 'package:verygoodcoffee/features/app/app.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/local/app_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final dio = Dio();
  unawaited(
    bootstrap(
      () => App(
        databaseDaoWrapper: DatabaseDaoReal(database),
        dioWrapper: DioReal(dio),
      ),
    ),
  );
}

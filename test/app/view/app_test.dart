import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:verygoodcoffee/core/resources/database_dao_wrapper.dart';
import 'package:verygoodcoffee/core/resources/dio_wrapper.dart';
import 'package:verygoodcoffee/features/app/app.dart';
import 'package:verygoodcoffee/features/app/presentation/cubit/app_page_navigation_cubit.dart';
import 'package:verygoodcoffee/features/coffee_favorites/data/repositories/favorite_coffees_repository_impl.dart';
import 'package:verygoodcoffee/features/coffee_favorites/domain/repositories/favorite_coffees_repository.dart';
import 'package:verygoodcoffee/features/coffee_favorites/domain/use_cases/get_all_favorite_coffees_use_case.dart';
import 'package:verygoodcoffee/features/coffee_favorites/presentation/bloc/coffee_favorites_bloc.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/local/app_database.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/remote/random_coffee_service.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/repositories/favorite_coffee_repository_impl.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/repositories/random_coffee_respository_impl.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/repositories/favorite_coffee_repository.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/repositories/random_coffee_repository.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/add_favorite_coffee_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/check_favorite_coffee_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/get_random_coffee_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/remove_favorite_coffee_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/bloc/favorite_coffee_bloc/favorite_coffee_bloc.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/bloc/favorite_coffee_button_cubit/favorite_coffee_button_cubit.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/bloc/random_coffee_bloc/random_coffee_bloc.dart';

void main() {
  final sl = GetIt.instance;
  Future<void> initializeDependencies() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    sl
      ..registerSingleton<AppDatabase>(
        database,
      )
      ..registerSingleton<DatabaseDaoWrapper>(
        DatabaseDaoTest(sl()),
      )
      ..registerSingleton<FavoriteCoffeeRepository>(
        FavoriteCoffeeRepositoryImpl(
          databaseDaoWrapper: sl(),
        ),
      )
      ..registerFactory<Dio>(
        Dio.new,
      )
      ..registerSingleton<DioWrapper>(
        DioTest(
          sl(),
        ),
      )
      ..registerSingleton<RandomCoffeeService>(
        RandomCoffeeService(
          sl(),
        ),
      )
      ..registerSingleton<RandomCoffeeRepository>(
        RandomCoffeeRespositoryImpl(
          service: sl(),
        ),
      )
      ..registerSingleton<GetRandomCoffeeUseCase>(
        GetRandomCoffeeUseCase(
          sl(),
        ),
      )
      ..registerSingleton<AddFavoriteCoffeeUseCase>(
        AddFavoriteCoffeeUseCase(
          sl(),
        ),
      )
      ..registerSingleton<RemoveFavoriteCoffeeUseCase>(
        RemoveFavoriteCoffeeUseCase(
          sl(),
        ),
      )
      ..registerSingleton<CheckFavoriteCoffeeUseCase>(
        CheckFavoriteCoffeeUseCase(
          sl(),
        ),
      )
      ..registerFactory<FavoriteCoffeeBloc>(
        FavoriteCoffeeBloc.new,
      )
      ..registerFactory<RandomCoffeeBloc>(
        RandomCoffeeBloc.new,
      )
      ..registerFactory<FavoriteCoffeeButtonCubit>(
        FavoriteCoffeeButtonCubit.new,
      )
      ..registerFactory<AppPageNavigationCubit>(
        AppPageNavigationCubit.new,
      )
      ..registerSingleton<FavoriteCoffeesRepository>(
        FavoriteCoffeesRepositoryImpl(
          database: sl(),
        ),
      )
      ..registerSingleton<GetAllFavoriteCoffeesUseCase>(
        GetAllFavoriteCoffeesUseCase(
          sl(),
        ),
      )
      ..registerFactory<CoffeeFavoritesBloc>(
        CoffeeFavoritesBloc.new,
      );
  }

  setUpAll(() async {
    await initializeDependencies();
  });
  group('App', () {
    testWidgets('renders App', (tester) async {
      await mockNetworkImages(
        () => tester.pumpWidget(
          const App(),
        ),
      );
      expect(find.byIcon(Icons.coffee), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('checks Coffee Viewer Navigation Button', (tester) async {
      await mockNetworkImages(
        () => tester.pumpWidget(
          const App(),
        ),
      );
      final randomNavButton = find.text('Random Coffee');
      await tester.tap(randomNavButton);
      await tester.pump(); // initial build
      await tester.pump(Duration.zero); // let microtasks resolve
      await tester.pump(const Duration(seconds: 1)); // allow animation
      expect(find.text('Coffee Viewer'), findsOneWidget);
    });

    testWidgets('checks Coffee Favorites Navigation Button', (tester) async {
      await mockNetworkImages(
        () => tester.pumpWidget(
          const App(),
        ),
      );
      final favoriteNavButton = find.text('Favorite Coffees');
      await tester.tap(favoriteNavButton);
      await tester.pump(); // initial build
      await tester.pump(Duration.zero); // let microtasks resolve
      await tester.pump(const Duration(seconds: 10)); // allow animation
      expect(find.text('Coffee Favorites'), findsOneWidget);
    });
  });
}

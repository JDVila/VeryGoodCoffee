import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:verygoodcoffee/core/resources/database_dao_wrapper.dart';
import 'package:verygoodcoffee/core/resources/dio_wrapper.dart';
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

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  sl
    ..registerSingleton<AppDatabase>(
      database,
    )
    ..registerSingleton<DatabaseDaoWrapper>(
      DatabaseDaoReal(sl()),
    )
    ..registerSingleton<FavoriteCoffeeRepository>(
      FavoriteCoffeeRepositoryImpl(
        databaseDaoWrapper: sl(),
      ),
    )
    ..registerSingleton<Dio>(
      Dio(),
    )
    ..registerSingleton<DioWrapper>(
      DioReal(
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
    ..registerSingleton<RandomCoffeeBloc>(
      RandomCoffeeBloc(),
    )
    ..registerSingleton<FavoriteCoffeeBloc>(
      FavoriteCoffeeBloc(),
    )
    ..registerSingleton<FavoriteCoffeeButtonCubit>(
      FavoriteCoffeeButtonCubit(),
    )
    ..registerSingleton<AppPageNavigationCubit>(
      AppPageNavigationCubit(),
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
    ..registerSingleton<CoffeeFavoritesBloc>(
      CoffeeFavoritesBloc(),
    );
}

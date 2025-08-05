import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lock_orientation_screen/lock_orientation_screen.dart';
import 'package:verygoodcoffee/core/resources/database_dao_wrapper.dart';
import 'package:verygoodcoffee/core/resources/dio_wrapper.dart';
import 'package:verygoodcoffee/features/app/presentation/cubit/app_page_navigation_cubit.dart';
import 'package:verygoodcoffee/features/coffee_favorites/data/repositories/favorite_coffees_repository_impl.dart';
import 'package:verygoodcoffee/features/coffee_favorites/domain/use_cases/get_all_favorite_coffees_use_case.dart';
import 'package:verygoodcoffee/features/coffee_favorites/presentation/bloc/coffee_favorites_bloc.dart';
import 'package:verygoodcoffee/features/coffee_favorites/presentation/pages/favorite_coffees_page.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/remote/random_coffee_service.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/repositories/favorite_coffee_repository_impl.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/repositories/random_coffee_respository_impl.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/add_favorite_coffee_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/check_favorite_coffee_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/get_random_coffee_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/use_cases/remove_favorite_coffee_use_case.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/bloc/favorite_coffee_bloc/favorite_coffee_bloc.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/bloc/favorite_coffee_button_cubit/favorite_coffee_button_cubit.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/bloc/random_coffee_bloc/random_coffee_bloc.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/pages/random_coffee_page.dart';
import 'package:verygoodcoffee/l10n/arb/app_localizations.dart';

class App extends StatefulWidget {
  const App({
    required this.databaseDaoWrapper,
    required this.dioWrapper,
    super.key,
  });
  final DatabaseDaoWrapper databaseDaoWrapper;
  final DioWrapper dioWrapper;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return LockOrientation(
      child: RepositoryProvider(
        create: (context) => RandomCoffeeService(
          widget.dioWrapper,
        ),
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => RandomCoffeeRespositoryImpl(
                service: RepositoryProvider.of<RandomCoffeeService>(context),
              ),
            ),
            RepositoryProvider(
              create: (context) => FavoriteCoffeeRepositoryImpl(
                databaseDaoWrapper: widget.databaseDaoWrapper,
              ),
            ),
            RepositoryProvider(
              create: (context) => FavoriteCoffeesRepositoryImpl(
                databaseDaoWrapper: widget.databaseDaoWrapper,
              ),
            ),
          ],
          child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider(
                create: (context) => GetRandomCoffeeUseCase(
                  RepositoryProvider.of<RandomCoffeeRespositoryImpl>(context),
                ),
              ),
              RepositoryProvider(
                create: (context) => CheckFavoriteCoffeeUseCase(
                  RepositoryProvider.of<FavoriteCoffeeRepositoryImpl>(context),
                ),
              ),
              RepositoryProvider(
                create: (context) => AddFavoriteCoffeeUseCase(
                  RepositoryProvider.of<FavoriteCoffeeRepositoryImpl>(context),
                ),
              ),
              RepositoryProvider(
                create: (context) => RemoveFavoriteCoffeeUseCase(
                  RepositoryProvider.of<FavoriteCoffeeRepositoryImpl>(
                    context,
                  ),
                ),
              ),
              RepositoryProvider(
                create: (context) => GetAllFavoriteCoffeesUseCase(
                  RepositoryProvider.of<FavoriteCoffeesRepositoryImpl>(
                    context,
                  ),
                ),
              ),
            ],
            child: BlocProvider(
              create: (context) => FavoriteCoffeeButtonCubit(),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => AppPageNavigationCubit(),
                  ),
                  BlocProvider<RandomCoffeeBloc>(
                    create: (context) => RandomCoffeeBloc(
                      RepositoryProvider.of<GetRandomCoffeeUseCase>(context),
                      RepositoryProvider.of<CheckFavoriteCoffeeUseCase>(
                        context,
                      ),
                      RepositoryProvider.of<FavoriteCoffeeButtonCubit>(context),
                    ),
                  ),
                  BlocProvider<FavoriteCoffeeBloc>(
                    create: (context) => FavoriteCoffeeBloc(
                      RepositoryProvider.of<CheckFavoriteCoffeeUseCase>(
                        context,
                      ),
                      RepositoryProvider.of<AddFavoriteCoffeeUseCase>(context),
                      RepositoryProvider.of<RemoveFavoriteCoffeeUseCase>(
                        context,
                      ),
                    ),
                  ),
                  BlocProvider<CoffeeFavoritesBloc>(
                    create: (context) => CoffeeFavoritesBloc(
                      RepositoryProvider.of<GetAllFavoriteCoffeesUseCase>(
                        context,
                      ),
                    ),
                  ),
                ],
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    appBarTheme: AppBarTheme(
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                    ),
                    useMaterial3: true,
                  ),
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  home: BlocBuilder<AppPageNavigationCubit, int>(
                    builder: (cubitContext, state) {
                      return Scaffold(
                        bottomNavigationBar: Card(
                          color: Colors.white,
                          clipBehavior: Clip.hardEdge,
                          child: BottomNavigationBar(
                            currentIndex: state,
                            onTap: (index) {
                              cubitContext
                                  .read<AppPageNavigationCubit>()
                                  .setPage(
                                    index,
                                  );
                            },
                            backgroundColor: Colors.white,
                            items: const <BottomNavigationBarItem>[
                              BottomNavigationBarItem(
                                icon: Icon(Icons.coffee),
                                label: 'Random Coffee',
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.favorite),
                                label: 'Favorite Coffees',
                              ),
                            ],
                          ),
                        ),
                        body: _pages[state],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> _pages = <Widget>[
  const RandomCoffeePage(),
  const FavoriteCoffeesPage(),
];

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lock_orientation_screen/lock_orientation_screen.dart';
import 'package:verygoodcoffee/features/app/presentation/cubit/app_page_navigation_cubit.dart';
import 'package:verygoodcoffee/features/coffee_favorites/presentation/pages/favorite_coffees_page.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/pages/random_coffee_page.dart';
import 'package:verygoodcoffee/injection_container.dart';
import 'package:verygoodcoffee/l10n/arb/app_localizations.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return LockOrientation(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppPageNavigationCubit>(
            create: (_) => sl.get<AppPageNavigationCubit>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            useMaterial3: true,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
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
                      cubitContext.read<AppPageNavigationCubit>().setPage(
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
                body: IndexedStack(
                  index: state,
                  children: _pages,
                ),
              );
            },
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

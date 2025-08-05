import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verygoodcoffee/features/coffee_favorites/presentation/bloc/coffee_favorites_bloc.dart';
import 'package:verygoodcoffee/features/coffee_favorites/presentation/widgets/favorite_coffee_card.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/widgets/random_coffee_error_widget.dart';
import 'package:verygoodcoffee/l10n/arb/app_localizations.dart';

class FavoriteCoffeesPage extends StatelessWidget {
  const FavoriteCoffeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FavoriteCoffeesView();
  }
}

class FavoriteCoffeesView extends StatefulWidget {
  const FavoriteCoffeesView({super.key});

  @override
  State<FavoriteCoffeesView> createState() => _FavoriteCoffeesViewState();
}

class _FavoriteCoffeesViewState extends State<FavoriteCoffeesView> {
  @override
  void initState() {
    context.read<CoffeeFavoritesBloc>().add(
          FavoritesListLoad(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        color: Colors.white,
        child: BlocBuilder<CoffeeFavoritesBloc, CoffeeFavoritesState>(
          builder: (context, state) {
            return switch (state) {
              CoffeeFavoritesInitial() => Container(),
              CoffeeFavoritesListLoading() => const CircularProgressIndicator(),
              CoffeeFavoritesListSuccess() => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      color: Colors.deepPurple,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            AppLocalizations.of(context).coffeeFavorites,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          context.read<CoffeeFavoritesBloc>().add(
                                FavoritesListLoad(),
                              );
                        },
                        child: ListView.builder(
                          itemCount: state.entityList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              clipBehavior: Clip.hardEdge,
                              child: FavoriteCoffeeCard(
                                imageBytes: state.entityList[index].imageBytes,
                                fileName: state.entityList[index].fileName,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              CoffeeFavoritesListFailure() => RandomCoffeeErrorWidget(
                  isInternetError: false,
                  onPressed: () {
                    context.read<CoffeeFavoritesBloc>().add(
                          FavoritesListLoad(),
                        );
                  },
                ),
            };
          },
        ),
      ),
    );
  }
}

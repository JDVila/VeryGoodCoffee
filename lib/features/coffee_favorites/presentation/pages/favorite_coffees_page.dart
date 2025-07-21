import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verygoodcoffee/features/coffee_favorites/presentation/bloc/coffee_favorites_bloc.dart';
import 'package:verygoodcoffee/features/coffee_favorites/presentation/widgets/favorite_coffee_card.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/widgets/random_coffee_error_widget.dart';

class FavoriteCoffeesPage extends StatelessWidget {
  const FavoriteCoffeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoffeeFavoritesBloc(),
      child: const FavoriteCoffeesView(),
    );
  }
}

class FavoriteCoffeesView extends StatefulWidget {
  const FavoriteCoffeesView({super.key});

  @override
  State<FavoriteCoffeesView> createState() => _FavoriteCoffeesViewState();
}

class _FavoriteCoffeesViewState extends State<FavoriteCoffeesView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<CoffeeFavoritesBloc>().add(
          LoadCoffeeFavoritesList(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Card(
        color: Colors.white,
        child: BlocBuilder<CoffeeFavoritesBloc, CoffeeFavoritesState>(
          builder: (context, state) {
            return switch (state) {
              CoffeeFavoritesInitial() => Container(),
              CoffeeFavoritesListLoading() => const CircularProgressIndicator(),
              CoffeeFavoritesListLoaded() => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Card(
                      color: Colors.deepPurple,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Coffee Favorites',
                            style: TextStyle(
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
                                LoadCoffeeFavoritesList(),
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
              CoffeeFavoritesListError() => RandomCoffeeErrorWidget(
                  isInternetError: false,
                  onPressed: () {
                    context.read<CoffeeFavoritesBloc>().add(
                          LoadCoffeeFavoritesList(),
                        );
                  },
                ),
            };
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}

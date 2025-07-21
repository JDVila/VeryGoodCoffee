import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/entities/favorite_coffee_entity.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/bloc/favorite_coffee_bloc/favorite_coffee_bloc.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/bloc/favorite_coffee_button_cubit/favorite_coffee_button_cubit.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/bloc/random_coffee_bloc/random_coffee_bloc.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/widgets/random_coffee_card_widget.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/presentation/widgets/random_coffee_error_widget.dart';
import 'package:verygoodcoffee/injection_container.dart';

class RandomCoffeePage extends StatelessWidget {
  const RandomCoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl.get<RandomCoffeeBloc>(),
        ),
        BlocProvider(
          create: (_) => sl.get<FavoriteCoffeeBloc>(),
        ),
        BlocProvider(
          create: (_) => sl.get<FavoriteCoffeeButtonCubit>(),
        ),
      ],
      child: const RandomCoffeeView(),
    );
  }
}

class RandomCoffeeView extends StatefulWidget {
  const RandomCoffeeView({super.key});

  @override
  State<RandomCoffeeView> createState() => _RandomCoffeeViewState();
}

class _RandomCoffeeViewState extends State<RandomCoffeeView> {
  @override
  void initState() {
    super.initState();
    context.read<RandomCoffeeBloc>().add(
          LoadRandomCoffee(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<RandomCoffeeBloc, RandomCoffeeState>(
        builder: (context, state) {
          return Card(
            color: Colors.white,
            child: Column(
              children: [
                const Card(
                  color: Colors.deepPurple,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Coffee Viewer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                switch (state.runtimeType) {
                  RandomCoffeeInitial => const CircularProgressIndicator(),
                  RandomCoffeeNoInternet => RandomCoffeeErrorWidget(
                      isInternetError: true,
                      onPressed: () async {
                        context.read<RandomCoffeeBloc>().add(
                              LoadRandomCoffee(),
                            );
                      },
                    ),
                  RandomCoffeeError => RandomCoffeeErrorWidget(
                      isInternetError: false,
                      onPressed: () async {
                        context.read<RandomCoffeeBloc>().add(
                              LoadRandomCoffee(),
                            );
                      },
                    ),
                  _ => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          ),
                          child: Card(
                            margin: EdgeInsets.zero,
                            clipBehavior: Clip.hardEdge,
                            child: switch (state.runtimeType) {
                              RandomCoffeeLoading => RandomCoffeeCard(
                                  isPressed: context
                                      .watch<FavoriteCoffeeButtonCubit>()
                                      .state,
                                  onPressed: () {},
                                ),
                              RandomCoffeeLoaded => RandomCoffeeCard(
                                  isPressed: context
                                      .watch<FavoriteCoffeeButtonCubit>()
                                      .state,
                                  imageUrl: state.entity.imageUrl,
                                  fileName: state.entity.fileName,
                                  onPressed: () {
                                    context.read<FavoriteCoffeeBloc>().add(
                                          ClickFavoriteCoffee(
                                            entity: FavoriteCoffeeEntity(
                                              imageUrl: state.entity.imageUrl,
                                              fileName: state.entity.fileName,
                                            ),
                                          ),
                                        );
                                  },
                                ),
                              _ => const SizedBox.shrink(),
                            },
                          ),
                        ),
                        MaterialButton(
                          color: Colors.orangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text('Get New Coffee Image'),
                          onPressed: () {
                            context.read<RandomCoffeeBloc>().add(
                                  LoadRandomCoffee(),
                                );
                          },
                        ),
                      ],
                    ),
                },
              ],
            ),
          );
        },
      ),
    );
  }
}

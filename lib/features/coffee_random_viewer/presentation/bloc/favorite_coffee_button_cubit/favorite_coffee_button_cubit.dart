import 'package:bloc/bloc.dart';

class FavoriteCoffeeButtonCubit extends Cubit<bool> {
  FavoriteCoffeeButtonCubit() : super(false);
  Future<void> clickButton({bool isPressed = false}) async {
    emit(isPressed);
  }
}

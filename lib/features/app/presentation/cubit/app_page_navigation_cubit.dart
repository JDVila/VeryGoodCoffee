import 'package:bloc/bloc.dart';

class AppPageNavigationCubit extends Cubit<int> {
  AppPageNavigationCubit() : super(0);

  void setPage(int pageIndex) {
    emit(pageIndex);
  }
}

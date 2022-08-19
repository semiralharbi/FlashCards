import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'custom_drawer_state.dart';

@injectable
class CustomDrawerCubit extends Cubit<CustomDrawerState> {
  CustomDrawerCubit() : super(const CustomDrawerState.initial());

  void logout() async {
    await FirebaseAuth.instance.signOut();
    emit(const CustomDrawerState.logout());
  }

}

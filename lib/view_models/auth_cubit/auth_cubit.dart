import 'package:e_commerce_app/models/user_data.dart';
import 'package:e_commerce_app/services/auth_services.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/utilities/api_paths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthServices authServices = AuthServicesImpl();
  final firestoreServices = FirestoreServices.instance;

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await authServices.loginWithEmailAndPassword(
        email,
        password,
      );
      if (result) {
        emit(AuthDone());
      } else {
        emit(AuthError('Failed login!'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
    String username,
  ) async {
    emit(AuthLoading());
    try {
      final result = await authServices.registerWithEmailAndPassword(
        email,
        password,
      );
      if (result) {
       await _saveUserData(username, email);
        emit(AuthDone());
      } else {
        emit(AuthError('Failed Register!'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _saveUserData(String username, String email) async {
    final currentUser = authServices.user();
    final userDate = UserData(
      userId: currentUser!.uid,
      username: username,
      email: email,
      createAt: DateTime.now().toIso8601String(),
    );
    await firestoreServices.setDate(
      path: ApiPaths.users(userDate.userId),
      data: userDate.toMap(),
    );
  }

  void checkAuth() {
    final user = authServices.user();
    if (user != null) {
      emit(const AuthDone());
    }
  }

  Future<void> logout() async {
    emit(Loggingout());
    try {
      await authServices.logout();
      emit(Loggedout());
    } catch (e) {
      emit(LogoutFailure(e.toString()));
    }
  }

  Future<void> authenticationWithGoogle() async {
    emit(GoogleSigning());
    try {
      final result = await authServices.loginWithGoogle();
      if (result) {
        emit(GoogleSigned());
      } else {
        emit(GoogleSignFailure("Google Login Failed"));
      }
    } catch (e) {
      emit(GoogleSignFailure(e.toString()));
    }
  }
}

import '../models/user_model.dart';

class AuthService {
  Future<bool> login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));

    return true;
  }

  Future<bool> register(UserModel user, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    return true;
  }
}

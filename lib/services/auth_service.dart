import 'package:sample/common/service/api_client.dart';

class AuthService extends ApiClient {
  // Private constructor
  AuthService._privateConstructor();

  // Singleton instance
  static final AuthService _instance = AuthService._privateConstructor();

  // Factory constructor to return the same instance
  factory AuthService() {
    return _instance;
  }

  Future<T> signIn<T>({required String email, required String password }) async {
    return postRequest<T>('signin', {'email': email, 'password': password});
  }

  Future<T> signUp<T>({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    return postRequest<T>('signup', {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    });
  }
}

import 'package:exercise_demo/models/user.dart';

import 'api_service.dart';

extension UserService on APIService {
  Future<User> login({
    required String phone,
    required String password,
  }) async {
    final body = {
      "phoneNumber": phone,
      "password": password,
    };
    final result = await request(
      path: '/api/accounts/login',
      body: body,
      method: Method.post,
    );
    final user = User.fromJson(result);
    return user;
  }

  Future<User> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final body = {
      "Name": name,
      "Email": email,
      "PhoneNumber": phone,
      "Password": password,
    };
    final result = await request(
      path: '/api/accounts/register',
      body: body,
      method: Method.post,
    );
    final user = User.fromJson(result);
    return user;
  }

  Future<User> setProfile({
    required String name,
    required String email,
    required String address,
    required String dateOfBirth,
    required String avatar,
  }) async {
    final body = {
      "Name": name,
      "Email": email,
      "Address": address,
      "DateOfBirth": dateOfBirth,
      "Avatar": avatar,
    };
    final result = await request(
      path: '/api/accounts/update',
      body: body,
      method: Method.post,
    );
    final user = User.fromJson(result);
    return user;
  }

  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final body = {
      "OldPassword": oldPassword,
      "NewPassword": newPassword,
    };
    await request(
      path: '/api/accounts/changePassword',
      body: body,
      method: Method.post,
    );
    return true;
  }
}

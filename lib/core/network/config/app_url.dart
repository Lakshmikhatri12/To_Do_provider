import 'package:to_do_app/core/env/env.dart';

class AppUrl {
  static String get baseUrl => Env.baseUrl;
  // Auth
  static String get loginEndPoint => '${Env.baseUrl}auth/login';
  static String get signupEndPoint => '${Env.baseUrl}users/add';

  // Todos
  static String get todosEndPoint => '${Env.taskBaseUrl}todos';
  static String todoById(int id) => '${todosEndPoint}/$id';
}

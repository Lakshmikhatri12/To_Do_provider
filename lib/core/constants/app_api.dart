class AppUrl {
  static const baseUrl = "https://dummyjson.com/";
  static const loginEndPoint = baseUrl + "auth/login";
  static const signupEndPoint = baseUrl + "users/add";

  static const taskBaseUrl = "https://jsonplaceholder.typicode.com/";
  static const todosEndPoint = taskBaseUrl + "todos";

  // Builds the URL for a single todo: /todos/5
  // Used by PUT and DELETE
  static String todoById(int id) => "$todosEndPoint/$id";
}

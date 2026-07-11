import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:w09/1%20-%20START%20CODE/2%20-%20TODO%20LIST/data/dto/todo_dto.dart';
import 'package:w09/1%20-%20START%20CODE/2%20-%20TODO%20LIST/data/repository/repository_exception.dart';

import '../../models/todo.dart';

class TodoRepository {
  static final global = TodoRepository(); // unique instance

  final List<Todo> fakeTodos = [
    Todo(id: '1', title: 'Buy groceries', completed: false),
    Todo(id: '2', title: 'Finish Flutter homework', completed: true),
    Todo(id: '3', title: 'Call the dentist', completed: false),
    Todo(id: '4', title: 'Read 20 pages of a book', completed: true),
    Todo(id: '5', title: 'Go for a 30-minute walk', completed: false),
  ];

  Future<List<Todo>> getTodos() async {
    //  TODO
    //  Adapt the code to handle firebase data fetch
    //

    Uri url = Uri.parse(
      "https://fluttert1-df862-default-rtdb.asia-southeast1.firebasedatabase.app/todos.json",
    );

    Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("No Wifi");
    }

    Map<String, dynamic> json = jsonDecode(response.body);

    List<Todo> todo = json.entries.map<Todo>((entry) {
      return TodoDto.fromJson(entry.key, entry.value);
    }).toList();

    // final List<Todo> todos = data.entries.map((entry) {
    //   final id = entry.key;
    //   final json = entry.value as Map<String, dynamic>;
    //   return TodoDto.fromJson(id, json);
    // }).toList();

    return todo;
  }

  Future<void> updateCompleted(String todoId, bool completed) async {
    //  TODO
    Uri url = Uri.parse(
      "https://fluttert1-df862-default-rtdb.asia-southeast1.firebasedatabase.app/todos/$todoId.json",
    );
    Response re = await http.patch(
      url,
      body: jsonEncode({'completed': completed}),
    );

    if (re.statusCode != 200) {
      throw RepositoryException("Failed to update");
    }
    //  Adapt the code to handle firebase data fetch
    //
  }
}

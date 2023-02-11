import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/users.dart';

class UsersRepo {
  String _url = 'https://reqres.in/api/users/';

  usersList() async {
    try {
      var response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        Iterable result = (json.decode(response.body))['data'];
        List<Users> users =
            result.map((value) => Users.fromJson(value)).toList();

        return users;
      }
    } catch (error) {
      print(error.toString());
    }
  }

  usersDetails({required String id}) async {
    try {
      var response = await http.get(Uri.parse(_url + '$id'));

      if (response.statusCode == 200) {
        var result = (json.decode(response.body));
        var data = result['data'];
        var support = result['support'];

        Users users = Users(
          id: data['id'],
          email: data['email'],
          firstName: data['first_name'],
          lastName: data['last_name'],
          avatar: data['avatar'],
          support: support['text'],
        );

        return users;
      }
    } catch (error) {
      print(error.toString());
    }
  }

  usersCreate({required String name, required String job}) async {
    try {
      var response = await http.post(Uri.parse(_url),
          body: {"name": name, "job": job});

      if (response.statusCode == 201) {
        var result = json.decode(response.body);

        Users users = Users(
          id: int.parse(result['id']),
          name: result['name'],
          job: result['job'],
          createdAt: result['createdAt'],
        );

        return users;
      }
    } catch (error) {
      print(error.toString());
    }
  }
}

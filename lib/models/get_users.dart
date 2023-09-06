import 'package:dio/dio.dart';
import 'users.dart';

Future<List<Welcome>?> getProvider() async {
  try {
    var url = 'https://jsonplaceholder.typicode.com/users';
    var res = await Dio().get(url);
    if (res.statusCode == 200) {
      var body = res.data as List;
      return body.map((e) => Welcome.fromJson(e)).toList();
    }

    print(res.statusCode);
  } catch (q) {
    print('Error: $q');
  }
  return [];
}

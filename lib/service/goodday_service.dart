import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myflutterapp/constants/goodday_values.dart';

class GoodDayService {
  Future<String> createTask(Map data) async {
    Map<String, String> headers = {
      'Content-type': GoodDayValues.jsonType,
      'Accept': GoodDayValues.token,
      'gd-api-token': GoodDayValues.token
    };

    final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/albums'),
        headers: headers,
        body: jsonEncode(data));

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return jsonDecode(response
          .body); //jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create task.');
    }
  }

  // createTask(Map<String,String> data) async {
  //
  //   Map<String,String> headers = {
  //     'Content-type' : GoodDayValues().token,
  //     'Accept': GoodDayValues().token,
  //     'gd-api-token': GoodDayValues().token
  //   };
  //
  //   final String jsonData = json.encode(data);
  //   http.Client().post(Uri.parse(GoodDayValues().url),
  //       body: jsonData, headers: headers);
  //
  //   if (kDebugMode) {
  //     print(data);
  //   }
  // }
}

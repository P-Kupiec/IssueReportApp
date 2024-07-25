import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_status/http_status.dart';
import 'package:myflutterapp/constants/goodday_values.dart';
import 'package:myflutterapp/constants/ui_values.dart';
import 'package:myflutterapp/service/data_classes/goodday_data.dart';

class GoodDayService {
  Map<String, String> headers = {
    'Content-type': GoodDayValues.jsonType,
    'gd-api-token': GoodDayValues.token
  };

  Future<bool> createTask(Map formData) async {
    final body = TaskData(formData);

    final response = await http.post(
        Uri.parse("${GoodDayValues.url}/tasks"),
        headers: headers,
        body: jsonEncode(body));

    if (!response.statusCode.isSuccessfulHttpStatusCode) {
      throw Exception('Failed to create task');
    }

    updateCustomFields(TaskResponse(jsonDecode(response.body)), formData);

    return true;
  }

  Future<bool> updateCustomFields(TaskResponse taskResponse, Map formData) async {
    final body = CustomFieldsRequest([
      CustomField("l8dmpO", formData[UiValues.projectNrField]?.value),
      CustomField("MBYlLP", formData[UiValues.productIdField]?.value),
      CustomField("5Mk38y", formData[UiValues.employeeNameField]?.value)
    ]);

    final response = await http.put(
        Uri.parse("${GoodDayValues.url}/task/${taskResponse.id}/custom-fields"),
        headers: headers,
        body: jsonEncode(body));

    if (!response.statusCode.isSuccessfulHttpStatusCode) {
      throw Exception('Failed to update task');
    }

    return true;
  }
}

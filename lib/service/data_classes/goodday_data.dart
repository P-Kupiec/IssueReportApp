import 'package:myflutterapp/constants/ui_values.dart';

class TaskData {
  String? projectId;
  String? title;
  String? fromUserId;
  late String message;

  TaskData(Map data, List linkList) {
    projectId = "SnVrYd";
    title = data[UiValues.summaryField]?.value;
    fromUserId = ""; //Marcel Wuwer: SPvGQx
    message = data[UiValues.descriptionField]?.value ?? "";

    message += '\nZdjęcia:\n';

    for (final link in linkList) {
      message += '$link\n';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'title': title,
      'fromUserId': fromUserId,
      'message': message,
    };
  }
}

class TaskResponse {
  late String id;
  late String shortId;

  TaskResponse(Map response) {
    id = response['id'];
    shortId = response['shortId'];
  }
}

class CustomFieldsRequest {
  late List<CustomField> customFields;

  CustomFieldsRequest(this.customFields);

  Map<String, dynamic> toJson() {
    return {
      'customFields': customFields
    };
  }
}

class CustomField {
  late String id;
  late String value;

  CustomField(this.id, this.value);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value
    };
  }
}

class CustomFieldsResponse {
  late String success;
  late String message;

  CustomFieldsResponse(this.success, this.message);
}
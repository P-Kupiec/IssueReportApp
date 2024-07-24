import 'package:myflutterapp/constants/ui_values.dart';

class TaskData {
  String? projectId;
  String? title;
  String? fromUserId;
  String? message;

  TaskData(Map data) {
    projectId = "SnVrYd";
    title = data[UiValues.summaryField]?.value;
    fromUserId = "USER1-ID";
    message = data[UiValues.descriptionField]?.value;
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

class CustomFieldsData {
  late List<CustomField> customFields;

  CustomFieldsData(this.customFields);
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
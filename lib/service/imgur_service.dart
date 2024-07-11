import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:myflutterapp/constants/imgur_values.dart';

class ImgurService {
  Future uploadImage(File image) async {
    var request = http.MultipartRequest(ImgurValues.post, Uri.parse(ImgurValues.postUrl));
    request.headers["Authorization"] = ImgurValues.clientID;
    var file = await http.MultipartFile.fromPath(
      "image",
      image.path,
    );
    request.files.add(file);
    var streamedResponse  = await request.send();
    var response = await http.Response.fromStream(streamedResponse )
        .then((value) => jsonDecode(value.body));
    if (response.statusCode != 200 ) {
      return null;
    }
    return jsonDecode(response.body);
    // var data = response["data"];
    // if (kDebugMode) {
    //   print(data);
    // }
  }
}

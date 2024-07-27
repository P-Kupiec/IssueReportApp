import 'dart:convert';
import 'dart:io';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:http_status/http_status.dart';
import 'package:myflutterapp/constants/imgur_values.dart';


class ImgurService {

  Future<List<String>> uploadImages(List<File> images) async {

    List<String> linksList = [];

    if (images.isNotEmpty) {
      for (final image in images) {
        var request =
        http.MultipartRequest(ImgurValues.post, Uri.parse(ImgurValues.postUrl));
        request.headers["Authorization"] = ImgurValues.clientID;

        var file = await http.MultipartFile.fromPath(
          "image",
          image.path,
        );

        request.files.add(file);
        var response = await request.send();

        if (!response.statusCode.isSuccessfulHttpStatusCode) {
          dev.log("ERROR: Received Response Code: ${response.statusCode}");
          throw Exception('Failed to upload images. Response Code: ${response.statusCode}');
        }

        var result = await http.Response.fromStream(response)
            .then((value) => jsonDecode(value.body));

        var data = result["data"];
        linksList.add(data["link"]);
      }
    }

    return linksList;
  }
}

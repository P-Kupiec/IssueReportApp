import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:myflutterapp/constants/imgur_values.dart';


class ImgurService {

  uploadImages(List<File> images) async {

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
        var result = await http.Response.fromStream(response)
            .then((value) => jsonDecode(value.body));

        var data = result["data"];
        linksList.add(data["link"]);
      }
    }  else {
      return;
    }

    print(linksList);
    return linksList;
  }

  // Future uploadImage(File image) async {
    // var request = http.MultipartRequest(ImgurValues.post, Uri.parse(ImgurValues.postUrl));
    // request.headers["Authorization"] = ImgurValues.clientID;
    // var file = await http.MultipartFile.fromPath(
    //   "image",
    //   image.path,
    // );
    // request.files.add(file);
    // var streamedResponse  = await request.send();
    // var response = await http.Response.fromStream(streamedResponse )
    //     .then((value) => jsonDecode(value.body));
    // if (response.statusCode != 200 ) {
    //   return null;
    // }
    //
    // main() async {
    //   final client = imgur.Imgur(imgur.Authentication.fromToken('YOUR_IMGUR_ACCESS_TOKEN'));
    //
    //   /// Upload an image from path
    //   await client.image
    //       .uploadImage(
    //       imagePath: '/path/of/the/image.png',
    //       title: 'A title',
    //       description: 'A description')
    //       .then((image) => print('Uploaded image to: ${image.link}'));
    // }
    // }
    //
    // return jsonDecode(response.body);
    // var data = response["data"];
    // if (kDebugMode) {
    //   print(data);
    // }
//  }
}

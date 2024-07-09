import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myflutterapp/service//goodday_service.dart';
import 'package:myflutterapp/service//imgur_service.dart';
import 'package:myflutterapp/constants/ui_values.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  final ImgurService _imgurService = ImgurService();
  final GoodDayService _goodDayService = GoodDayService();

  XFile? _image;

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 18),
    foregroundColor: Colors.black,
    backgroundColor: Colors.blue,
    shadowColor: Colors.lightBlueAccent,
    elevation: 3,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: <Widget>[
            const SizedBox(height: 35),
            Image.asset(
              UiValues().logoPath,
              width: 150,
              height: 100,
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: Text(
                UiValues().headerText,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 35),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Jaka niezgodnośc nastąpiła?',
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Numer Projektu',
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ID Produktu / Numer Rysunku',
              ),
            ),
            const SizedBox(
              width: 250,
              height: 150,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Opisz problem',
                ),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Imię i Nazwisko',
              ),
            ),
            const SizedBox(height: 50),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Column(children: <Widget>[
                SizedBox(
                  width: 200,
                  child: ElevatedButton.icon(
                    style: buttonStyle,
                    onPressed: getImage,
                    icon: const Icon(Icons.add_a_photo, size: 22),
                    label: const Text('Dodaj Zdjęcie'),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      // _goodDayService.createTask(data);
                      Fluttertoast.showToast(
                          msg: "Karta zgłoszona",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    },
                    child: const Text('Zgłoś Kartę'),
                  ),
                ),
              ]),
            ]),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Zdjęcie niezgodności:',
              ),
            ),
            _image == null
                ? Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Brak Zdjęcia:',
                    ))
                : Image.file(
                    File(_image!.path),
                    width: 150,
                    height: 250,
                  ),
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      // File file = File(image!.path);
      setState(() {
        _image = image;
      });

      Fluttertoast.showToast(
          msg: "Zdjęcie dodane",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );

      // _imgurService.uploadImage(File(image!.path));

      // final pickedFile = await picker.getImage(source: ImageSource.camera);
      // setState(() {
      //   if (pickedFile != null) {
      //     _image = File(pickedFile.path);
      //   }
      // });
    } catch (e) {
      setState(() {
        _image = null;
      });
    }
  }
}

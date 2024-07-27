import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:myflutterapp/ui_elements/form.dart';
import 'package:uiblock/uiblock.dart';
import 'package:camera/camera.dart';
import 'camera_page.dart';

import 'package:myflutterapp/service/goodday_service.dart';
import 'package:myflutterapp/service/imgur_service.dart';
import 'package:myflutterapp/constants/ui_values.dart';
import 'package:myflutterapp/ui_elements/toast.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.cameras});

  final List<CameraDescription> cameras;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImgurService _imgurService = ImgurService();
  final GoodDayService _goodDayService = GoodDayService();

  final _formKey = GlobalKey<FormBuilderState>();

  final List<File> _imagesList = [];

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 18),
    foregroundColor: Colors.white,
    backgroundColor: const Color(UiValues.wuwerBlue),
    shadowColor: const Color(UiValues.wuwerYellow),
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
              UiValues.logoPath,
              width: 150,
              height: 100,
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: Text(
                UiValues.headerText,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 35),
            FormBuilder(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildForm()
                ],
              ),
            ),
            const SizedBox(height: 50),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Column(children: <Widget>[
                SizedBox(
                  width: 200,
                  child: ElevatedButton.icon(
                    style: buttonStyle,
                    onPressed: () {
                      takePicture(context, widget.cameras);
                    },
                    icon: const Icon(Icons.add_a_photo, size: 22),
                    label: const Text('Dodaj Zdjęcia'),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton.icon(
                    style: buttonStyle,
                    onPressed: () async {
                      await createTask();
                    },
                    icon: const Icon(Icons.check_circle, size: 22),
                    label: const Text('Zgłoś Kartę'),
                  ),
                ),
              ]),
            ]),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Zdjęcia niezgodności:',
              ),
            ),
            _imagesList.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Brak Zdjęcia',
                    ))
                : SizedBox(
                    height: 400,
                    width: 400,
                    child: ListView(
                      padding: const EdgeInsets.all(15),
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (final image in _imagesList) ...[
                          Image.file(
                            File(image.path),
                            width: 250,
                            height: 350,
                          ),
                          const SizedBox(width: 20)
                        ]
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Future takePicture(BuildContext context, List<CameraDescription> cameras) async {
    FocusManager.instance.primaryFocus?.unfocus();
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraPage(cameras: cameras)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!context.mounted) return;

    final XFile? image = result;

    setState(() {
      _imagesList.add(File(image!.path));
    });

    showToast("Zdjęcie dodane");
  }

  Future createTask() async {
    if (_formKey.currentState!.validate()) {

      UIBlock.block(context);

      _formKey.currentState?.save();

      try {
        final linkList = await _imgurService.uploadImages(_imagesList);
        await _goodDayService.createTask(_formKey.currentState!.fields, linkList);
      } on Exception catch (e) {
        showToast("$e");
        return;
      } finally {
        if(mounted) {
          UIBlock.unblock(context);
        }
      }

      showToast("Karta wysłana");

      _formKey.currentState?.reset();
      _imagesList.clear();

      setState((){});
    } else {
      showToast("Uzupełnij brakujące pola");
    }
  }
}

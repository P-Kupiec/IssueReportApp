import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myflutterapp/service/goodday_service.dart';
import 'package:myflutterapp/service/imgur_service.dart';
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

  final _formKey = GlobalKey<FormBuilderState>();

  final List<File> _imagesList = [];

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 18),
    foregroundColor: Colors.white,
    // backgroundColor: Colors.blue,
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
                  SizedBox(
                    width: 450,
                    child: Column(
                      children: <Widget>[
                        FormBuilderTextField(
                          name: UiValues.summaryField,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: UiValues.summaryHint,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          textInputAction: TextInputAction.next,
                        ),
                        FormBuilderTextField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          name: UiValues.projectNrField,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: UiValues.projectNrHint,
                          ),
                          // validator: FormBuilderValidators.compose([
                          //   FormBuilderValidators.required(),
                          // ]),
                          textInputAction: TextInputAction.next,
                        ),
                        FormBuilderTextField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          name: UiValues.productIdField,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: UiValues.productIdHint,
                          ),
                          // validator: FormBuilderValidators.compose([
                          //   FormBuilderValidators.required(),
                          // ]),
                          textInputAction: TextInputAction.next,
                        ),
                        FormBuilderTextField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          name: UiValues.descriptionField,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 4,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: UiValues.descriptionHint,
                          ),
                          // validator: FormBuilderValidators.compose([
                          //   FormBuilderValidators.required(),
                          // ]),
                          textInputAction: TextInputAction.next,
                        ),
                        FormBuilderTextField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          name: UiValues.employeeNameField,
                          decoration: const InputDecoration(
                            //border: UnderlineInputBorder(),
                            border: OutlineInputBorder(),
                            hintText: UiValues.employeeNameHint,
                          ),
                          // onChanged: (val) {
                          //   setState(() {
                          //     // _ageHasError =
                          //   });
                          // },
                          // validator: FormBuilderValidators.compose([
                          //   FormBuilderValidators.required(),
                          // ]),
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    ),
                  ),
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
                    onPressed: () async {
                      await getImage();
                    },
                    icon: const Icon(Icons.add_a_photo, size: 22),
                    label: const Text('Dodaj Zdjęcie'),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: buttonStyle,
                    onPressed: () async {
                      await createTask();
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
                'Zdjęcia niezgodności:',
              ),
            ),
            _imagesList.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Brak Zdjęcia.',
                    ))
                : SizedBox(
                    height: 400,
                    width: 400,
                    child: ListView(
                      padding: const EdgeInsets.all(15),
                      scrollDirection: Axis.horizontal,
                      children: [
                        // SizedBox(width:20),
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

  Future getImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);

      setState(() {
        _imagesList.add(File(image!.path));
      });

      Fluttertoast.showToast(
          msg: "Zdjęcie dodane",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: const Color(UiValues.wuwerBlue),
          fontSize: 16.0);

    } catch (e) {
      setState(() {
      });
    }
  }

  Future createTask() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      final linkList = await _imgurService.uploadImages(_imagesList);

      await _goodDayService.createTask(_formKey.currentState!.fields, linkList);

      Fluttertoast.showToast(
          msg: "Karta wysłana.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: const Color(UiValues.wuwerBlue),
          fontSize: 16.0);

      _formKey.currentState?.reset();

      _imagesList.clear();

      setState(()=>{});
    } else {
      Fluttertoast.showToast(
          msg: "Uzupełnij brakujące pola",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: const Color(UiValues.wuwerBlue),
          fontSize: 16.0);
    }
  }
}

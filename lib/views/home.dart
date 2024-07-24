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
                    width: 600,
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
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          textInputAction: TextInputAction.next,
                        ),
                        FormBuilderTextField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          name: UiValues.productIdField,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: UiValues.productIdHint,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
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
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          textInputAction: TextInputAction.next,
                        ),
                        FormBuilderTextField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          name: UiValues.employeeNameField,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: UiValues.employeeNameHint,
                          ),
                          // onChanged: (val) {
                          //   setState(() {
                          //     // _ageHasError =
                          //   });
                          // },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                      // if (_formKey.currentState!.validate()) {
                      //   print(_formKey.currentState?.value);
                      // }

                      _formKey.currentState?.save();

                      _goodDayService.createTask(_formKey.currentState!.fields);

                      // Fluttertoast.showToast(
                      //     msg: _formKey.currentState
                      //         ?.fields[UiValues.summaryField]?.value ?? "Null",
                      //     toastLength: Toast.LENGTH_SHORT,
                      //     gravity: ToastGravity.BOTTOM,
                      //     timeInSecForIosWeb: 1,
                      //     backgroundColor: Colors.grey,
                      //     textColor: Colors.white,
                      //     fontSize: 16.0);

                      // _formKey.currentState?.reset();
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
                      'Brak Zdjęcia.',
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
          fontSize: 16.0);

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

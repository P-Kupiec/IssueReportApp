import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:myflutterapp/constants/ui_values.dart';

buildForm() {
  return SizedBox(
    width: 450,
    child: Column(
      children: <Widget>[
        FormBuilderTextField(
          enableSuggestions: true,
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
          enableSuggestions: true,
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
          enableSuggestions: true,
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
          enableSuggestions: true,
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
          enableSuggestions: true,
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
  );
}
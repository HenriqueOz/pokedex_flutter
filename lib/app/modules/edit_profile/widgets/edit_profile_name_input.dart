import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

class EditProfileNameInput extends StatelessWidget {
  final TextEditingController controller;

  const EditProfileNameInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTapOutside: (event) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name is required';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text(
          'Name',
          style: TextStyle(color: Colors.black),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: CustomTheme.primaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

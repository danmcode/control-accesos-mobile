import 'package:flutter/material.dart';


class PTextFormField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final bool isPasswordField;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final String? Function(String?) onchange;
  final String initialValue;

  const PTextFormField({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    required this.isPasswordField,
    required this.validator,
    required this.keyboardType,
    required this.onchange,
    this.initialValue = '',
  }) : super(key: key);

  @override
  State<PTextFormField> createState() => _PTextFormFieldState();
}

class _PTextFormFieldState extends State<PTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      obscureText: widget.isPasswordField,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.keyboardType,
      autocorrect: false,
      validator: widget.validator,
      onChanged: widget.onchange,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        suffixIcon: widget.isPasswordField
            ? IconButton(
                onPressed: () {},
                icon: const Icon(Icons.visibility_off_outlined),
              )
            : null,
        prefixIcon: Icon(widget.prefixIcon),
      ),
    );
  }
}

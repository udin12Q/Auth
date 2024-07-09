import 'package:flutter/material.dart';

class FormWidgetContainer extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;

  const FormWidgetContainer(
      {super.key,
      this.controller,
      this.isPasswordField,
      this.fieldKey,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.inputType});

  @override
  _FormWidgetContainerState createState() => _FormWidgetContainerState();
}

class _FormWidgetContainerState extends State<FormWidgetContainer> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade700))),
      child: TextFormField(
        style: TextStyle(color: Colors.grey.shade900),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          // filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey.shade700, fontSize: 17),
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: widget.isPasswordField == true
                ? Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color:
                        _obscureText == false ? Colors.blueAccent : Colors.grey,
                  )
                : const Text(""),
          ),
        ),
      ),
    );
  }
}

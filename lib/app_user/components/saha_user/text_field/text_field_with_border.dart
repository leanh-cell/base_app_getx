import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWithBorder extends StatefulWidget {
  final String labelText;
  final bool withAsterisk;
  final bool? enabled;
  final String? suffix;
  final Icon? icon;
  final TextEditingController? controller;
  final Function(String?)? onChanged;
  final Function(String?)? onSubmitted;
  final Function(String?)? validator;
  final TextCapitalization? textCapitalization;
  final bool? obscureText;
  final bool? autoFocus;
  final TextInputType? textInputType;
  final String? hintText;
  final int? maxLength;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;
  const TextFieldWithBorder(
      {Key? key,
      required this.labelText,
      this.withAsterisk = false,
      this.suffix,
      this.enabled = true,
      this.icon,
      this.controller,
      this.onChanged,
      this.onSubmitted,
      this.validator,
      this.obscureText = false,
      this.textInputType,
      this.hintText,
      this.maxLength,
      this.maxLines,
      this.autoFocus = false,
      this.textCapitalization,
      this.autovalidateMode,
      this.inputFormatters})
      : super(key: key);

  @override
  _TextFieldWithBorderState createState() => _TextFieldWithBorderState();
}

class _TextFieldWithBorderState extends State<TextFieldWithBorder> {
  var _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator as String? Function(String?)?,
      controller: widget.controller,
      enabled: widget.enabled,
      autovalidateMode: widget.autovalidateMode,
      keyboardType: widget.textInputType,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        isDense: true,
        fillColor: Colors.white,
        filled: true,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(30),
        ),
        contentPadding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 15,
          bottom: 15,
        ),
      ),
    );
  }
}

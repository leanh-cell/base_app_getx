import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordTextField extends StatefulWidget {
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

  const PasswordTextField(
      {Key? key,
      required this.labelText,
      this.withAsterisk = false,
      this.suffix,
      this.enabled,
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
      this.inputFormatters})
      : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  var _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextFormField(
          obscureText: _passwordVisible,
          controller: widget.controller,
          textAlign: TextAlign.center,
          onChanged: widget.onChanged,
          validator: widget.validator as String? Function(String?)?,
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
        ),
        Positioned(
          child: IconButton(
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }
}

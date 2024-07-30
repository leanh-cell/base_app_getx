import 'package:flutter/material.dart';

class SahaTextFieldSearch extends StatefulWidget {
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final Function? onClose;
  final bool? enabled;
  final String? initText;
  final bool? autofocus;
  final TextEditingController? textEditingController;

  const SahaTextFieldSearch(
      {Key? key,
      this.enabled = true,
      this.onSubmitted,
      this.onChanged,
      this.autofocus,
      this.onClose,
      this.initText,
      this.textEditingController})
      : super(key: key);

  @override
  _SahaTextFieldSearchState createState() => _SahaTextFieldSearchState();
}

class _SahaTextFieldSearchState extends State<SahaTextFieldSearch> {
  late TextEditingController textEditingController;
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    textEditingController =
        widget.textEditingController ?? TextEditingController();
    textEditingController.text = widget.initText ?? "";
    if (widget.autofocus == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          myFocusNode.requestFocus();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        enabled: widget.enabled!,
        autofocus: false,
        focusNode: myFocusNode,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        textInputAction: TextInputAction.search,
        controller: textEditingController,
        decoration: InputDecoration(
          fillColor: Colors.grey[100],
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              textEditingController.clear();
              widget.onClose!();
            },
          ),
          prefixIcon: Icon(Icons.search_outlined, color: Colors.grey),
          hintText: 'Nhập từ khóa ...',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

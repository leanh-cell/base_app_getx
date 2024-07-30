
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
//import 'package:html_editor_enhanced/html_editor.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class SahaTextFiledContent extends StatefulWidget {
  final String? title;
  final String? contentSaved;
  final Function? onChangeContent;

  SahaTextFiledContent(
      {Key? key, this.title, this.contentSaved, this.onChangeContent})
      : super(key: key);

  @override
  State<SahaTextFiledContent> createState() => _SahaTextFiledContentState();
}

class _SahaTextFiledContentState extends State<SahaTextFiledContent> {
  HtmlWidget? html;

  @override
  void initState() {
    html = HtmlWidget(
      widget.contentSaved ?? "",
    );
    print("==========${widget.contentSaved}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    html = new HtmlWidget(
      widget.contentSaved ?? "",
    );
    return Container(
      child: InkWell(
        onTap: () {
          toChangeScreen();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title ?? "Nội dung",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      toChangeScreen();
                    },
                    child: Text(
                      "Chỉnh sửa",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: html!,
            ),
          ],
        ),
      ),
    );
  }

  void toChangeScreen() {
    Get.to(EditContentHtml(
      contentSaved: widget.contentSaved,
    ))!
        .then((value) {
      if (widget.onChangeContent != null) widget.onChangeContent!(value);
    });
  }
}

class EditContentHtml extends StatefulWidget {
  final String? contentSaved;

  const EditContentHtml({Key? key, this.contentSaved}) : super(key: key);

  @override
  _EditContentHtmlState createState() => _EditContentHtmlState();
}

class _EditContentHtmlState extends State<EditContentHtml> {
  // HtmlEditorController controller = HtmlEditorController();
  late QuillEditorController controller;
  final _toolbarColor = Colors.grey.shade200;

  final _toolbarIconColor = Colors.black87;

  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.clean,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
  ];

  @override
  void initState() {
    super.initState();
    controller = QuillEditorController();
    controller.onTextChanged((text) {
      debugPrint('listening to $text');
    });

    configState();
  }

  Future<bool> _onWillPop() async {
    var txt = await controller.getText();

    Get.back(result: txt);
    return true;
  }

  Future<void> configState() async {
    await Future.delayed(Duration(seconds: 1));

    //   controller.setFullScreen();

    //   controller.clearFocus();
    //   controller.setFocus();
    //
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        appBar: SahaAppBar(
          titleText: "Chỉnh sửa nội dung",
          actions: [
            IconButton(
                icon: Icon(Icons.check),
                tooltip: "Save",
                onPressed: () {
                  _onWillPop();
                }),
          ],
        ),
        body: Column(
          children: [
            ToolBar(
              toolBarColor: _toolbarColor,
              padding: const EdgeInsets.all(8),
              iconSize: 25,
              iconColor: _toolbarIconColor,
              activeIconColor: Colors.greenAccent.shade400,
              controller: controller,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              customButtons: [],
            ),
            Expanded(
              child: QuillHtmlEditor(
                text: widget.contentSaved,
                //hintText: 'Hint text goes here',
                controller: controller,
                isEnabled: true,
                minHeight: 500,
                hintTextAlign: TextAlign.start,
                padding: const EdgeInsets.only(left: 10, top: 10),
                hintTextPadding: const EdgeInsets.only(left: 20),
                onTextChanged: (text) => debugPrint('widget text change $text'),
                onEditorCreated: () {
                  debugPrint('Editor has been loaded');
                },
                onEditorResized: (height) =>
                    debugPrint('Editor resized $height'),
                onSelectionChanged: (sel) =>
                    debugPrint('index ${sel.index}, range ${sel.length}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

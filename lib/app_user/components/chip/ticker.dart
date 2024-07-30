import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TickerStateLess extends StatelessWidget {
  final bool? ticked;
  final String? text;
  final Function(bool va)? onChange;

  const TickerStateLess({Key? key, this.ticked, this.text, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (onChange != null) onChange!(!ticked!);
        },
        child: buildTicker(text: text!, ticked: ticked!));
  }

  Widget buildTicker({String? text, bool? ticked}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 10),
      child: !ticked!
          ? Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                color: Color(0xffF2F2F2),
              ),
              child: Text(
                text ?? "",
                style: TextStyle(fontSize: 14),
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              child: Stack(
                //alignment: Alignment.topLeft,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                    ),
                    child: Text(
                      text ?? "",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Positioned(
                    left: -25,
                    top: -20,
                    child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Theme.of(Get.context!).primaryColor,
                        ),
                        transform: Matrix4.rotationZ(-0.5),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: <Widget>[
                            Positioned(
                                bottom: -0,
                                right: 20,
                                child: new RotationTransition(
                                  turns: new AlwaysStoppedAnimation(20 / 360),
                                  child: new Icon(Icons.check,color: Colors.white,size: 13,),
                                ))
                          ],
                        )),
                  )
                ],
              ),
            ),
    );
  }
}

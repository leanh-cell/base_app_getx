import 'package:com.ikitech.store/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:com.ikitech.store/app_user/model/guess_number_game.dart';
import 'package:com.ikitech.store/app_user/screen2/config/mini_game/guest_number_game/add_guess_number_game/add_result/add_result_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../components/saha_user/button/saha_button.dart';
import '../add_guess_number_game_controller.dart';

class AddResultScreen extends StatelessWidget {
  AddResultScreen(
      {Key? key, required this.listGuessNumberResult, required this.onSubmit}) {
    addResultController = AddResultController(list: listGuessNumberResult);
  }

  final _formKey = GlobalKey<FormState>();
  AddGuessNumberGameController addGuessNumberGameController = Get.find();
  List<GuessNumberResult> listGuessNumberResult;
  late AddResultController addResultController;
  Function onSubmit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Danh sách đáp án')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Đáp án đúng có thể bỏ trống ,sau khi có kết quả có thể vào lại trò chơi cập nhật để công bố kết quả! (ví dụ game đoán tỉ số trận đấu tối nay, sau khi có kết quả trận đấu có thể vào lại game để cập nhật đáp án đúng)',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      ...addResultController.listResult.map((e) => itemResult(
                          e, addResultController.listResult.indexOf(e)))
                    ],
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: 'Xác nhận',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  onSubmit(addResultController.listResult.value);
                  Get.back();
                }
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addResultController.listResult.add(GuessNumberResult());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget itemResult(GuessNumberResult guessNumberResult, int index) {
    var textResult = TextEditingController(text: guessNumberResult.textResult);
    var valueGift = TextEditingController(text: guessNumberResult.valueGift);
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            child: Center(
              child: Text(
                'Thông tin đáp án',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Đáp án:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textResult,
                      onChanged: (v) {
                        addResultController.listResult[index].textResult = v;
                      },
                      validator: (value) {
                        if (value!.length < 1) {
                          return 'Chưa nhập đáp án';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "Nhập đáp án tại đây",
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        addResultController.listResult.removeAt(index);
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Colors.red,
                      ))
                ],
              ),
              if (addGuessNumberGameController
                      .guessGameReq.value.isGuessNumber ==
                  false)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        'Đáp án đúng:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Checkbox(
                          value: guessNumberResult.isCorrect ?? false,
                          onChanged: (v) {
                            addResultController.listResult[index].isCorrect = v;
                            addResultController.listResult.refresh();
                          })
                    ],
                  ),
                ),
              if (guessNumberResult.isCorrect == true ||
                  addGuessNumberGameController
                          .guessGameReq.value.isGuessNumber ==
                      true)
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Phần quà:',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: valueGift,
                            onChanged: (v) {
                              addResultController.listResult[index].valueGift =
                                  v;
                            },
                            validator: (value) {
                              if (value!.length < 1) {
                                return 'Chưa nhập phần quà';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Nhập phần quà tại đây",
                            ),
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

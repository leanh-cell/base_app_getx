import 'package:com.ikitech.store/app_user/model/guess_number_game.dart';
import 'package:get/get.dart';

class AddResultController extends GetxController {
  var listResult = RxList<GuessNumberResult>();
  List<GuessNumberResult> list;
  AddResultController({required this.list}) {
    listResult.value = list.toList();
  }
}

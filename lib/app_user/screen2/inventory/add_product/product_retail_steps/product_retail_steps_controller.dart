import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

class ProductRetailStepsController extends GetxController{
  var listProductRetailStep = RxList<ProductRetailStep>();
  List<ProductRetailStep> listProductRetailInput;

  ProductRetailStepsController({required this.listProductRetailInput}){
    listProductRetailStep.value = listProductRetailInput;
  }
}
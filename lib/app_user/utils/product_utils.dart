import 'dart:core';

import 'package:sahashop_customer/app_customer/model/product.dart';

class ProductUtils {
  static getQuantityMainTotal(Product product) {
    var stock = 0;
    if (product.inventory?.distributes != null) {
      if (product.inventory!.distributes!.isNotEmpty) {
        if (product.inventory!.distributes![0].elementDistributes != null &&
            product.inventory!.distributes![0].elementDistributes!.isNotEmpty) {
          if (product.inventory!.distributes![0].elementDistributes![0]
                      .subElementDistribute !=
                  null &&
              product.inventory!.distributes![0].elementDistributes![0]
                  .subElementDistribute!.isNotEmpty) {
            product.inventory!.distributes![0].elementDistributes!
                .forEach((element) {
              element.subElementDistribute!.forEach((sub) {
                stock = stock + (sub.stock ?? 0);
              });
            });
            return stock;
          } else {
            product.inventory!.distributes![0].elementDistributes!
                .forEach((element) {
              stock = stock + (element.stock ?? 0);
            });
          }
        }
      } else {
        stock = product.inventory?.mainStock ?? 0;
      }
    } else {
      stock = product.inventory?.mainStock ?? 0;
    }
    return stock;
  }
}

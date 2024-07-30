import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_container.dart';

class ProductItemLoadingWidget extends StatelessWidget {
  const ProductItemLoadingWidget({
    Key? key,
    this.width,
  }) : super(key: key);

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      width: width,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey[200]!)),
        padding: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SahaLoadingContainer(
                  width: double.infinity,
                  gloss: 0.6,
                ),
              ), //product.images[0].imageUrl
              SizedBox(height: 5),

              SahaLoadingContainer(
                width: 40,
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 35,
                    width: 70,
                    child: Center(
                      child: SahaLoadingContainer(
                        width: 70,
                        height: 20,
                      ),
                    ),
                  ),
                  SahaLoadingContainer(
                    width: 40,
                    height: 40,
                    gloss: 0.5,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_container.dart';


class OrderLoadingItemWidget extends StatelessWidget {
  const OrderLoadingItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 8,
          color: Colors.grey[200],
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 8,
          ),
          child: Row(
            children: [
              SahaLoadingContainer(
                height: 5,
                width: 20,
              ),
              Spacer(),
              SahaLoadingContainer(
                height: 5,
                width: 20,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              SahaLoadingContainer(
                height: 80,
                width: 80,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SahaLoadingContainer(
                        height: 5,
                        width: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Spacer(),
                              SahaLoadingContainer(
                                height: 5,
                                width: 20,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Spacer(),
                              SahaLoadingContainer(
                                height: 5,
                                width: 20,
                              ),
                              SizedBox(width: 15),
                              SahaLoadingContainer(
                                height: 5,
                                width: 20,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        SahaLoadingContainer(
          height: 5,
          width: 50,
        ),
        Divider(
          height: 1,
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              SahaLoadingContainer(
                height: 5,
                width: 20,
              ),
              Spacer(),
              SahaLoadingContainer(
                height: 30,
                width: 30,
              ),
              SizedBox(
                width: 10,
              ),
              SahaLoadingContainer(
                height: 5,
                width: 20,
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            SahaLoadingContainer(
              height: 35,
              width: 100,
            ),
            Spacer(),
            SahaLoadingContainer(
              height: 5,
              width: 20,
            ),
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 8,
          ),
          child: Row(
            children: [
              SahaLoadingContainer(
                height: 5,
                width: 20,
              ),
              Spacer(),
              SahaLoadingContainer(
                height: 5,
                width: 20,
              ),
            ],
          ),
        ),
        SizedBox(height: 15)
      ],
    );
  }
}

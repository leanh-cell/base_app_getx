import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'order_status_page/order_status_page.dart';

class OrderHistoryCtvScreen extends StatelessWidget {
  final int? initPage;
  final int? ctvId;

  const OrderHistoryCtvScreen({Key? key, this.initPage, this.ctvId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OrderHistoryLoggedScreen(
      initPage: initPage,
      ctvId: ctvId,
    );
  }
}

class OrderHistoryLoggedScreen extends StatefulWidget {
  final int? initPage;
  final int? ctvId;

  OrderHistoryLoggedScreen({Key? key, this.initPage, this.ctvId})
      : super(key: key);

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryLoggedScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  final PageStorageBucket bucket = PageStorageBucket();
  TabController? tabController;
  @override
  void initState() {
    tabController = new TabController(
        length: 10, vsync: this, initialIndex: widget.initPage ?? 0);
    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Đơn mua'),
          bottom: TabBar(
            isScrollable: true,
            controller: tabController,
            tabs: [
              Tab(text: "Chờ xác nhận"),
              Tab(text: "Đang chuẩn bị hàng"),
              Tab(text: "Đang giao hàng"),
              Tab(text: "Đã hoàn thành"),
              Tab(text: "Hết hàng"),
              Tab(text: "Shop huỷ"),
              Tab(text: "Khách đã huỷ"),
              Tab(text: "Lỗi giao hàng"),
              Tab(text: "Chờ trả hàng"),
              Tab(text: "Đã trả hàng"),
            ],
          ),
        ),
        body: PageStorage(
          bucket: bucket,
          child: TabBarView(controller: tabController, children: [
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: WAITING_FOR_PROGRESSING,
              ctvId: widget.ctvId ?? 0,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: PACKING,
              ctvId: widget.ctvId ?? 0,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: SHIPPING,
              ctvId: widget.ctvId ?? 0,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              ctvId: widget.ctvId ?? 0,
              fieldByValue: COMPLETED,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              ctvId: widget.ctvId ?? 0,
              fieldByValue: OUT_OF_STOCK,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              ctvId: widget.ctvId ?? 0,
              fieldByValue: USER_CANCELLED,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              ctvId: widget.ctvId ?? 0,
              fieldByValue: CUSTOMER_CANCELLED,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              ctvId: widget.ctvId ?? 0,
              fieldByValue: DELIVERY_ERROR,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              fieldByValue: CUSTOMER_RETURNING,
              ctvId: widget.ctvId ?? 0,
            ),
            OrderStatusPage(
              fieldBy: "order_status_code",
              ctvId: widget.ctvId ?? 0,
              fieldByValue: CUSTOMER_HAS_RETURNS,
            ),
          ]),
        ),
      ),
    );
  }
}

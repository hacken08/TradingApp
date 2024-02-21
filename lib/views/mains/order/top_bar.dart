import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/themes/colors.dart';
import 'package:trading_app/views/mains/order/Open.dart';
import 'package:trading_app/views/mains/order/gtt.dart';
import 'package:trading_app/views/mains/order/positions.dart';

class OrderPage extends HookConsumerWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: appBackgroundColor,

        // ______________ TopBar ______________
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: appBarColor,
          // backgroundColor: Color.fromARGB(255, 245,246,251),
          elevation: 0,
          scrolledUnderElevation: 0,
         
          title: const Padding(
            padding: EdgeInsets.only(top: 35.0, left: 7),
            child: Text(
              'Orders',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                // color: Colors.black
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 28.0, right: 10),
              child: InkWell(
                onTap: () => {context.go("/contact")},
                child: Container(
                  height: 41,
                  width: 41,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 0.5,
                          blurRadius: 3.5,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(25)),
                  child: Image.asset(
                    'assets/icons/msg.png',
                    color: const Color.fromARGB(185, 0, 0, 0),
                    scale: 1.4,
                    opacity: const AlwaysStoppedAnimation(.8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: InkWell(
                onTap: () => context.go("/editprofile"),
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 39,
                  width: 40,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 0.5,
                          blurRadius: 3.5,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(100)),
                  // child: const Icon(
                  //   Icons.mode_edit_sharp,
                  //   size: 19,
                  //   color: Color.fromARGB(145, 0, 0, 0),
                  // ),
                  child: Image.asset(
                    'assets/icons/search.png',
                    scale: 3,
                    color: const Color.fromARGB(200, 0, 0, 0),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: FloatingActionButton.extended(
            onPressed: () {
              context.push("/buysell");
            },
            backgroundColor: indigoColor,
            icon: const Icon(
              Icons.book_outlined,
              color: Colors.white,
              size: 20,
            ),
            label: const Text(
              'Order History',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
        //  ______________ Top Navigation ______________
        body: Column(children: [
          TabBar(
            dragStartBehavior: DragStartBehavior.down,
            dividerColor: const Color.fromARGB(38, 0, 0, 0),
            dividerHeight: 0.5,
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(
                fontSize: 14.5,
                color: Color.fromARGB(255, 92, 104, 181),
                fontWeight: FontWeight.w700),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            labelPadding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1, vertical: 21),
            indicatorPadding: const EdgeInsets.only(bottom: 3),
            indicatorColor: const Color.fromARGB(255, 69, 94, 204),
            tabs: const <Widget>[
              Text(
                'Order',
                style: TextStyle(
                  fontSize: 15.5,
                  // color: Colors.black
                  // fontWeight: FontWeight.w600
                ),
              ),
              Text(
                'Positions',
                style: TextStyle(
                  fontSize: 15.5,
                  // color: Colors.black
                  // fontWeight: FontWeight.w600
                ),
              ),
              Text(
                'GTT',
                style: TextStyle(
                  fontSize: 15.5,
                  // color: Colors.black
                  // fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
          const Expanded(
              child: TabBarView(children: [Open(), Positions(), Gtt()]))
        ]),
      ),
    );
  }
}

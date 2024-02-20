// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_constructors, avoid_print, unnecessary_brace_in_string_interps

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/states/liveStockValue.dart';
import 'package:trading_app/themes/colors.dart';
import 'package:trading_app/views/Trades/treding_and_search.dart';

import '../../components/listview.dart';

class WishListPage extends HookConsumerWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    ValueNotifier<bool> isLoading = useState<bool>(true);
    ValueNotifier<List<dynamic>> stockData = useState<List<dynamic>>([]);

    // ______________ Values Generator _____________
    // const interval = Duration(seconds: 2);
    // Timer.periodic(interval, (Timer t) {
    //   final data = liveData(10.1);
    // });

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,

      // ----------------- Top bar -----------------
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color.fromARGB(255, 245, 246, 251),
        elevation: 0,
        scrolledUnderElevation: 0,
        // elevation: 0.4,
        // flexibleSpace: SizedBox(height: 60),
        title: Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: const Text(
            'Watchlist',
            style: TextStyle(
              fontSize: 21,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w500,
              // fontFamily: AutofillHints.givenName
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: InkWell(
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () => context.go("/trendingstock"),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 45,
                width: 115,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 0.5,
                        blurRadius: 3.5,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    color: const Color.fromARGB(220, 255, 255, 255),
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/search.png',
                      scale: 3.2,
                      color: const Color.fromARGB(171, 55, 55, 55),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Text(
                        'Search',
                        style: TextStyle(
                            color: Color.fromARGB(255, 145, 145, 145)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0, right: 10, left: 10),
            child: InkWell(
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
                  color: Color.fromARGB(116, 0, 0, 0),
                  scale: 1.4,
                  opacity: const AlwaysStoppedAnimation(.8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 1)
        ],
      ),
      body: // isLoading.value
          //     ? SizedBox(
          //         width: width,
          //         child: const Center(
          //           child: CircularProgressIndicator(),
          //         ),
          //       )
          Container(
        // height: 350,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppBar(
              backgroundColor: Color.fromARGB(255, 245, 246, 251),
              // elevation: 0.4,
              // title: const Text(
              //   'Watchlist',
              //   style: TextStyle(
              //     fontSize: 22,
              //     fontWeight: FontWeight.w600,
              //     // fontFamily: AutofillHints.givenName
              //   ),
              // ),
              actions: <Widget>[
                InkWell(
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => bottomPop(context, const TrendingStock()),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 45,
                    width: 115,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(220, 255, 255, 255),
                        borderRadius: BorderRadius.circular(25)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/search.png',
                          scale: 3.2,
                          color: const Color.fromARGB(171, 55, 55, 55),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Text(
                            'Search',
                            style: TextStyle(
                                color: Color.fromARGB(255, 145, 145, 145)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {},
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(220, 255, 255, 255),
                        borderRadius: BorderRadius.circular(35)),
                    child: Center(
                      child: Image.asset(
                        'assets/icons/filter.png',
                        scale: 2.7,
                        color: const Color.fromARGB(255, 86, 86, 86),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 0.5)
              ],
              toolbarHeight: 0,
            ),
            // ----------------- Watchlist Bar -----------------
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text(
                      "mywishlist",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                        fontSize: 17,
                        color: Color.fromARGB(255, 56, 4, 213),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    highlightColor: Colors.white,
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    splashColor: Colors.white,
                    child: Icon(
                      Icons.add,
                      color: Color.fromARGB(164, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  )
                ],
              ),
            ),
            // Spacer(),
            const Divider(
              thickness: 0.3,
              height: 5,
              color: Color.fromARGB(52, 0, 0, 0),
            ),

            // ____________________ Nifty and BankNifty ____________________
            Container(
              margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 11),
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
              // height: 90,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 245, 246, 251),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black12, width: 0.2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ...... NIfty ......
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Row(
                            children: [
                              SizedBox(width: 4.5),
                              Text(
                                'NIFTY',
                                style: TextStyle(
                                    color: Color.fromARGB(201, 0, 0, 0),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: -0.3,
                                    fontFamily: 'Roboto'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 4.5),
                              Text(
                                '22151.50',
                                style: TextStyle(
                                    color: Color.fromARGB(220, 70, 138, 72) ??
                                        Color.fromARGB(220, 239, 83, 80),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    letterSpacing: 1,
                                    fontFamily: 'Roboto'),
                              ),
                              Icon(Icons.arrow_drop_up,
                                      color:
                                          Color.fromARGB(220, 70, 138, 72)) ??
                                  Icon(Icons.arrow_drop_down,
                                      color: Color.fromARGB(220, 239, 83, 80))
                            ],
                          ),
                          Text(
                            '+27.50(+0.13)',
                            style: TextStyle(
                                color: Color.fromARGB(138, 0, 0, 0),
                                fontWeight: FontWeight.w500,
                                fontSize: 13.5,
                                letterSpacing: 1,
                                fontFamily: 'Roboto'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(width: size.width / 2 - 137),
                  SizedBox(
                    height: 55,
                    child: VerticalDivider(
                      thickness: 0.4,
                      width: 25,
                    ),
                  ),
                  // ...... bankNifty ......
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 4.5),
                              Text(
                                'BANKNIFTY',
                                style: TextStyle(
                                    color: Color.fromARGB(201, 0, 0, 0),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: -0.3,
                                    fontFamily: 'Roboto'),
                              ),
                              Spacer(),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Color.fromARGB(201, 0, 0, 0),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 4.5),
                              Text(
                                '470521.50',
                                style: TextStyle(
                                    color: Color.fromARGB(220, 70, 138, 72) ??
                                        Color.fromARGB(220, 239, 83, 80),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    letterSpacing: 1,
                                    fontFamily: 'Roboto'),
                              ),
                              Icon(Icons.arrow_drop_up,
                                      color:
                                          Color.fromARGB(220, 70, 138, 72)) ??
                                  Icon(Icons.arrow_drop_down,
                                      color: Color.fromARGB(220, 239, 83, 80))
                            ],
                          ),
                          Text(
                            '+515.15.(+1.0%)',
                            style: TextStyle(
                                color: Color.fromARGB(138, 0, 0, 0),
                                fontWeight: FontWeight.w500,
                                fontSize: 13.5,
                                letterSpacing: 1,
                                fontFamily: 'Roboto'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // const SizedBox(height: 10),

            // _____________________ WathcLIst Stocks ________________
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      for (int a = 0; a < 4; a++) ...[
                        ListTile(
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          // onTap: () => halfStockView(context),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 7.0),
                          title: Text(
                            'COALINDA',
                            style: TextStyle(
                                color: Color.fromARGB(201, 0, 0, 0),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                fontFamily: 'Roboto'),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: Text(
                              'NSE',
                              style: const TextStyle(
                                  fontSize: 14.5,
                                  color: Color.fromARGB(255, 95, 95, 95)),
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '446.50',
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        fontSize: 16,
                                        color: Color.fromARGB(
                                                174, 70, 138, 72) ??
                                            Color.fromARGB(208, 239, 83, 80),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Icon(Icons.arrow_drop_up) ??
                                      Icon(Icons.arrow_drop_down),
                                ],
                              ),
                              Text(
                                '-14.20 (-2.06)',
                                style: TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 13,
                                    color: Color.fromARGB(166, 0, 0, 0)),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 0.5,
                          height: 5,
                          color: Color.fromARGB(52, 0, 0, 0),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void bottomPop(context, Widget page) {
    showModalBottomSheet(
      context: context,
      elevation: 3.5,
      useRootNavigator: true,
      enableDrag: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: double.maxFinite,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
          child: page,
        );
      },
    );
  }
}

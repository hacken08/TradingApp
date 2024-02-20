// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/views/Trades/stock_view.dart';

class Overview extends HookConsumerWidget {
  final quote;
  final profile;
  final wsRes;
  const Overview(
      {super.key,
      required this.wsRes,
      required this.quote,
      required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const containerColors = Color.fromARGB(255, 255, 255, 255);
    final List qtyAmt = ['50', '850', '1250', '200', '50'];
    final List qtyAmt2 = ['850', '6150', '1300', '50', '400'];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 245, 250),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ___________ Price Table ___________
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              width: double.maxFinite,
              height: 370,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: containerColors,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0.5,
                    blurRadius: 0.1,
                    offset: const Offset(1, 3),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //  ..... Today price update .....
                    Padding(
                      // ignore: prefer_const_constructors
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PriceStatus(
                            status: 'open',
                            value: trim(quote['open']),
                          ),
                          PriceStatus(
                            status: 'high',
                            value: trim(quote['high']),
                          ),
                          PriceStatus(status: 'low', value: trim(quote['low'])),
                          PriceStatus(
                              status: 'close', value: trim(quote['close']))
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 17, bottom: 8),
                      child: Divider(
                        thickness: 0.4,
                        height: 5,
                        color: Color.fromARGB(52, 0, 0, 0),
                      ),
                    ),

                    //  ..... Table Heading .....
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('QTY'.toUpperCase(),
                              style: const TextStyle(
                                  color: Color.fromARGB(196, 69, 69, 69),
                                  letterSpacing: 0.5,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500)),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Text('Buy Price'.toUpperCase(),
                                style: const TextStyle(
                                    color: Color.fromARGB(196, 69, 69, 69),
                                    letterSpacing: 0.5,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25.0),
                            child: Text('sell price'.toUpperCase(),
                                style: const TextStyle(
                                    color: Color.fromARGB(196, 69, 69, 69),
                                    letterSpacing: 0.5,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Text('Qty'.toUpperCase(),
                              style: const TextStyle(
                                  color: Color.fromARGB(196, 69, 69, 69),
                                  letterSpacing: 0.5,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(top: 9, bottom: 5),
                      child: Divider(
                        thickness: 0.4,
                        height: 5,
                        color: Color.fromARGB(52, 0, 0, 0),
                      ),
                    ),

                    //  ..... Data Table .....
                    for (int i = 0; i < 5; i++) ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 14, left: 0, right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                qtyAmt[i],
                                style: const TextStyle(
                                  color: Color.fromARGB(202, 0, 0, 0),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Expanded(
                              flex: 1,
                              child: Text(
                                '197.50',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  letterSpacing: 0,
                                  color: Color.fromARGB(210, 0, 128, 23),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            const Expanded(
                              flex: 0,
                              child: Text(
                                '199.75',
                                style: TextStyle(
                                  letterSpacing: 0,
                                  color: Color.fromARGB(210, 128, 38, 0),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 1,
                              child: Text(
                                qtyAmt2[i],
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  color: Color.fromARGB(202, 0, 0, 0),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ], // for loop

                    const Padding(
                      padding: EdgeInsets.only(top: 9, bottom: 13),
                      child: Divider(
                        thickness: 0.4,
                        height: 5,
                        color: Color.fromARGB(52, 0, 0, 0),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('117400',
                            style: TextStyle(
                                color: Color.fromARGB(238, 0, 0, 0),
                                fontWeight: FontWeight.w600,
                                fontSize: 15)),
                        Text('Total Quanitity'.toUpperCase(),
                            style: const TextStyle(
                                color: Color.fromARGB(200, 69, 69, 69),
                                letterSpacing: 0.5,
                                fontSize: 13,
                                fontWeight: FontWeight.w500)),
                        const Text('117400',
                            style: TextStyle(
                                color: Color.fromARGB(245, 0, 0, 0),
                                fontWeight: FontWeight.w600,
                                fontSize: 15)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ___________ Go to Chart button ___________
            InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                context.go('/stockdata');
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 7),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                width: double.maxFinite,
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: containerColors,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0.5,
                      blurRadius: 0.1,
                      offset: const Offset(1, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Image.asset(
                        'assets/icons/charts.png',
                        scale: 1.55,
                        color: const Color.fromARGB(255, 102, 128, 201),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text('Go To Charts',
                        style: TextStyle(
                            fontSize: 15.5,
                            color: Color.fromARGB(255, 102, 128, 201),
                            fontWeight: FontWeight.w700))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            // ___________ securifty info button ___________
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.only(right: 5)),
                  ),
                  child: Text(
                    'security info'.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 13,
                  color: Color.fromARGB(229, 74, 80, 202),
                ),
                const SizedBox(width: 20)
              ],
            ),

            // ___________ Container Similar Stocks ___________
            Container(
              margin: const EdgeInsets.only(top: 20, right: 7, left: 7),
              padding: const EdgeInsets.only(
                  left: 20, right: 5, top: 20, bottom: 20),
              width: double.maxFinite,
              height: 205,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: containerColors,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0.5,
                    blurRadius: 0.1,
                    offset: const Offset(1, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ...head.../
                  const Padding(
                    padding: EdgeInsets.only(left: 2.0),
                    child: Text('Similar Stock',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.6,
                            color: Color.fromARGB(149, 0, 0, 0))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  // ... stocks sugestion .../
                  SingleChildScrollView(
                    // clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int a = 0; a < 4; a++) ...[
                          Container(
                            height: 120,
                            width: 190,
                            margin: const EdgeInsets.only(right: 10),
                            // padding: const EdgeInsets.symmetric(
                            //     horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // boxShadow: const [
                                //   BoxShadow(
                                //     color: Color.fromARGB(162, 158, 158, 158),
                                //     blurRadius: 0.4,
                                //     spreadRadius: 0.1,
                                //     offset: Offset(0, 0),
                                //   ),
                                // ],
                                border: Border.all(
                                    color: const Color.fromARGB(104, 0, 0, 0),
                                    width: 0.2,
                                    strokeAlign: BorderSide.strokeAlignInside)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 23,
                                  width: 190,
                                  child: ListTile(
                                    minLeadingWidth: 2,
                                    title: Text(
                                      'powergrid'.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 1.5),
                                      child: Text(
                                        'power grid corp. ltd'.toUpperCase(),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 11,
                                            color:
                                                Color.fromARGB(150, 73, 73, 73),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    trailing: Image.asset(
                                      'assets/icons/yellow_star.png',
                                      scale: 0.2,
                                      color:
                                          const Color.fromARGB(255, 175, 48, 2),
                                    ),
                                    minVerticalPadding: 0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                const SizedBox(
                                  height: 23,
                                  width: 190,
                                  child: ListTile(
                                    title: Text(
                                      '282.90',
                                      style: TextStyle(
                                          fontSize: 14.5,
                                          color:
                                              Color.fromARGB(255, 4, 154, 129),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Padding(
                                      padding: EdgeInsets.only(top: 1.0),
                                      child: Text(
                                        '+5.80 (+2.09%)',
                                        style: TextStyle(
                                            fontSize: 12.5,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ___________ Recent Viewed Stocks ___________
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 7),
              padding: const EdgeInsets.only(
                  left: 20, right: 5, top: 20, bottom: 20),
              width: double.maxFinite,
              height: 205,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: containerColors,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0.5,
                    blurRadius: 0.1,
                    offset: const Offset(1, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ...head.../
                  const Padding(
                    padding: EdgeInsets.only(left: 2.0),
                    child: Text('Recently Viewed',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.6,
                            color: Color.fromARGB(149, 0, 0, 0))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  // ... stocks sugestion .../
                  SingleChildScrollView(
                    // clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int a = 0; a < 4; a++) ...[
                          Container(
                            height: 120,
                            width: 190,
                            margin: const EdgeInsets.only(right: 10),
                            // padding: const EdgeInsets.symmetric(
                            //     horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // boxShadow: const [
                                //   BoxShadow(
                                //     color: Color.fromARGB(162, 158, 158, 158),
                                //     blurRadius: 0.4,
                                //     spreadRadius: 0.1,
                                //     offset: Offset(0, 0),
                                //   ),
                                // ],
                                border: Border.all(
                                    color: const Color.fromARGB(104, 0, 0, 0),
                                    width: 0.2,
                                    strokeAlign: BorderSide.strokeAlignInside)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 23,
                                  width: 190,
                                  child: ListTile(
                                    minLeadingWidth: 2,
                                    title: Text(
                                      'powergrid'.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 1.5),
                                      child: Text(
                                        'power grid corp. ltd'.toUpperCase(),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 11,
                                            color:
                                                Color.fromARGB(150, 73, 73, 73),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    trailing: Image.asset(
                                      'assets/icons/yellow_star.png',
                                      scale: 0.2,
                                      color:
                                          const Color.fromARGB(255, 175, 48, 2),
                                    ),
                                    minVerticalPadding: 0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                const SizedBox(
                                  height: 23,
                                  width: 190,
                                  child: ListTile(
                                    title: Text(
                                      '282.90',
                                      style: TextStyle(
                                          fontSize: 14.5,
                                          color:
                                              Color.fromARGB(255, 4, 154, 129),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Padding(
                                      padding: EdgeInsets.only(top: 1.0),
                                      child: Text(
                                        '+5.80 (+2.09%)',
                                        style: TextStyle(
                                            fontSize: 12.5,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}

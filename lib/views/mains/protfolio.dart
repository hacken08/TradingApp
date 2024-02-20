import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/themes/colors.dart';

class PortfolioPage extends HookConsumerWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ____________ TopBar ____________

          AppBar(
            backgroundColor: const Color.fromARGB(255, 248, 244, 255),
            elevation: 1,
            title: const Padding(
              padding: EdgeInsets.only(top: 23.0),
              child: Text(
                textScaler: TextScaler.linear(1),
                "Order",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.5,
                ),
              ),
            ),
          ),

          //********************* Container *********************//
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Container(
              height: 160,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 0, 34, 68)),

              // __________ Rupee __________
              child: const Padding(
                padding: EdgeInsets.all(17),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '₹ 10,05,150',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    // __________ Profile or loss __________
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          'Overall Gain',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '₹ 15,892,76',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          '(+1.61%)',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 22),

                    //  __________ Invested Value __________
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Invested Value',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              '₹ 9,89,258',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),

                        // __________ Today's Loss or profit __________
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.arrow_downward,
                                  size: 18,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Todays' Loss",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Text(
                                  '₹ 5,89,258',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '(-0.52%)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: 14,
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
              ),
            ),
          ),
          const Spacer(),
        ],
      )),
    );
  }
}

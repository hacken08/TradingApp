// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/themes/colors.dart';

class Trades extends HookConsumerWidget {
  const Trades({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: appBarColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // _________________________ Top Bar _________________________
            Container(
                height: 130,
                // width: size.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(31),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Trading",
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 39,
                            color: Colors.black,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            'assets/icons/serach_1.png',
                            scale: 2.3,
                          ),
                        )
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Container(
                    //       height: 42,
                    //       width: size.width * 0.78,
                    //       decoration: BoxDecoration(
                    //         color: const Color.fromARGB(255, 246, 241, 255),
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //       child: Row(
                    //         children: [
                    //           Container(
                    //             height: 34,
                    //             width: size.width * 0.25,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.white,
                    //                 borderRadius:
                    //                     BorderRadius.circular(12)),
                    //             child: const Center(
                    //                 child: Text(
                    //               "All instrum",
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.w700),
                    //             )),
                    //           ),
                    //           SizedBox(
                    //             height: 34,
                    //             width: size.width * 0.25,
                    //             child: const Center(
                    //                 child: Text(
                    //               "Favorite",
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.w400),
                    //             )),
                    //           ),
                    //           SizedBox(
                    //             height: 34,
                    //             width: size.width * 0.25,
                    //             child: const Center(
                    //                 child: Text(
                    //               "Top Rising",
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.w400),
                    //             )),
                    //           )
                    //         ],
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ],
                )),
            const SizedBox(
              height: 19,
            ),

            // ____________________ STOCk INFO ____________________
            Container(
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 280
                  : size.height * 0.70,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(31),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    horizontalTitleGap: 25,
                    leading: Image.asset(
                      'assets/icons/ethereum.png',
                    ),
                    title: const Text(
                      "ETH",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
                    ),
                    subtitle: const Text(
                      "Etherium Coin",
                      style: TextStyle(fontSize: 15),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "0.05020",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              color: Color.fromARGB(255, 168, 19, 8)),
                        ),
                        Container(
                          height: 19,
                          width: 56,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.green),
                          child: const Center(
                              child: Text(
                            "- 0.21%",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Divider(
                      color: Color.fromARGB(121, 6, 6, 6),
                      indent: 30,
                      endIndent: 30,
                      thickness: 0.35,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        for (int a = 0; a < 3; a++) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.2,
                                ),
                                Image.asset('assets/icons/greenArrow.png',
                                    scale: 3.1),
                                const SizedBox(
                                  width: 14,
                                ),
                                const Text(
                                  '600.00',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16),
                                ),
                                const Text(
                                  ' ETH ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const Text(
                                  '* 200',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16),
                                ),
                                const Text(
                                  " - 891.41",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 19,
            ),

            // ______________________ Other Stock ______________________
            Container(
              height: 109,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: Colors.white,
              ),
              child: Center(
                child: ListTile(
                  horizontalTitleGap: 25,
                  leading: Image.asset(
                    'assets/icons/neo.png',
                    scale: 4.5,
                  ),
                  title: const Text(
                    "NEO",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
                  ),
                  subtitle: const Text(
                    "Neo Coin",
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "0.05020",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            color: Colors.black),
                      ),
                      Container(
                        height: 19,
                        width: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.pink),
                        child: const Center(
                            child: Text(
                          "- 0.21%",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 19,
            ),

            // ____________________ Other stock 2 _____________________
            Container(
              height: 109,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: Colors.white,
              ),
              child: Center(
                child: ListTile(
                  horizontalTitleGap: 25,
                  leading: Image.asset(
                    'assets/icons/dash.png',
                    scale: 2,
                  ),
                  title: const Text(
                    "DASH",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
                  ),
                  subtitle: const Text(
                    "Dash Coin",
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "0.05020",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            color: Colors.black),
                      ),
                      Container(
                        height: 19,
                        width: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green),
                        child: const Center(
                            child: Text(
                          "- 0.21%",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
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
}

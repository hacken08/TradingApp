import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/themes/colors.dart';

class BuySell extends HookConsumerWidget {
  const BuySell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: appBarColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),

            // __________________ Stockprice Tile __________________
            Container(
              height: 80,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: Colors.white,
              ),
              child: Center(
                child: ListTile(
                  title: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Bitcoin ',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16.5),
                      ),
                      const Text(
                        ' & ',
                        style: TextStyle(
                          fontSize: 19.5,
                        ),
                      ),
                      const Text(
                        ' Etherium ',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16.5),
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                      Image.asset(
                        'assets/icons/star.png',
                        scale: 2,
                      ),
                    ],
                  ),
                  trailing: const Text(
                    "9,240,90",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 19,
            ),

            // ___________________ Buy & sell ___________________
            Container(
              height: size.height * 0.199,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 17),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Daily Change',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '3.89%',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'High price',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '9,230,00',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Low price',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '9,240,90',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      indent: 24,
                      endIndent: 24,
                      thickness: 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ________________ Sell button
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 56,
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(88, 159, 185, 255),
                                borderRadius: BorderRadius.circular(19)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "SELL",
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "9,239.50",
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        // ________________ Buy button
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 56,
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(230, 34, 31, 224),
                                borderRadius: BorderRadius.circular(19)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "BUY",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "9,251.50",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

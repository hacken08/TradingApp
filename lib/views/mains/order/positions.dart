import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Positions extends HookConsumerWidget {
  const Positions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        height: size.height - 100,
        color: const Color.fromARGB(255, 244, 245, 250),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // _____________ Search field ___________
            Container(
              width: size.width,
              height: 125,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
              margin: const EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0.5,
                    blurRadius: 0.1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    mouseCursor: MouseCursor.defer,
                    cursorWidth: 0.7,
                    onChanged: (val) {},
                    decoration: InputDecoration(
                      // contentPadding: const EdgeInsets.all(1),
                      hintText: "Search for company or stock",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image.asset(
                          'assets/icons/search.png',
                          color: const Color.fromARGB(225, 97, 93, 93),
                          scale: 2.7,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset(
                          'assets/icons/filter.png',
                          scale: 2.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              width: 0.5, color: Color.fromARGB(52, 0, 0, 0))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey)),
                    ),
                  ),
                  const Spacer(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Stock Name / Exe.Qty',
                        style: TextStyle(
                            letterSpacing: -0.3,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.1,
                            color: Color.fromARGB(195, 41, 41, 41)),
                      ),
                      Text(
                        'Total Gain & Loss / LTP',
                        style: TextStyle(
                            letterSpacing: -0.3,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.1,
                            color: Color.fromARGB(195, 41, 41, 41)),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Open',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500,
                        fontSize: 15.5,
                        fontFamily: 'Roboto'),
                  ),
                  Text(
                    'SELECT AND EXIT',
                    style: TextStyle(
                        fontSize: 14.5,
                        letterSpacing: -0.3,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),

            // ____________________ Open Orders ____________________
            for (int a = 0; a < 2; a++) ...[
              Container(
                width: size.width,
                height: 100,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
                margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2.5,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // .....title.....
                        Text(
                          'BANKNIFTY',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                              fontSize: 17.9,
                              fontFamily: 'Roboto'),
                        ),
                        SizedBox(
                          width: 6,
                        ),

                        // .....Buy Date.....
                        Text(
                          '08 Dec 2022',
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: -0.3,
                              color: Color.fromARGB(174, 31, 31, 31),
                              fontWeight: FontWeight.w500),
                        ),
                        Spacer(),

                        // .....Price.....
                        Text(
                          '+₹0.00',
                          style: TextStyle(
                              color: Color.fromARGB(255, 32, 151, 77),
                              fontWeight: FontWeight.w500,
                              fontSize: 17.2,
                              fontFamily: 'Roboto'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ..... Buy, info .....
                        Container(
                          margin: const EdgeInsets.only(top: 5, left: 0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(190, 238, 234, 234),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'BUY',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 2, 188, 30),
                            ),
                          ),
                        ),

                        // ..... Buy Type .....
                        Container(
                          margin: const EdgeInsets.only(top: 5, left: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(190, 238, 234, 234),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'INTRADAY',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 51, 51, 51),
                            ),
                          ),
                        ),

                        // ..... Exchange .....
                        Container(
                          margin: const EdgeInsets.only(top: 5, left: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(190, 238, 234, 234),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'NFO',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 51, 51, 51),
                            ),
                          ),
                        ),
                        const Spacer(),

                        const Text(
                          '₹0.25',
                          style: TextStyle(
                              color: Color.fromARGB(255, 230, 22, 22),
                              fontWeight: FontWeight.w500,
                              fontSize: 13.5,
                              fontFamily: 'Roboto'),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          '(-99.72%)',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                              fontSize: 13.5,
                              fontFamily: 'Roboto'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '0/1',
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                              fontSize: 13.5,
                              fontFamily: 'Roboto'),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Text('Lot(1Lot=25)',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Color.fromARGB(174, 31, 31, 31),
                                  fontWeight: FontWeight.w500)),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Text('Avg.',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Color.fromARGB(174, 31, 31, 31),
                                  fontWeight: FontWeight.w500)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '₹0.20',
                          style: TextStyle(
                              letterSpacing: 0,
                              color: Color.fromARGB(224, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                              fontSize: 13.5,
                              fontFamily: 'Roboto'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

            ],

            // ______________________ History Button ________________
            InkWell(
              onTap: () {},
              child: Container(
                height: 52,
                width: size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 34, 36, 152), width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    'VIEW CLOSED POSITIONS',
                    style: TextStyle(
                        color: Color.fromARGB(217, 34, 36, 152),
                        fontWeight: FontWeight.w600,
                        fontSize: 12.5,
                        fontFamily: 'Roboto'),
                  ),
                ),
              ),
            ),
            // const Spacer(),

            // // ________ Total Gain & Loss _______
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Text('Total Gain/Loss '),
            //     Icon(Icons.keyboard_arrow_down_outlined)
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}

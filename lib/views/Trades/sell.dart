// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toggle_switch/toggle_switch.dart';

class StockSellPage extends HookConsumerWidget {
  const StockSellPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    const containerColors = Color.fromARGB(255, 255, 255, 255);
    TextEditingController amt = TextEditingController(text: '334.50');

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 244, 251),

      // ___________ Title, back and price ___________
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight:
            MediaQuery.of(context).orientation == Orientation.portrait
                ? 80
                : 60,
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: IconButton(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(Icons.arrow_back),
            iconSize: 23,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'NTPC',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ToggleSwitch(
              minWidth: 65,
              minHeight: 32,
              cornerRadius: 4,
              animate: true,
              animationDuration: 170,
              inactiveBgColor: const Color.fromARGB(255, 232, 235, 244),
              activeBgColor: const [
                Color.fromARGB(255, 213, 77, 79),
              ],
              initialLabelIndex: 0,
              totalSwitches: 2,
              labels: const ['NSE', 'BSE'],
              customTextStyles: const [
                TextStyle(fontWeight: FontWeight.w600, fontSize: 12)
              ],
              onToggle: (index) => print('switched to: $index'),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '₹ 334.20',
                      style: TextStyle(
                        fontSize: 16.5,
                        color: Color.fromARGB(255, 218, 0, 51),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.0),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Color.fromARGB(255, 218, 72, 106),
                        size: 20,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  '-1.90 (-0.57%)',
                  style: TextStyle(
                    fontSize: 15.5,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // _______________ floating buy button _________________
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).orientation == Orientation.portrait
            ? double.maxFinite
            : double.infinity,
        height: 155,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: containerColors,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(72, 158, 158, 158).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 9,
              offset: const Offset(0, -0.5),
            ),
          ],
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // .... Info....
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Margin Required (Aprrox)',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5,
                        color: Color.fromARGB(195, 41, 41, 41))),
                Text('Availiable Cash',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5,
                        color: Color.fromARGB(195, 41, 41, 41))),
              ],
            ),
            const Row(
              children: [
                Text('₹0.00+ ',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 1)),
                Text('Charges',
                    style: TextStyle(
                        color: Color.fromARGB(255, 29, 78, 238),
                        fontWeight: FontWeight.w500,
                        fontSize: 15)),
                Spacer(),
                Text('₹0.00',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 1)),
              ],
            ),
            // const SizedBox(height: 20),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: Container(
                  width: double.maxFinite,
                  height: 52,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 213, 77, 79),
                      borderRadius: BorderRadius.circular(7)),
                  child: const Center(
                    child: Text(
                      'SWITCH TO INTRADAY',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  )),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // ___________ Delivery or intraday ___________
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                width: double.maxFinite,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: containerColors,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     spreadRadius: 0.5,
                  //     blurRadius: 1.0,
                  //     offset: const Offset(0, 0.5),
                  //   ),
                  // ],
                ),
                child: Center(
                  child: ToggleSwitch(
                    minWidth: double.maxFinite,
                    minHeight: double.maxFinite,
                    cornerRadius: 6,
                    animate: false,
                    radiusStyle: true,
                    inactiveBgColor: containerColors,
                    activeFgColor: const Color.fromARGB(255, 213, 77, 79),
                    activeBgColor: const [
                      Color.fromARGB(255, 249, 233, 233),
                    ],
                    initialLabelIndex: 0,
                    totalSwitches: 2,
                    inactiveFgColor: const Color.fromARGB(181, 38, 38, 38),
                    labels: const ['DELIVERY', 'INTRADAY'],
                    customTextStyles: const [
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)
                    ],
                    onToggle: (index) => print('switched to: $index'),
                  ),
                ),
              ),

              // ______________ Qty, limit/market price ______________
              Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                  padding: const EdgeInsets.all(15),
                  width: double.maxFinite,
                  height: 190,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: containerColors,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 1.0,
                        offset: const Offset(0, 0.5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ..... No. of stock ....
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'No. of Shares',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13.5,
                                color: Color.fromARGB(195, 41, 41, 41)),
                          ),
                          Text(
                            'Max Qty 0',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13.5,
                                color: Color.fromARGB(195, 41, 41, 41)),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),

                      // ...... Qty TextField .....
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: SizedBox(
                          height: 45,
                          child: TextFormField(
                            autofocus: true,
                            onChanged: (value) {},
                            cursorHeight: 18,
                            cursorWidth: 1,
                            keyboardType: TextInputType.number,
                            textAlignVertical: TextAlignVertical.top,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              suffixIcon: const Padding(
                                padding: EdgeInsets.only(right: 20, top: 10),
                                child: Text(
                                  'Shares',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Color.fromARGB(195, 41, 41, 41)),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                      width: 0.5,
                                      color: Color.fromARGB(65, 0, 0, 0))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                      width: 0.5,
                                      color: Color.fromARGB(65, 0, 0, 0))),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // ........... Limit/market price .........
                      const Text(
                        'Limit price',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13.5,
                            color: Color.fromARGB(195, 41, 41, 41)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 40,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // minus button...
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 38,
                                height: 47,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 225, 241, 238),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: const Padding(
                                  padding:
                                      EdgeInsets.only(left: 14.0, bottom: 12),
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 32,
                                      color: Color.fromARGB(255, 213, 77, 79),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Amount field...
                            SizedBox(
                              width: size.width * 0.2,
                              height: 47,
                              child: TextFormField(
                                controller: amt,
                                cursorWidth: 1,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.ltr,
                                // textAlignVertical: TextAlignVertical.top,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(bottom: 8),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      borderSide: const BorderSide(
                                          width: 0.5,
                                          color: Color.fromARGB(65, 0, 0, 0))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                          width: 0.5,
                                          color: Color.fromARGB(65, 0, 0, 0))),
                                ),
                              ),
                            ),
                            // Plus button...
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 38,
                                height: 47,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 225, 241, 238),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 9.5, top: 5),
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Color.fromARGB(255, 213, 77, 79),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                        
                            // Toggle limit market..
                            ToggleSwitch(
                              minWidth: 75,
                              minHeight: 44,
                              cornerRadius: 5,
                              animate: true,
                              animationDuration: 170,
                              inactiveBgColor:
                                  const Color.fromARGB(255, 232, 235, 244),
                              activeBgColor: const [
                                Color.fromARGB(255, 213, 77, 79),
                              ],
                              initialLabelIndex: 0,
                              totalSwitches: 2,
                              labels: const ['LIMIT', 'MARKET'],
                              customTextStyles: const [
                                TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12)
                              ],
                              onToggle: (index) => print('switched to: $index'),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),

              Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                  // padding: const EdgeInsets.all(10),
                  width: double.maxFinite,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: containerColors,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 1.0,
                        offset: const Offset(0, 0.5),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 18,
                      ),
                      Text('Smart Orders ',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15)),
                      Text(
                        '(STOP LOSS & GTT)',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  )),

              MediaQuery.of(context).orientation == Orientation.portrait
                  ? const SizedBox(
                      height: 0,
                    )
                  : const SizedBox(
                      height: 170,
                    )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/components/List%20View.dart';

class WishListPage extends HookConsumerWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Scaffold(
      backgroundColor: Colors.white,

      // ----------App Bar----------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.3,
        title: Text(
          "mywatchlist",
          style: TextStyle(
            letterSpacing: 0.6,
            fontSize: 17,
            color: const Color.fromARGB(255, 63, 0, 255),
          ),
        ),
        actions: <Widget>[
          InkWell(
            borderRadius: BorderRadius.circular(40),
            highlightColor: Colors.white,
            focusColor: Colors.white,
            hoverColor: Colors.white,
            splashColor: Colors.white,
            onTap: () {},
            child: Image.asset('assets/icons/menu_icon.png'),
          )
        ],
      ),

      // ignore: prefer_const_constructors
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ---------- Stock Highlight --------
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Container(
              height: 100,
              width: 400,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 241, 241, 241),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Nifty........
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () {
                        print("Nifty");
                      },
                      child: Column(
                        children: [
                          Text(
                            "NIFTY",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "18755.45",
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      const Color.fromARGB(255, 9, 121, 105),
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: const Color.fromARGB(255, 9, 121, 105),
                              )
                            ],
                          ),
                          Text(
                            "-70.55(-o.37%)",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Divider(
                    color: Colors.black,
                    thickness: 4,
                  ),

                  // BANKNIFTY.......
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () {
                        print('BankNifty');
                      },
                      child: Column(
                        children: [
                          Text(
                            "BANKNIFTY",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "43633.75",
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      const Color.fromARGB(255, 9, 121, 105),
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: const Color.fromARGB(255, 9, 121, 105),
                              )
                            ],
                          ),
                          Text(
                            "-304.55(-o.69%)",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // -------------- StockList-------------
       SizedBox(
        height: 418, 
        child:   SingleChildScrollView(
          child: Column(
            children: [
              StockList(
            stockName: "COALINDIA", 
            StockPrice: "123.85\n+0.25(-0.11%)",
            PriceColor: Colors.green,
            ),
             StockList(
            stockName: "IOC", 
            StockPrice: "432.85\n-0.25(+0.41%)",
            PriceColor: Colors.red,
            ),
             StockList(
            stockName: "ONGC", 
            StockPrice: "145.85\n-0.45(+1.231%)",
            PriceColor: Colors.red,
            ),StockList(
          stockName: "COALINDIA", 
          StockPrice: "123.85\n+0.25(-0.11%)",
          PriceColor: Colors.green,
          ),
           StockList(
          stockName: "IOC", 
          StockPrice: "432.85\n-0.25(+0.41%)",
          PriceColor: Colors.red,
          ),
           StockList(
          stockName: "ONGC", 
          StockPrice: "145.85\n-0.45(+1.231%)",
          PriceColor: Colors.red,
          ),
           StockList(
          stockName: "ITC", 
          StockPrice: "600.85\n-0.223(+0.11%)",
          PriceColor: Colors.red,
          ),
           StockList(
          stockName: "WIPRO", 
          StockPrice: "623.45\n+0.35(-0.11%)",
          PriceColor: Colors.green,
          ),
           StockList(
          stockName: "ICICBANK", 
          StockPrice: "123.85\n+0.25(-0.11%)",
          PriceColor: Colors.green,
          ),
            ],
          ),
        )
       )
          
        ],
      ),
    );
  }
}

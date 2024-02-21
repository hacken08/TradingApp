import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';
import 'package:trading_app/services/api.dart';
import 'package:trading_app/utils/alerts.dart';
import 'package:trading_app/views/Trades/buy.dart';
import 'package:trading_app/views/Trades/sell.dart';
import 'package:trading_app/views/Trades/stock%20detail/top_bar.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../utils/utilsmethod.dart';

Future<void> halfStockView(BuildContext context, name) async {
  final size = MediaQuery.of(context).size;
  final List qtyAmt = ['50', '850', '1250', '200', '50'];
  final List qtyAmt2 = ['850', '6150', '1300', '50', '400'];

  // _________________ Stock info >>>>>>>>

  // ValueNotifier<bool> isHighLevel = useState<bool>(false);
  dynamic isLoading;
  dynamic logo;
  dynamic quote;
  dynamic profile;
  dynamic price;
  //  final isLoading = useState<bool>(true);
  //   // ValueNotifier<bool> isHighLevel = useState<bool>(false);
  //   final logo = useState<String>("");
  //   final  quote = useState<dynamic>(null);
  //   final  profile = useState<dynamic>(null);
  //   final  price = useState<dynamic>(null);

  Future<void> getlogo() async {
    final url = genUrl("logo", {"symbol": name});
    final data = await getrequestApi(url);
    if (!data.status) {
      if (!context.mounted) return;
      return erroralert(context, "Error", data.message);
    }
    logo = data.data["url"];
    Logger().d(logo);
  }

  Future<void> getQuote() async {
    final url = genUrl("quote", {"symbol": name});
    final data = await getrequestApi(url);
    if (!data.status) {
      if (!context.mounted) return;
      return erroralert(context, "Error", data.message);
    }
    quote = data.data;
    // Logger().d(quote);
  }

  Future<void> getProfile() async {
    final url = genUrl("profile", {"symbol": name});
    final data = await getrequestApi(url);
    if (!data.status) {
      if (!context.mounted) return;
      return erroralert(context, "Error", data.message);
    }
    profile = data.data;
    // Logger().d(profile);
  }

  Future<void> getPrice() async {
    final url = genUrl("price", {"symbol": name});
    final data = await getrequestApi(url);
    if (!data.status) {
      if (!context.mounted) return;
      return erroralert(context, "Error", data.message);
    }
    price = data.data;
    // Logger().d(price);
  }

  Future<void> init() async {
    isLoading = true;
    await getlogo();
    await getQuote();
    await getProfile();
    await getPrice();
    isLoading = false;
  }

  await init();
  // useEffect(() {
  //   init();
  //   return null;
  // }, []);

  showModalBottomSheet(
      // ignore: use_build_context_synchronously
      context: context,
      elevation: 3.5,
      shape: const RoundedRectangleBorder(
        
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: const Color.fromARGB(255, 244, 245, 250),
      isScrollControlled: true,
      builder: (BuildContext context) {
        // --------------------- Main Page Container ---------------------
        return Container(
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 8, bottom: 0),
            // height: size.height * 0.82,
            width: double.maxFinite,
            color: const Color.fromARGB(255, 244, 245, 250),
            // decoration: const BoxDecoration(
            //   color: Color.fromARGB(245, 244, 245, 250),
            // ),
            child: SingleChildScrollView(
              child: isLoading
                  ? SizedBox(
                      width: size.width,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      children: [
                        // --------------------- Above Stock title and current price ---------------------
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                profile['symbol'],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.5,
                                    fontFamily: 'Roboto'),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(245, 237, 238, 240),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  profile['exchange'],
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 51, 51, 51),
                                  ),
                                ),
                              )
                            ],
                          ),
                          subtitle: Text(quote['datetime']),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                trim(price['price']),
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 34, 130, 88)),
                              ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              Text("+ ${quote['percent_change']}",
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)),
                            ],
                          ),
                        ),

                        // --------------------- Container for pricing detail ---------------------
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 15),
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 20),
                          width: double.maxFinite,
                          height: 380,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(250, 255, 255, 255),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(2, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //  ..... Today price update .....
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    PriceStatus(
                                      status: 'open',
                                      value: trim(quote['open']),
                                    ),
                                    PriceStatus(
                                      status: 'high',
                                      value: trim(quote['high']),
                                    ),
                                    PriceStatus(
                                        status: 'low',
                                        value: trim(quote['low'])),
                                    PriceStatus(
                                        status: 'close',
                                        value: trim(quote['close'])),
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

                              //  ..... Today price update .....
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('QTY'.toUpperCase(),
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(196, 69, 69, 69),
                                            letterSpacing: 0.5,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500)),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 25.0),
                                      child: Text('Buy Price'.toUpperCase(),
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  196, 69, 69, 69),
                                              letterSpacing: 0.5,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 25.0),
                                      child: Text('sell price'.toUpperCase(),
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  196, 69, 69, 69),
                                              letterSpacing: 0.5,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    Text('Qty'.toUpperCase(),
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(196, 69, 69, 69),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            color:
                                                Color.fromARGB(210, 0, 128, 23),
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
                                            color:
                                                Color.fromARGB(210, 128, 38, 0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('117400',
                                      style: TextStyle(
                                          color: Color.fromARGB(238, 0, 0, 0),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15)),
                                  Text('Total Quanitity'.toUpperCase(),
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(200, 69, 69, 69),
                                          letterSpacing: 0.5,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                  const Text('117400',
                                      style: TextStyle(
                                          color: Color.fromARGB(245, 0, 0, 0),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15)),
                                ],
                              )
                            ],
                          ),
                        ),

                        // --------------------- Options chain, charts , Stock details ---------------------
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 0),
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            width: double.maxFinite,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(250, 255, 255, 255),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(2, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // ...... Option Detail Button ......
                                InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/chain.png',
                                        scale: 3,
                                        color: const Color.fromARGB(
                                            255, 102, 128, 201),
                                      ),
                                      const SizedBox(width: 3),
                                      const Text('Option\nChain',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color.fromARGB(
                                                  255, 102, 128, 201),
                                              fontWeight: FontWeight.w700))
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 20, top: 20),
                                  child: VerticalDivider(
                                    thickness: 0.6,
                                    // color: Colors.grey,
                                  ),
                                ),

                                // ...... Charts button ......
                                InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/chain.png',
                                        scale: 3,
                                        color: const Color.fromARGB(
                                            255, 102, 128, 201),
                                      ),
                                      const SizedBox(width: 3),
                                      const Text('Charts',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color.fromARGB(
                                                  255, 102, 128, 201),
                                              fontWeight: FontWeight.w700))
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 20, top: 20),
                                  child: VerticalDivider(
                                    thickness: 0.6,
                                    // color: Colors.grey,
                                  ),
                                ),

                                // ...... Stock Detail button ......
                                InkWell(
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => StockDetail(
                                        profile: profile,
                                        queto: quote,
                                        price: price,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/chain.png',
                                        scale: 3,
                                        color: const Color.fromARGB(
                                            255, 102, 128, 201),
                                      ),
                                      const SizedBox(width: 3),
                                      const Text('Stock\nDetails',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color.fromARGB(
                                                  255, 102, 128, 201),
                                              fontWeight: FontWeight.w700))
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        const SizedBox(height: 8),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          child: Container(
                            color: const Color.fromARGB(255, 241, 243, 248),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // .......... Buy Button ..........
                                Expanded(
                                  child: InkWell(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const StockBuyPage())),
                                    child: Container(
                                      // width: size.width / 2 - 20,s
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color.fromARGB(
                                              255, 0, 142, 116)),
                                      child: Center(
                                          child: Text('Buy'.toUpperCase(),
                                              style: const TextStyle(
                                                  fontSize: 14.5,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w500))),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                // .......... sell Button ..........
                                Expanded(
                                  child: InkWell(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const StockSellPage())),
                                    child: Container(
                                      // width: size.width / 2 - 20,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color.fromARGB(
                                              255, 185, 62, 65)),
                                      child: Center(
                                          child: Text('sell'.toUpperCase(),
                                              style: const TextStyle(
                                                  fontSize: 14.5,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w500))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ));
      });
}

String trim(value) {
  String stringValue = value.toString();
  List<String> parts = stringValue.split('.');
  if (parts.length == 2) {
    return '${parts[0]}.${parts[1].substring(0, 2)}';
  } else {
    return stringValue;
  }
}

class PriceStatus extends StatelessWidget {
  final String status;
  final String value;
  const PriceStatus({
    super.key,
    required this.status,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          status.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Color.fromARGB(255, 77, 81, 86),
              fontSize: 12,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 1,
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              letterSpacing: 0.5,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}

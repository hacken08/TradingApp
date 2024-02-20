import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/services/api.dart';
import 'package:trading_app/themes/colors.dart';

class TradeModel {
  final String date;
  final String type;
  final String asset;
  final String buyPrice;
  final String sellPrice;
  final String quantity;

  TradeModel({
    required this.date,
    required this.type,
    required this.asset,
    required this.buyPrice,
    required this.sellPrice,
    required this.quantity,
  });

  double get profitLoss {
    double buy = double.parse(buyPrice.substring(1)); // Remove the $
    double sell = double.parse(sellPrice.substring(1));
    return sell - buy;
  }

  Color get profitLossColor {
    return profitLoss >= 0 ? Colors.green : Colors.red;
  }
}

class TradeListItem extends StatelessWidget {
  final TradeModel trade;

  const TradeListItem({super.key, required this.trade});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${trade.type} ${trade.asset}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  trade.date,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Buy Price: ${trade.buyPrice}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Sell Price: ${trade.sellPrice}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quantity: ${trade.quantity}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Profit/Loss: ${trade.profitLoss.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: trade.profitLossColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WalletInfo extends HookConsumerWidget {
  final int id;
  const WalletInfo({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    final trade = TradeModel(
      date: 'Sep 15, 2023',
      type: 'Buy',
      asset: 'BTC/USD',
      buyPrice: '\$47.000',
      sellPrice: '\$48.000',
      quantity: '0.5 BTC',
    );

    ValueNotifier<bool> isLoading = useState<bool>(true);

    ValueNotifier<Map<String, dynamic>> userdata =
        useState<Map<String, dynamic>>({});

    Future<void> init() async {
      final data = await apiCall(
        query:
            "query getUserById(\$id:Int!){getUserById (id:\$id){ id, role, name, bio, username, email, profile }} ",
        variables: {"id": id},
        headers: {"content-type": "*/*"},
      );
      if (!data.status && context.mounted) return context.go("/login");
      userdata.value = data.data["getUserById"];

      isLoading.value = false;
    }

    useEffect(() {
      init();
      return null;
    }, []);

    return Scaffold(
      backgroundColor: appBarColor,
      body: isLoading.value
          ? SizedBox(
              width: width,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),

                    // _____________ Top Bar _____________
                    Padding(
                      padding: const EdgeInsets.all(19.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              context.push("/home");
                            },
                            child: const Icon(Icons.arrow_back),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            "Your Account",
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl: userdata.value["profile"] ??
                                    "assets/images/user.png",
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/images/user.png",
                                  fit: BoxFit.cover,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    // ________________________ Balance Box ___________________
                    Container(
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Trading Balance',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.5,
                                      fontSize: 17,
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Text(
                                "₹ 0",
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 31,
                                  color: Colors.black,
                                ),
                              ),
                              // const SizedBox(
                              //   height: 14,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     InkWell(
                              //       onTap: () {},
                              //       child: Container(
                              //         height: 59,
                              //         width: size.width * 0.43,
                              //         decoration: BoxDecoration(
                              //             color: Colors.white,
                              //             border: Border.all(
                              //               color: const Color.fromARGB(
                              //                   230, 34, 31, 224),
                              //             ),
                              //             borderRadius: BorderRadius.circular(12)),
                              //         child: const Center(
                              //           child: Text(
                              //             "WITHDRAW",
                              //             style: TextStyle(
                              //                 color: Color.fromARGB(230, 34, 31, 224),
                              //                 fontSize: 19,
                              //                 fontWeight: FontWeight.w600),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     const SizedBox(
                              //       width: 14,
                              //     ),
                              //     InkWell(
                              //       onTap: () {},
                              //       child: Container(
                              //         height: 59,
                              //         width: size.width * 0.43,
                              //         decoration: BoxDecoration(
                              //             color:
                              //                 const Color.fromARGB(230, 34, 31, 224),
                              //             borderRadius: BorderRadius.circular(12)),
                              //         child: const Center(
                              //           child: Text(
                              //             "ADD FUNDS",
                              //             style: TextStyle(
                              //                 color: Colors.white,
                              //                 fontSize: 19,
                              //                 fontWeight: FontWeight.w600),
                              //           ),
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              // )
                            ],
                          ),
                        )),
                    const SizedBox(height: 14.0),

                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Trades History',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // _____________________ Option Menu _________________________
                    TradeListItem(trade: trade),
                    TradeListItem(trade: trade),
                    TradeListItem(trade: trade),
                    TradeListItem(trade: trade),
                    TradeListItem(trade: trade),
                    TradeListItem(trade: trade),
                  ],
                ),
              ),
            ),
    );
  }
}

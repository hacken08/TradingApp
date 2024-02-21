// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:trading_app/services/api.dart';
// import 'package:trading_app/utils/utilsmethod.dart';

// import '../../themes/colors.dart';
// import '../../utils/alerts.dart';

// class StockData extends HookConsumerWidget {
//   final String name;
//   const StockData({
//     super.key,
//     required this.name,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final width = MediaQuery.of(context).size.width;
//     ValueNotifier<bool> isLoading = useState<bool>(true);
//     // ValueNotifier<bool> isHighLevel = useState<bool>(false);
//     ValueNotifier<String> logo = useState<String>("");
//     ValueNotifier<dynamic> quote = useState<dynamic>(null);
//     ValueNotifier<dynamic> profile = useState<dynamic>(null);
//     ValueNotifier<dynamic> price = useState<dynamic>(null);

//     // ValueNotifier<List<ChartSampleData>> chartdata = useState([]);

//     // ValueNotifier<List> stockData = useState<List>([]);

//     // Future<void> init() async {
//     //   final data = await getrequestApi(
//     //       "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=$name&interval=5min&apikey=$alphaVantage");
//     //   data.data["Time Series (5min)"].forEach((key, value) {
//     //     DateTime x = DateTime.parse(key);
//     //     double open = double.parse(value["1. open"]);
//     //     double close = double.parse(value["4. close"]);
//     //     double low = double.parse(value["3. low"]);
//     //     double high = double.parse(value["2. high"]);

//     //     ChartSampleData newData = ChartSampleData(
//     //       x: x,
//     //       open: open,
//     //       close: close,
//     //       low: low,
//     //       high: high,
//     //     );
//     //     chartdata.value = [...chartdata.value, newData];
//     //   });
//     //   isLoading.value = false;
//     // }

//     Future<void> getlogo() async {
//       final url = genUrl("logo", {"symbol": name});
//       final data = await getrequestApi(url);
//       if (!data.status) {
//         if (!context.mounted) return;
//         return erroralert(context, "Error", data.message);
//       }
//       logo.value = data.data["url"];
//     }

//     Future<void> getQuote() async {
//       final url = genUrl("quote", {"symbol": name});
//       final data = await getrequestApi(url);
//       if (!data.status) {
//         if (!context.mounted) return;
//         return erroralert(context, "Error", data.message);
//       }
//       quote.value = data.data;
//     }

//     Future<void> getProfile() async {
//       final url = genUrl("profile", {"symbol": name});
//       final data = await getrequestApi(url);
//       if (!data.status) {
//         if (!context.mounted) return;
//         return erroralert(context, "Error", data.message);
//       }
//       profile.value = data.data;
//     }

//     Future<void> getPrice() async {
//       final url = genUrl("price", {"symbol": name});
//       final data = await getrequestApi(url);
//       if (!data.status) {
//         if (!context.mounted) return;
//         return erroralert(context, "Error", data.message);
//       }
//       price.value = data.data;
//     }

//     Future<void> init() async {
//       isLoading.value = true;
//       await getlogo();
//       await getQuote();
//       await getProfile();
//       await getPrice();
//       isLoading.value = false;
//     }

//     useEffect(() {
//       init();
//       return null;
//     }, []);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: appBarColor,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: blackColor,
//           ),
//           onPressed: () => {context.pop()},
//         ),
//         title: isLoading.value
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Text(
//                 quote.value["name"],
//                 textScaler: const TextScaler.linear(1),
//                 style: TextStyle(
//                   color: blackColor,
//                 ),
//               ),
//         centerTitle: true,
//         // actions: [
//         //   IconButton(
//         //     onPressed: () {
//         //       isHighLevel.value = !isHighLevel.value;
//         //     },
//         //     icon: isHighLevel.value
//         //         ? Icon(
//         //             Icons.auto_graph,
//         //             color: blackColor,
//         //           )
//         //         : Icon(
//         //             Icons.graphic_eq,
//         //             color: blackColor,
//         //           ),
//         //   ),
//         // ],
//       ),
//       bottomNavigationBar: InkWell(
//         onTap: () {
//           comingalert(context);
//         },
//         child: Container(
//           height: 40,
//           decoration: const BoxDecoration(color: Colors.green),
//           child: const Center(
//             child: Text(
//               "BUY",
//               textScaler: TextScaler.linear(1),
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: isLoading.value
//           ? SizedBox(
//               width: width,
//               child: const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             )
//           : SafeArea(
//               child: Column(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 15),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10, vertical: 27),
//                     width: width * 0.9,
//                     decoration: BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(
//                             color: Colors.grey.withOpacity(0.55), width: 0.4),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 80,
//                           width: 75,
//                           padding: const EdgeInsets.all(5),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100),
//                             color: Colors.white,
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(100),
//                             child: CachedNetworkImage(
//                               imageUrl: logo.value,
//                               progressIndicatorBuilder:
//                                   (context, url, downloadProgress) =>
//                                       CircularProgressIndicator(
//                                 value: downloadProgress.progress,
//                               ),
//                               errorWidget: (context, url, error) => Image.asset(
//                                 "assets/images/user.png",
//                                 fit: BoxFit.cover,
//                               ),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               longtext(quote.value["name"], 30),
//                               style: const TextStyle(
//                                   fontSize: 14, fontWeight: FontWeight.w500),
//                             ),
//                             const SizedBox(
//                               height: 2,
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   quote.value["symbol"],
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: blackColor.withOpacity(0.75),
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: const EdgeInsets.symmetric(
//                                       horizontal: 10),
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 4, vertical: 1),
//                                   decoration: BoxDecoration(
//                                     color: const Color.fromARGB(
//                                         190, 238, 234, 234),
//                                     borderRadius: BorderRadius.circular(
//                                         4), // Optional: Add border radius
//                                   ),
//                                   child: Text(
//                                     quote.value["exchange"],
//                                     style: const TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w500,
//                                       color: Color.fromARGB(255, 51, 51, 51),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                         const Spacer(),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               profile.value["country"],
//                               style: TextStyle(fontSize: 16, color: blackColor),
//                             ),
//                             const SizedBox(
//                               height: 2,
//                             ),
//                             Text(
//                               quote.value["currency"],
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: blackColor.withOpacity(0.75),
//                               ),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(vertical: 10),
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Row(
//                       children: [
//                         const Text(
//                           "STOCK PRICE",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.black87,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const Spacer(),
//                         Text(
//                           "\u{20B9} ${double.parse(price.value["price"]).toStringAsFixed(2)}",
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Divider(),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       DetailsCard(
//                         title: "OPEN",
//                         name: double.parse(quote.value["open"])
//                             .toStringAsFixed(2),
//                       ),
//                       DetailsCard(
//                         title: "HIGH",
//                         name: double.parse(quote.value["high"])
//                             .toStringAsFixed(2),
//                       ),
//                       DetailsCard(
//                         title: "LOW",
//                         name:
//                             double.parse(quote.value["low"]).toStringAsFixed(2),
//                       ),
//                       DetailsCard(
//                         title: "Prev. Close",
//                         name: double.parse(quote.value["previous_close"])
//                             .toStringAsFixed(2),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       DetailsCard(
//                         title: "52 WEEK HIGH",
//                         name:
//                             double.parse(quote.value["fifty_two_week"]["high"])
//                                 .toStringAsFixed(2),
//                       ),
//                       DetailsCard(
//                         title: "52 WEEK LOW",
//                         name: double.parse(quote.value["fifty_two_week"]["low"])
//                             .toStringAsFixed(2),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//     );

//     // return Scaffold(
//     //   appBar: AppBar(
//     //     backgroundColor: appBarColor,
//     //     leading: IconButton(
//     //       icon: Icon(
//     //         Icons.arrow_back,
//     //         color: blackColor,
//     //       ),
//     //       onPressed: () => {context.pop()},
//     //     ),
//     //     title: Text(
//     //       name,
//     //       textScaler: const TextScaler.linear(1),
//     //       style: TextStyle(
//     //         color: blackColor,
//     //       ),
//     //     ),
//     //     centerTitle: true,
//     //     actions: [
//     //       IconButton(
//     //         onPressed: () {
//     //           isHighLevel.value = !isHighLevel.value;
//     //         },
//     //         icon: isHighLevel.value
//     //             ? Icon(
//     //                 Icons.auto_graph,
//     //                 color: blackColor,
//     //               )
//     //             : Icon(
//     //                 Icons.graphic_eq,
//     //                 color: blackColor,
//     //               ),
//     //       ),
//     //     ],
//     //   ),
//     //   bottomNavigationBar: InkWell(
//     //     onTap: () {
//     //       comingalert(context);
//     //     },
//     //     child: Container(
//     //       height: 40,
//     //       decoration: const BoxDecoration(color: Colors.green),
//     //       child: const Center(
//     //         child: Text(
//     //           "BUY",
//     //           textScaler: TextScaler.linear(1),
//     //           style: TextStyle(
//     //             color: Colors.white,
//     //             fontWeight: FontWeight.w500,
//     //           ),
//     //         ),
//     //       ),
//     //     ),
//     //   ),
//     //   body: isLoading.value
//     //       ? SizedBox(
//     //           width: width,
//     //           child: const Center(
//     //             child: CircularProgressIndicator(),
//     //           ),
//     //         )
//     //       : SafeArea(
//     //           child: SfCartesianChart(
//     //             title: ChartTitle(
//     //               text:
//     //                   "$name ${chartdata.value[0].x.toString().split(" ")[0]}",
//     //             ),
//     //             legend: const Legend(
//     //               isVisible: true,
//     //               isResponsive: true,
//     //               position: LegendPosition.bottom,
//     //             ),
//     //             backgroundColor: Colors.transparent,
//     //             series: isHighLevel.value
//     //                 ? <HiloOpenCloseSeries>[
//     //                     HiloOpenCloseSeries<ChartSampleData, DateTime>(
//     //                       dataSource: chartdata.value,
//     //                       xValueMapper: (ChartSampleData sales, _) => sales.x,
//     //                       lowValueMapper: (ChartSampleData sales, _) =>
//     //                           sales.low,
//     //                       highValueMapper: (ChartSampleData sales, _) =>
//     //                           sales.high,
//     //                       openValueMapper: (ChartSampleData sales, _) =>
//     //                           sales.open,
//     //                       closeValueMapper: (ChartSampleData sales, _) =>
//     //                           sales.close,
//     //                     ),
//     //                   ]
//     //                 : <CandleSeries>[
//     //                     CandleSeries<ChartSampleData, DateTime>(
//     //                       dataSource: chartdata.value,
//     //                       xValueMapper: (ChartSampleData sales, _) => sales.x,
//     //                       lowValueMapper: (ChartSampleData sales, _) =>
//     //                           sales.low,
//     //                       highValueMapper: (ChartSampleData sales, _) =>
//     //                           sales.high,
//     //                       openValueMapper: (ChartSampleData sales, _) =>
//     //                           sales.open,
//     //                       closeValueMapper: (ChartSampleData sales, _) =>
//     //                           sales.close,
//     //                     ),
//     //                   ],
//     //             trackballBehavior: TrackballBehavior(
//     //               enable: true,
//     //               activationMode: ActivationMode.singleTap,
//     //             ),
//     //             zoomPanBehavior: ZoomPanBehavior(
//     //               enablePanning: true,
//     //               enablePinching: true,
//     //               zoomMode: ZoomMode.xy,
//     //               enableDoubleTapZooming: true,
//     //             ),
//     //             tooltipBehavior: TooltipBehavior(enable: true),
//     //             enableAxisAnimation: true,
//     //             primaryXAxis: DateTimeAxis(dateFormat: DateFormat.Hm()),
//     //             primaryYAxis: const NumericAxis(interval: 0.05),
//     //           ),
//     //         ),
//     // );
//   }
// }

// class ChartSampleData {
//   final DateTime? x;
//   final num? open;
//   final num? close;
//   final num? low;
//   final num? high;
//   ChartSampleData({this.x, this.open, this.close, this.high, this.low});
// }

// class DetailsCard extends HookConsumerWidget {
//   final String title;
//   final String name;

//   const DetailsCard({
//     super.key,
//     required this.title,
//     required this.name,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Column(
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 14,
//             color: Colors.black,
//           ),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Text(
//           "\u{20B9} $name",
//           style: const TextStyle(
//             fontSize: 16,
//             color: Colors.black,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously, deprecated_member_use, unused_local_variable

import 'dart:async';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trading_app/states/liveStockValue.dart';
import 'package:trading_app/states/mainstate.dart';
import 'package:trading_app/states/userstate.dart';
import 'package:trading_app/themes/colors.dart';

import '../../services/api.dart';
import '../../utils/alerts.dart';

class ChartSampleData {
  final DateTime? x;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
  ChartSampleData({this.x, this.open, this.close, this.high, this.low});
}

class StockData extends HookConsumerWidget {
  const StockData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    Color secondaryColor = const Color.fromARGB(255, 36, 2, 95);

    final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
    final userStateW = ref.watch(userState);

    ValueNotifier<bool> isLoading = useState<bool>(true);
    ValueNotifier<int> userid = useState(0);
    ValueNotifier<String> username = useState<String>("");
    ValueNotifier<String?> userimg = useState<String?>(null);
    ValueNotifier<String?> token = useState<String?>(null);
    ValueNotifier<String?> role = useState<String?>(null);
    ValueNotifier<String?> email = useState<String?>(null);
    ValueNotifier<List<dynamic>> users = useState<List<dynamic>>([]);

    // ValueNotifier<bool> isLoading = useState<bool>(true);
    ValueNotifier<List<ChartSampleData>> chartdata =
        useState<List<ChartSampleData>>([]);
    ValueNotifier<bool> isHighLevel = useState<bool>(false);
    ValueNotifier<String> logo = useState<String>("");
    ValueNotifier<dynamic> quote = useState<dynamic>(null);
    ValueNotifier<dynamic> profile = useState<dynamic>(null);
    ValueNotifier<dynamic> price = useState<dynamic>(null);

    Future<void> init() async {
      log("working");
      userid.value = await userStateW.getUserData(UserData.id, context);
      role.value = await userStateW.getUserData(UserData.role, context);
      token.value = await userStateW.getUserData(UserData.token, context);
      final data = await apiCall(
        query:
            "query getUserById(\$id:Int!){getUserById (id:\$id){ id, role, name, username, email, profile, iscomplete}} ",
        variables: {"id": userid.value},
        headers: {"content-type": "*/*"},
      );
      if (data.data.length == 0) {
        await ref.watch(mainState).setLogin(false);
      }
      username.value = data.data["getUserById"]["username"];
      userimg.value = data.data["getUserById"]["profile"];
      email.value = data.data["getUserById"]["email"];

      final getusers = await apiCall(
        query:
            "query getAllUser{getAllUser{ id, role, name, username, email, profile, iscomplete}} ",
        variables: {"id": userid.value},
        headers: {"content-type": "*/*"},
      );
      log(getusers.toString());
      if (getusers.status) {
        users.value = getusers.data["getAllUser"];
        log(getusers.data.toString());
      }

      // ______________ Values Generator _____________
      Map liveQuote = {};
      const interval = Duration(seconds: 5);
      Timer.periodic(
        interval,
        (Timer t) {
          liveQuote = liveData(10.1);

          chartdata.value = [
            ...chartdata.value,
            ChartSampleData(
              x: DateTime.now(),
              open: num.parse(liveQuote['open']),
              high: num.parse(liveQuote['high']),
              low: num.parse(liveQuote['low']),
              close: num.parse(
                liveQuote['close'],
              ),
            ),
          ];
        },
      );
      isLoading.value = false;

      // if (!data.data["getUserById"]["iscomplete"]) {
      //   if (context.mounted) profileComplated(context);
      // }
    }

    Future<void> intisocket() async {
      io.Socket socket = io.io("http://localhost:3000", <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": false,
        "query": {"username": "karan"}
      });
      socket.connect();
      socket.onConnect((_) {
        log("connected to websocket");
      });
      socket.on('newChat', (message) {
        log(message.toString());
        log("new chat");
      });

      socket.emit("chat", {"test": "test message"});
    }

    useEffect(() {
      init();
      intisocket();
      return null;
    }, []);
    String empty = " ";
    TextEditingController searchText = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'name',
          textScaler: const TextScaler.linear(1),
          style: TextStyle(
            color: blackColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              isHighLevel.value = !isHighLevel.value;
            },
            icon: isHighLevel.value
                ? Icon(
                    Icons.auto_graph,
                    color: blackColor,
                  )
                : Icon(
                    Icons.graphic_eq,
                    color: blackColor,
                  ),
          ),
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          comingalert(context);
        },
        child: Container(
          height: 40,
          decoration: const BoxDecoration(color: Colors.green),
          child: const Center(
            child: Text(
              "BUY",
              textScaler: TextScaler.linear(1),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      body: isLoading.value
          ? SizedBox(
              width: size.width,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SafeArea(
              child: SfCartesianChart(
                title: const ChartTitle(
                  text: 'Stock Charts',
                  //"$name ${chartdata.value[0].x.toString().split(" ")[0]}",
                ),
                legend: const Legend(
                  isVisible: true,
                  isResponsive: true,
                  position: LegendPosition.bottom,
                ),
                backgroundColor: Colors.transparent,
                series: isHighLevel.value
                    ? <HiloOpenCloseSeries>[
                        HiloOpenCloseSeries<ChartSampleData, DateTime>(
                          dataSource: chartdata.value,
                          xValueMapper: (ChartSampleData sales, _) => sales.x,
                          lowValueMapper: (ChartSampleData sales, _) =>
                              sales.low,
                          highValueMapper: (ChartSampleData sales, _) =>
                              sales.high,
                          openValueMapper: (ChartSampleData sales, _) =>
                              sales.open,
                          closeValueMapper: (ChartSampleData sales, _) =>
                              sales.close,
                        ),
                      ]
                    : <CandleSeries>[
                        CandleSeries<ChartSampleData, DateTime>(
                          dataSource: chartdata.value,
                          xValueMapper: (ChartSampleData sales, _) => sales.x,
                          lowValueMapper: (ChartSampleData sales, _) =>
                              sales.low,
                          highValueMapper: (ChartSampleData sales, _) =>
                              sales.high,
                          openValueMapper: (ChartSampleData sales, _) =>
                              sales.open,
                          closeValueMapper: (ChartSampleData sales, _) =>
                              sales.close,
                        ),
                      ],
                trackballBehavior: TrackballBehavior(
                  enable: true,
                  activationMode: ActivationMode.singleTap,
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                  enablePinching: true,
                  zoomMode: ZoomMode.xy,
                  enableMouseWheelZooming: true,
                  enableDoubleTapZooming: true,
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                enableAxisAnimation: true,
                primaryXAxis: DateTimeAxis(dateFormat: DateFormat.Hm()),
                primaryYAxis: const NumericAxis(interval: 0.05),
              ),
            ),
    );
  }
}

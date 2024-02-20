// ignore_for_file: camel_case_types, avoid_print, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/services/api.dart';
import 'package:trading_app/utils/alerts.dart';
import 'package:trading_app/utils/utilsmethod.dart';
import 'package:trading_app/views/Trades/stock_view.dart';

class SearchQueryNotifier extends ValueNotifier<String> {
  SearchQueryNotifier(super.value);
}

final searchQueryNotifier = SearchQueryNotifier('');

class TrendingStock extends HookConsumerWidget {
  const TrendingStock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<bool> isLoading = useState<bool>(true);
    ValueNotifier<List<dynamic>> stockData = useState<List<dynamic>>([]);
    ValueNotifier<List<dynamic>> searchedStock = useState<List<dynamic>>([]);

    Future<void> init() async {
      final url = genUrl("stocks", {"country": "IN"});
      final data = await getrequestApi(url);
      if (!data.status) erroralert(context, "Error", data.message);
      stockData.value = data.data["data"];
      isLoading.value = false;
    }

    useEffect(() {
      init();
      return null;
    }, []);

    filterStock(String value) {
      if (value.isEmpty) {
        searchedStock.value = [];
        return;
      }
      List<dynamic> filter = stockData.value
          .where((item) => item['name']
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .take(20)
          .toList();

      searchedStock.value = filter;
      // Logger().d("result: ${searchedStock.value}");
    }

    return ValueListenableBuilder(
        valueListenable: searchQueryNotifier,
        builder: (context, searchQuery, child) {
          return Scaffold(
              body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 58,
                        child: TextFormField(
                          onChanged: (value) {
                            filterStock(value);
                          },
                          decoration: InputDecoration(
                            hintText: "Search for company or stock",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Image.asset(
                                'assets/icons/search.png',
                                color: const Color.fromARGB(255, 97, 93, 93),
                                scale: 2.7,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    width: 0.5,
                                    color: Color.fromARGB(52, 0, 0, 0))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.grey)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // ______________ Search and back button ______________

                const SizedBox(
                  height: 15,
                ),

                // _________________ Treding Stocks _________________
                // (searchQuery.isEmpty)
                //     ? const TredingPage()
                //     : (searchQuery != 'nifty')
                //         ? const NothingFound()
                //         : const searchedContent()
                // searchedStock.value.isNotEmpty
                //     ? const TredingPage()
                //     :
                Expanded(
                  child: ListView.builder(
                      itemCount: searchedStock.value.length,
                      itemBuilder: (context, index) {
                        String name = searchedStock.value[index]["name"];
                        List<String> words = name.split(' ');
                        name = words.take(2).join(' ');

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                              ),
                              child: ListTile(
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () => halfStockView(
                                    context,
                                    searchedStock.value[index]["symbol"] ??
                                        ' '),
                                // onTap: () =>  context.go(
                                //     "watchlist/stockData/${stockData.value[index]["symbol"]}"),
                                contentPadding: const EdgeInsets.only(
                                    left: 0.0, right: 10.0),
                                leading: const Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 233, 236, 253),
                                    child: Text(
                                      'EQ',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 112, 46, 255),
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Row(
                                  children: [
                                    SizedBox(
                                      width: 241,
                                      child: Text(
                                        searchedStock.value[index]["name"],
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.6,
                                            fontFamily: 'Roboto'),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      searchedStock.value[index]["symbol"] ??
                                          ' ',
                                      overflow: TextOverflow.fade,
                                      // 'lkdsjf',
                                      style: const TextStyle(
                                          fontSize: 15.5,
                                          color: Colors.black87),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 5, left: 6),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 1),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            190, 238, 234, 234),
                                        borderRadius: BorderRadius.circular(
                                            4), // Optional: Add border radius
                                      ),
                                      child: Text(
                                        searchedStock.value[index]
                                                ["exchange"] ??
                                            ' ',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 51, 51, 51),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: InkWell(
                                  focusColor: Colors.white,
                                  splashColor: Colors.white,
                                  hoverColor: Colors.white,
                                  onTap: () {},
                                  child: Image.asset(
                                    'assets/icons/star_add.png',
                                    scale: 1.8,
                                    color: const Color.fromARGB(140, 0, 0, 0),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 0.5,
                              height: 5,
                              color: Color.fromARGB(52, 0, 0, 0),
                            ),
                          ],
                        );
                      }),
                ),
                const Divider(
                  thickness: 0.5,
                  height: 5,
                  color: Color.fromARGB(52, 0, 0, 0),
                ),
              ],
            ),
          ));
        });
  }
}

// class SearchContentWidget extends StatelessWidget {
//   const SearchContentWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Step 5: Use ValueListenableBuilder to rebuild when search query changes
//     return ValueListenableBuilder<String>(
//       valueListenable: searchQueryNotifier,
//       builder: (context, searchQuery, child) {
//         // Step 6: Return the content based on the search query
//         return const Text('Search results');
//       },
//     );
//   }
// }

// ****************** Treding Stock Screen *******************
class TredingPage extends HookConsumerWidget {
  const TredingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List stockName = ['INFIBEAM', 'IDEA', 'SUZLON'];
    final List stockSub = [
      'Infibeam Avenues Limited',
      'Vodafone Idea Limited',
      'Suzlon Energy Limited'
    ];

    final userPic = [
      'assets/profiles/sample_9.png',
      'assets/profiles/sample_4.png',
      'assets/profiles/sample_2.png',
    ];
    final List users = ['Rahul', 'Anmol', 'Sobra'];
    final List bio = [
      'Just trying trading',
      'When this over',
      'Why i am doing this'
    ];

    final List optData = [
      '01 Feb 2024',
      '01 Feb 2024',
      '01 Feb 2024',
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'TRENDING STOCKS'.toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.6,
                  color: Color.fromARGB(149, 0, 0, 0)),
            ),
            InkWell(
                focusColor: Colors.green,
                splashColor: Colors.white,
                hoverColor: Colors.white,
                onTap: () {},
                child: Text('View all'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                    )))
          ],
        ),
        const SizedBox(
          height: 8,
        ),

        // ___________________ Trending Stock tiles ___________________
        for (int i = 0; i < 3; i++) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: ListTile(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              // onTap: () => halfStockView(context),
              contentPadding: const EdgeInsets.only(left: 0.0, right: 10.0),
              leading: const Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 233, 236, 253),
                  child: Text(
                    'EQ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 112, 46, 255),
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    stockName[i],
                    style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: 'Roboto'),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(190, 238, 234, 234),
                      borderRadius: BorderRadius.circular(
                          4), // Optional: Add border radius
                    ),
                    child: const Text(
                      'NSE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                    ),
                  )
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  stockSub[i],
                  style: const TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 95, 95, 95)),
                ),
              ),
              trailing: InkWell(
                focusColor: Colors.white,
                splashColor: Colors.white,
                hoverColor: Colors.white,
                onTap: () {},
                child: Image.asset(
                  'assets/icons/star_add.png',
                  scale: 1.8,
                  color: const Color.fromARGB(140, 0, 0, 0),
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 0.5,
            height: 5,
            color: Color.fromARGB(52, 0, 0, 0),
          ),
        ], // for loop
        const SizedBox(
          height: 40,
        ),

        // _________________ Tredning Options _________________
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'top user'.toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.6,
                  color: Color.fromARGB(149, 0, 0, 0)),
            ),
            InkWell(
                focusColor: Colors.green,
                splashColor: Colors.white,
                hoverColor: Colors.white,
                onTap: () {},
                child: Text('View all'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                    )))
          ],
        ),
        const SizedBox(
          height: 8,
        ),

        // ___________________ Treding Option list ___________________
        for (int i = 0; i < 3; i++) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: ListTile(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              // onTap: () => halfStockView(context),
              contentPadding: const EdgeInsets.only(left: 0.0, right: 10.0),
              leading: const Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Color.fromARGB(180, 239, 220, 247),
                  child: Text(
                    'OPT',
                    style: TextStyle(
                      color: Color.fromARGB(180, 136, 0, 195),
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'NIFTY',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: 'Roboto'),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(190, 238, 234, 234),
                      borderRadius: BorderRadius.circular(
                          4), // Optional: Add border radius
                    ),
                    child: const Text(
                      'NSE FO',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                    ),
                  )
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text(
                  optData[i],
                  style: const TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 95, 95, 95)),
                ),
              ),
              trailing: InkWell(
                focusColor: Colors.white,
                splashColor: Colors.white,
                hoverColor: Colors.white,
                onTap: () {},
                child: Image.asset(
                  'assets/icons/star_add.png',
                  scale: 1.8,
                  color: const Color.fromARGB(140, 0, 0, 0),
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 0.5,
            height: 5,
            color: Color.fromARGB(52, 0, 0, 0),
          ),
        ], // for loop
        const SizedBox(
          height: 40,
        ),

        // _________________ Top User _________________
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'top user'.toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.6,
                  color: Color.fromARGB(149, 0, 0, 0)),
            ),
            InkWell(
                focusColor: Colors.green,
                splashColor: Colors.white,
                hoverColor: Colors.white,
                onTap: () {},
                child: Text('View all'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                    )))
          ],
        ),
        const SizedBox(
          height: 8,
        ),

        // ___________________ Top user list ___________________
        for (int i = 0; i < 3; i++) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: ListTile(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              // onTap: () => halfStockView(context),
              contentPadding: const EdgeInsets.only(left: 0.0, right: 10.0),
              leading: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(userPic[i]),
                ),
              ),
              title: Text(
                users[i],
                style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    fontFamily: 'Roboto'),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text(
                  bio[i],
                  style: const TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 95, 95, 95)),
                ),
              ),
              trailing: InkWell(
                focusColor: Colors.white,
                splashColor: Colors.white,
                hoverColor: Colors.white,
                onTap: () {},
                // child: Image.asset(
                //   'assets/icons/market.png',
                //   scale: 10.5,
                //   color: const Color.fromARGB(140, 0, 0, 0),
                // ),
                child: const Icon(
                  Icons.currency_exchange,
                  color: Color.fromARGB(255, 181, 180, 180),
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 0.5,
            height: 5,
            color: Color.fromARGB(52, 0, 0, 0),
          ),
        ], // for loop
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}

// ****************** Search Content Screen *******************
class searchedContent extends HookConsumerWidget {
  const searchedContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List optData = [
      '01 Feb 2024',
      '01 Feb 2024',
      '01 Feb 2024',
    ];
    return const Column(
      children: [
        // for (int i = 0; i < optData.length; i++) ...[
        //   Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 4),
        //     child: ListView.builder(
        //         itemCount: 0,
        //         itemBuilder: (context, index) {
        //           return ListTile(
        //             hoverColor: Colors.transparent,
        //             splashColor: Colors.transparent,
        //             onTap: () => halfStockView(context),
        //             contentPadding:
        //                 const EdgeInsets.only(left: 0.0, right: 10.0),
        //             leading: const Padding(
        //               padding: EdgeInsets.only(right: 5.0),
        //               child: CircleAvatar(
        //                 radius: 22,
        //                 backgroundColor: Color.fromARGB(180, 247, 220, 220),
        //                 child: Text(
        //                   'FUT',
        //                   style: TextStyle(
        //                     color: Color.fromARGB(255, 215, 82, 82),
        //                     // fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             title: Row(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               crossAxisAlignment: CrossAxisAlignment.end,
        //               children: [
        //                 const Text(
        //                   // stockData.value[index]["name"] ?? "",
        //                   'lkdsjf',
        //                   style: TextStyle(
        //                       color: Color.fromARGB(255, 0, 0, 0),
        //                       fontWeight: FontWeight.w500,
        //                       fontSize: 16.6,
        //                       fontFamily: 'Roboto'),
        //                 ),
        //                 Container(
        //                   margin: const EdgeInsets.symmetric(horizontal: 10),
        //                   padding: const EdgeInsets.symmetric(
        //                       horizontal: 4, vertical: 1),
        //                   decoration: BoxDecoration(
        //                     color: const Color.fromARGB(190, 238, 234, 234),
        //                     borderRadius: BorderRadius.circular(
        //                         4), // Optional: Add border radius
        //                   ),
        //                   child: const Text(
        //                     'NSE FO',
        //                     style: TextStyle(
        //                       fontSize: 10,
        //                       fontWeight: FontWeight.w500,
        //                       color: Color.fromARGB(255, 51, 51, 51),
        //                     ),
        //                   ),
        //                 )
        //               ],
        //             ),
        //             subtitle: Padding(
        //               padding: const EdgeInsets.only(top: 0),
        //               child: Text(
        //                 optData[i],
        //                 style: const TextStyle(
        //                     fontSize: 15.5,
        //                     color: Color.fromARGB(255, 95, 95, 95)),
        //               ),
        //             ),
        //             trailing: InkWell(
        //               focusColor: Colors.white,
        //               splashColor: Colors.white,
        //               hoverColor: Colors.white,
        //               onTap: () {},
        //               child: Image.asset(
        //                 'assets/icons/star_add.png',
        //                 scale: 1.8,
        //                 color: const Color.fromARGB(140, 0, 0, 0),
        //               ),
        //             ),
        //           );
        //         }),
        //   ),
        //   const Divider(
        //     thickness: 0.5,
        //     height: 5,
        //     color: Color.fromARGB(52, 0, 0, 0),
        //   ),
        // ],
      ],
    );
  }
}

// ****************** No Content Found *******************
class NothingFound extends HookConsumerWidget {
  const NothingFound({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 80,
        ),
        Center(
            child: Image.asset(
          'assets/images/stock_not_found.jpg',
          scale: 1.2,
        )),
        const SizedBox(
          height: 20,
        ),
        const Center(
            child:
                Text('No results found. Please try using\n different keywords',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decorationColor: Color.fromARGB(255, 230, 43, 43),
                        decorationStyle: TextDecorationStyle.dotted,
                        // color: Colors.black,
                        // fontWeight: FontWeight.w500,
                        fontSize: 14)))
      ],
    );
  }
}

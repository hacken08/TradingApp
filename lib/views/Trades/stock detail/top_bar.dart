// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/utils/const.dart';
import 'package:trading_app/views/Trades/stock%20detail/derivative.dart';
import 'package:trading_app/views/Trades/stock%20detail/fundamental.dart';
import 'package:trading_app/views/Trades/stock%20detail/overview.dart';
import 'package:trading_app/views/Trades/stock%20detail/technical.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class StockDetail extends HookConsumerWidget {
  final profile;
  final queto;
  const StockDetail({super.key, required this.profile, required this.queto});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<Map<String, dynamic>> wsResponse =
        useState<Map<String, dynamic>>({});

    useEffect(() {
      WebSocketChannel channel = connectWebSocket(profile['symbol']);
      channel.stream.listen((message) {
        final Map<String, dynamic> response = json.decode(message);
        wsResponse.value = response;
      }, onError: (error) {});

      return null;
    }, []);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 242, 236, 252),

        // _____________________ Buy & Sell _____________________
        bottomSheet: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: Colors.white,
          // color: Colors.black,
          width: double.maxFinite,
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // .......... Buy Button ..........
              Expanded(
                child: FloatingActionButton(
                  highlightElevation: 0,
                  elevation: 0,
                  hoverElevation: 0,
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  onPressed: () {},
                  child: Container(
                    // width: size.width / 2 - 20,s
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 0, 142, 116)),
                    child: Center(
                        child: Text('Buy'.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 14.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w500))),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),

              // .......... sell Button ..........
              Expanded(
                child: FloatingActionButton(
                  elevation: 0,
                  hoverElevation: 0,
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  onPressed: () {},
                  child: Container(
                    // width: size.width / 2 - 20,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 185, 62, 65)),
                    child: Center(
                        child: Text('sell'.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 14.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w500))),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ________________________ AppBar ________________________
        appBar: AppBar(
          toolbarHeight: 70,
          // elevation: 4,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          leading: InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: const Icon(Icons.arrow_back),
            onTap: () {
              // print(channel.sink.close());
              Navigator.of(context).pop();
            },
          ),
          titleSpacing: 1,
          title: Column(
            children: [
              const SizedBox(
                height: 2.5,
              ),
              Row(
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
                    margin: const EdgeInsets.only(left: 5, right: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(245, 237, 238, 240),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      wsResponse.value['exchange'] ?? ' ',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 2.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(wsResponse.value['price'] ?? '',
                      style: const TextStyle(
                          letterSpacing: 1,
                          fontSize: 15,
                          color: Color.fromARGB(255, 27, 141, 101),
                          fontWeight: FontWeight.w500)),
                  const Icon(
                    Icons.arrow_drop_up,
                    color: Color.fromARGB(255, 27, 141, 101),
                  ),
                  const Text('+2.00 (+0.31%})',
                      style: TextStyle(fontSize: 15, letterSpacing: 1)),
                ],
              )
            ],
          ),
          actions: [
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              icon: const Opacity(
                opacity: 0.6,
                child: Icon(
                  Icons.alarm_add,
                  color: Color.fromARGB(177, 0, 0, 0),
                ),
              ),
              onPressed: () {},
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onPressed: () {},
              visualDensity: VisualDensity.compact,
              icon: Image.asset(
                'assets/icons/star_add.png',
                scale: 1.8,
                color: const Color.fromARGB(140, 0, 0, 0),
              ),
            ),
            const SizedBox(width: 10)
          ],
          // elevation: 2.5,
          bottom: const TabBar(
            dividerColor: Color.fromARGB(38, 0, 0, 0),
            mouseCursor: SystemMouseCursors.click,
            tabAlignment: TabAlignment.start,
            // onHover: (value) {},
            isScrollable: true,
            labelStyle: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 92, 104, 181),
                fontWeight: FontWeight.w700),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            labelPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            indicatorPadding: EdgeInsets.only(bottom: 6),
            indicatorColor: Color.fromARGB(255, 69, 94, 204),
            tabs: [
              Tab(
                text: 'Overview',
              ),
              Tab(
                text: 'Technical',
              ),
              Tab(
                text: 'Derivatives',
              ),
              Tab(
                text: 'Fundamental',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Overview(quote: queto, profile: profile, wsRes: wsResponse),
            const Derivatives(),
            const Technical(),
            const Fundamental()
          ],
        ),
      ),
    );
  }
}

WebSocketChannel connectWebSocket(symbol) {
  // ______ Websocket connection _______
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://ws.twelvedata.com/v1/quotes/price?apikey=$apikey'),
  );
  Map<String, dynamic> subReq = {
    "action": "subscribe",
    "params": {"symbols": "$symbol"}
  };
  channel.sink.add(json.encode(subReq));

  return channel;
}

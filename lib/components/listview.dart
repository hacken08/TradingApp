// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:trading_app/states/userstate.dart';
import 'package:trading_app/themes/colors.dart';
import 'package:trading_app/utils/utilsmethod.dart';

class ReusableListView extends HookConsumerWidget {
  final IconData icon;
  final String label;
  final String info;
  final void Function() onTap;
  const ReusableListView({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
    required this.info,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: const EdgeInsets.only(right: 0),
      // minLeadingWidth: 10,
      tileColor: Colors.white,
      title: Text(
        label,
        style: const TextStyle(
            fontSize: 14.5,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(212, 12, 12, 12)),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3.0),
        child: Text(
          info,
          style: const TextStyle(
              fontSize: 14.3,
              overflow: TextOverflow.visible,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(177, 0, 0, 0)),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(top: 20.0, right: 12, left: 5),
        child: Icon(
          icon,
          size: 22,
          color: const Color.fromARGB(186, 0, 0, 0),
        ),
      ),
      trailing: InkWell(
        onTap: () => context.go("/editprofile"),
        child: Image.asset(
          'assets/icons/edit.png',
          scale: 2.5,
          color: const Color.fromARGB(255, 172, 172, 172),
        ),
      ),
    );
  }
}

class ReusableListViewBank extends StatelessWidget {
  final String label;
  final String info;
  final void Function() onTap;
  final String image;
  final double imageSize;
  final double buttonPadding;
  final double buttonValue;
  const ReusableListViewBank({
    super.key,
    required this.onTap,
    required this.image,
    required this.buttonValue,
    required this.label,
    required this.imageSize,
    required this.buttonPadding,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image.asset(image, scale: imageSize),
            ),
            const SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Text(
                    info,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
            ),
            const Spacer(),
            Radio(
              fillColor: const MaterialStatePropertyAll(Colors.green),
              visualDensity: const VisualDensity(),
              activeColor: Colors.blueAccent,
              value: buttonValue,
              groupValue: 0,
              onChanged: (check) {},
            )
          ],
        ),
      ],
    );
  }
}

class StockList extends StatelessWidget {
  final String companyName;
  final String symbol;
  final String currency;
  final String country;
  final String exchange;

  const StockList({
    super.key,
    required this.companyName,
    required this.symbol,
    required this.currency,
    required this.country,
    required this.exchange,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      width: width * 0.9,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.55), width: 0.4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: const Color.fromARGB(180, 239, 220, 247),
              child: Text(
                symbol.substring(0, 1),
                style: const TextStyle(
                  color: Color.fromARGB(180, 136, 0, 195),
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                longtext(companyName, 30),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Text(
                    symbol,
                    style: TextStyle(
                      fontSize: 14,
                      color: blackColor.withOpacity(0.75),
                    ),
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
                    child: Text(
                      exchange,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                country.toString(),
                style: TextStyle(fontSize: 16, color: blackColor),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                currency.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: blackColor.withOpacity(0.75),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class StockPosition extends HookConsumerWidget {
  final String name;
  final String price;

  const StockPosition({
    super.key,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0.8,
      child: Container(
        height: 140,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: const BoxDecoration(color: Colors.white),
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Row(
                      children: [
                        Text(
                          'Buy',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.green,
                              backgroundColor:
                                  Color.fromARGB(255, 247, 247, 247)),
                        ),
                        SizedBox(width: 7),
                        Text(
                          'DELIVERY',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey,
                              backgroundColor:
                                  Color.fromARGB(255, 247, 247, 247)),
                        ),
                        SizedBox(width: 7),
                        Text(
                          'Buy',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey,
                              backgroundColor:
                                  Color.fromARGB(255, 247, 247, 247)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.only(right: 54.0),
                    child: Text(
                      '1 Share',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  children: [
                    const Text('-0.10',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(price,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 1, 121, 111),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Aug.251.80  ',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Contactlist extends HookConsumerWidget {
  final String name;
  final String status;
  final String time;
  final String path;
  final int id;
  const Contactlist({
    super.key,
    required this.name,
    required this.time,
    required this.status,
    required this.path,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(right: 10),
          onTap: () {
            context.go("/contact/chat/$id");
          },
          focusColor: Colors.white,
          hoverColor: Colors.white,
          splashColor: Colors.white,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
              width: 35,
              height: 35,
              child: CachedNetworkImage(
                imageUrl: path,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/user.png",
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            name,
            textScaler: const TextScaler.linear(1),
            style: const TextStyle(
              fontSize: 19,
              // fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text(
            status,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          dense: false,
          trailing: Text(
            time,
            style: const TextStyle(color: Colors.grey),
          ),
          horizontalTitleGap: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          child: Divider(thickness: 0.6),
        ),
      ],
    );
  }
}

class UserListView extends HookConsumerWidget {
  final String name;
  final String profilesPic;
  final void Function() onTapForward;

  const UserListView({
    super.key,
    required this.profilesPic,
    required this.onTapForward,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<Map<String, dynamic>> userdata =
        useState<Map<String, dynamic>>({});
    return Container(
      width: 185,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          image(),
          nameOfperson(),
          bio(userdata),
          const SizedBox(
            height: 9,
          ),
          goToprofile(),
        ],
      ),
    );
  }

  Padding bio(ValueNotifier<Map<String, dynamic>> userdata) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        userdata.value["bio"] ?? "Bio",
        style: const TextStyle(fontSize: 17, color: Colors.black),
      ),
    );
  }

  Text nameOfperson() {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  ClipRRect image() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: CachedNetworkImage(
        height: 68,
        width: 68,
        imageUrl: profilesPic,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => Image.asset(
          "assets/images/user.png",
          fit: BoxFit.cover,
        ),
        fit: BoxFit.cover,
      ),
    );
  }

  InkWell goToprofile() {
    return InkWell(
      onTap: onTapForward,
      child: Container(
        height: 54,
        width: 94,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 36, 2, 95),
            borderRadius: BorderRadius.circular(15)),
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }
}

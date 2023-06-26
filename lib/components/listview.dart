// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

class ReusableListView extends StatelessWidget {
  final IconData icon;
  final String label;
  final String info;
  final double labelPadding;
  final double leftPadding;
  final double iconPadding;
  final void Function() onTap;
  const ReusableListView({
    super.key,
    required this.onTap,
    required this.leftPadding,
    required this.icon,
    required this.label,
    required this.labelPadding,
    required this.iconPadding,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 52),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 13, color: Color.fromARGB(255, 143, 143, 143)),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              info,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Spacer(),
            IconButton(
              onPressed: onTap,
              icon: Icon(
                Icons.mode_edit_outlined,
                size: 26,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
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
            SizedBox(
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
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Text(
                    info,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
            ),
            Spacer(),
            Radio(
              fillColor: MaterialStatePropertyAll(Colors.green),
              visualDensity: VisualDensity(),
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
  final String stockName;
  final String StockPrice;
  final Color PriceColor;

  const StockList({
    super.key,
    required this.stockName,
    required this.StockPrice,
    required this.PriceColor,
    });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListTile(
            focusColor: Colors.white,
            hoverColor: Colors.white,
            splashColor: Colors.white,
            onTap: () {},
            title: Text(
              stockName,
              style: TextStyle(
                fontSize: 17,
                // fontWeight: FontWeight.w500
              ),
            ),
            subtitle: Text(
              "NSE",
              style: TextStyle(fontSize: 13),
            ),
            dense: true,
            iconColor: Colors.blueGrey,
            trailing: Text(
              StockPrice,
              style: TextStyle(color: PriceColor),
            ),
          ),
        ),
      ),
    );
  }
}

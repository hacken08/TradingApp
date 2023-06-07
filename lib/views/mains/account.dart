// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/components/List%20View.dart';

class AccountPage extends HookConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      top: true,
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 236, 243, 249),
          body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // -------- Profile ------------

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/images/smpl.png'),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Yor Forger',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 22,
                              letterSpacing: 2),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'CLIENT ID - R6412343',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              letterSpacing: 2),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  // ---------------- DP ID ----------------
                  Card(
                    elevation: 3,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Dp ID (DEpository Participant)',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 138, 138, 138)),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.mode_edit_outline_outlined,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('1203 3200 3015 2500'),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.copy),
                              color: Colors.blue,
                              onPressed: () {},
                            )
                          ],
                        )
                      ]),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  // --------- personal Detail -------
                  Column(
                    children: [
                      Card(
                        elevation: 3,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Personal Details',
                                style: TextStyle(
                                  fontSize: 19,
                                  // fontWeight: FontWeight.w400
                                ),
                              ),
                              Divider(),
                              SizedBox(height: 20),
                              ReusableListView(
                                icon: Icons.phone_outlined,
                                label: "Mobile Number",
                                info: "+91 7009524322",
                                iconPadding: 125,
                                labelPadding: 135,
                                onTap: () {},
                              ),
                              SizedBox(height: 16),
                              ReusableListView(
                                icon: Icons.mail_outline_outlined,
                                label: "Email",
                                info: "kenkani0408@gmail.com",
                                iconPadding: 65,
                                labelPadding: 195,
                                onTap: () {},
                              ),
                              SizedBox(height: 16),
                              ReusableListView(
                                icon: Icons.pin_drop_outlined,
                                label: "Address",
                                info: "Punjab, chandigargh",
                                iconPadding: 100,
                                labelPadding: 180,
                                onTap: () {},
                              ),
                              SizedBox(height: 16),
                              ReusableListView(
                                icon: Icons.payment,
                                label: "PAN Number",
                                info: "ITSPK2773R",
                                iconPadding: 155,
                                labelPadding: 150,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      // -------------- Bank Detail -------------
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bank Details',
                              style: TextStyle(
                                fontSize: 19,
                              ),
                            ),
                            Divider(),
                            SizedBox(height: 20),
                            ReusableListViewBank(
                              image: 'assets/images/bnk_smpl.png',
                              label: "KOTAK MAHIDRA BANK",
                              info: "******7095",
                              onTap: () {},
                              buttonValue: 1,
                              imageSize: 35.1,
                              buttonPadding: 30,
                            ),
                            SizedBox(height: 5),
                            ReusableListViewBank(
                              buttonValue: 0,
                              imageSize: 48.1,
                              buttonPadding: 196,
                              image: 'assets/images/SBI-logo.svg.png',
                              label: "SBI",
                              info: "******3495",
                              onTap: () {},
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 34, right: 25),
                                  child: Container(
                                      width: 60,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blueAccent),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.blue,
                                          ))),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'ADD BANK ACCOUNT',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ]),
          )),
    );
  }
}

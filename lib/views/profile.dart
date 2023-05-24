// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:trading_app/components/List%20View.dart';
import 'package:dashed_rect/dashed_rect.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        top: true,
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 236, 243, 249),
            body: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 25,
                ),

                // ------------- App Bar -------------
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_back_ios),
                      splashRadius: 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text("Profile",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),

                SizedBox(
                  height: 50,
                ),

                // -------- Profile ------------
                Stack(children: [
                  PhysicalModel(
                    color: Color.fromARGB(255, 236, 243, 249),
                    elevation: 3,
                    child: Container(
                      width: 399,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.3),
                            topRight: Radius.circular(25.3)),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 103.9),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/images/smpl.png'),
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(left: 103.9),
                        child: Text('Yor Forger',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 22,
                                letterSpacing: 2)),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: EdgeInsets.only(left: 103.9),
                        child: Text(
                          'CLIENT ID - R6412343',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              letterSpacing: 2),
                        ),
                      ),
                    ],
                  )
                ]),

                SizedBox(height: 10),

                // ---------------- DP ID ----------------
                Material(
                  color: Color.fromARGB(255, 236, 243, 249),
                  elevation: 3,
                  child: Container(
                    width: 399,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: Image.asset('assets/images/verfiy.png',
                                  scale: 6),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: Text(
                                'Dp ID (DEpository Participant)',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 138, 138, 138)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.mode_edit_outline_outlined,
                                    color: Colors.grey,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 40,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 40),
                              child: Text('1203 3200 3015 2500'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: IconButton(
                                icon: Icon(Icons.copy),
                                color: Colors.blue,
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
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
                        width: 398,
                        height: 420,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 28, right: 215),
                              child: Text(
                                'Personal Details',
                                style: TextStyle(
                                  fontSize: 19,
                                  // fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
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

                    // -------------- Bank Detail -------------
                    Card(
                      elevation: 3,
                      child: Container(
                        width: 398,
                        height: 350,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 28, right: 237),
                              child: Text(
                                'Bank Details',
                                style: TextStyle(
                                  fontSize: 19,
                                  // fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
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
                                  padding: const EdgeInsets.only(left: 34, right: 25),
                                  child: Container(
                                      width: 60,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blueAccent),
                                              borderRadius: BorderRadius.circular(10)
                                              
                                          ),
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.blue,
                                          ))),
                                ),
                                TextButton(onPressed: () {},
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
                    ),
                  ],
                )
              ]),
            )),
      ),
    );
  }
}

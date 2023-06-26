// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/listview.dart';

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
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Container(
                        width: 400,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage('assets/images/smpl.png'),
                              ),
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
                        )),
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
                        
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(40),
                          ),
                      ),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, top: 20),
                              child: Image.asset('assets/images/verfiy.png', scale: 7),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                'Dp ID (DEpository Participant)',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 138, 138, 138)),
                              ),
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
                            Spacer(),
                            SizedBox(width: 10,),
                            Padding(
                              padding:
                                  const EdgeInsets.only( bottom: 30, left: 14),
                              child: Text('1203 3200 3015 2500'),
                            ), Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 50.0,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.copy),
                                color: Colors.blue,
                                onPressed: () {},
                              ),
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
                              color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                              
                              ),
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
                                leftPadding: 20,
                                icon: Icons.phone_outlined,
                                label: "Mobile Number",
                                info: "+91 7009524322",
                                iconPadding: 125,
                                labelPadding: 135,
                                onTap: () {},
                              ),
                              SizedBox(height: 16),
                              ReusableListView(
                                leftPadding: 20,
                                icon: Icons.mail_outline_outlined,
                                label: "Email",
                                info: "kenkani0408@gmail.com",
                                iconPadding: 65,
                                labelPadding: 195,
                                onTap: () {},
                              ),
                              SizedBox(height: 16),
                              ReusableListView(
                                leftPadding: 20,
                                icon: Icons.pin_drop_outlined,
                                label: "Address",
                                info: "Punjab, chandigargh",
                                iconPadding: 100,
                                labelPadding: 180,
                                onTap: () {},
                              ),
                              SizedBox(height: 16),
                              ReusableListView(
                                leftPadding: 20,
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Container(
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
                              SizedBox(height: 18),
                              ReusableListViewBank(
                                buttonValue: 0,
                                imageSize: 48.1,
                                buttonPadding: 196,
                                image: 'assets/images/SBI-logo.svg.png',
                                label: "SBI",
                                info: "******3495",
                                onTap: () {},
                              ),
                              SizedBox(height: 25),
                              ListTile(
                                onTap: () => print("Back Account Added"),
                                leading: Container(
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
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 13.0),
                                  child: Text(
                                    "Add Account",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue,
                                      // fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                dense: true,
                                iconColor: Colors.blueGrey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
          )),
    );
  }
}

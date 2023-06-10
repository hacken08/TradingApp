// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names


import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/buttons/switch_button.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 244, 255),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(
            // top: 39,s
          ),
          children: [
            // Container Desig..........
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Card(
                shadowColor: Colors.black,
                elevation: 4,
                child: Container(
                    height: 220,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.3),
                            topRight: Radius.circular(20.3))),
                    
                        // --------------- Security Settings list ------------
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 175, top: 30),
                          child: Text("Security Settings",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500)),
                        ),
                    
                    // 1. Change PIN...........
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 14),
                          child: ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Image.asset(
                                'assets/icons/Lock.png',
                                width: 28,
                                height: 28,
                              ),
                            ),
                            title: Text(
                              'Change PIN',
                              style: TextStyle(fontSize: 19),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Color.fromARGB(255, 158, 156, 156),
                              size: 20,
                            ),
                          ),
                        ),
                    
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Divider(
                            thickness: 0.9,
                          ),
                        ),
                    
                        //  1. Face ID...........
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 14),
                          child: ListTile(
                              leading: Image.asset(
                                'assets/icons/Face_ID.png',
                                width: 28,
                                height: 28,
                              ),
                              title: Text(
                                'Face ID',
                                style: TextStyle(fontSize: 19),
                              ),
                              trailing: ReCustomWitchButton(),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
        
            SizedBox(height: 7),
        
            // ------------------- User Preference -----------------
            Card(
              shadowColor: Colors.black,
              elevation: 4,
              child: Container(
                  height: 430,
                  // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.3),
                          topRight: Radius.circular(20.3))),
        
                  // Setting Design...
                  child: Column(
                    children: [
                       Padding(
                        padding: const EdgeInsets.only(right: 180, top: 30),
                        child: Text("User Preference",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500)),
                      ),
        
                    // 3. App Theme..........
                     Padding(
                        padding: const EdgeInsets.only(left: 15, top: 14),
                        child: ListTile(subtitle: Text("Light Mode"),
                          leading: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Image.asset(
                              'assets/icons/theme.png',
                              width: 28,
                              height: 24,
                            ),
                          ),
                          title: Text(
                            'App Theme',
                            style: TextStyle(fontSize: 19),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 158, 156, 156),
                            size: 20,
                          ),
                        ),
                      ),
        
                    // 4. Investment Guide............
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 14),
                        child: ListTile(
                            leading: Image.asset(
                              'assets/icons/guide.png',
                              width: 28,
                              height: 28,
                            ),
                            title: Text(
                              'Investment GUide',
                              style: TextStyle(fontSize: 19),
                            ),
                            trailing: ReCustomWitchButton(),
                        ),
                      ),
        
                      // 5. Market Indices.............
                       Padding(
                        padding: const EdgeInsets.only(left: 15, top: 14),
                        child: ListTile(
                            leading: Image.asset(
                              'assets/icons/market.png',
                              width: 28,
                              height: 28,
                            ),
                            title: Text(
                              'Market Indices',
                              style: TextStyle(fontSize: 19),
                            ),
                            trailing: ReCustomWitchButton(),
                        ),
                      ),
                      SizedBox(height: 13,),

                      // INDiCES..........
                      Row(
                        children: [SizedBox(width: 60),
                          Container(
                            height: 30,
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6, left: 50),
                              child: Text("NIFTY",
                              style: TextStyle(),
                              ),
                            ),
                          ),

                          SizedBox(width: 10,),

                           Container(
                            height: 30,
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6, left: 40),
                              child: Text("SENSEX",
                              style: TextStyle(),
                              ),
                            ),
                          )
                        ],
                      ),

                      SizedBox(height: 10,),

                       Row(
                        children: [SizedBox(width: 60),
                          Container(
                            height: 30,
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6, left: 33),
                              child: Text("BANKNIFTY",
                              style: TextStyle(),
                              ),
                            ),
                          ),

                          SizedBox(width: 10,),

                           Container(
                            height: 30,
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6, left: 38),
                              child: Text("FINNIFTY",
                              style: TextStyle(),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 40, top: 7),
                        child: Text("Select any two market indices"),
                      )
                    ],
                  ),
              ),
            ),

            // ---------- Manage Notification --------------------
             Padding(
               padding: const EdgeInsets.only(bottom: 50.3),
               child: Card(
                shadowColor: Colors.black,
                elevation: 4,
                child: Container(
                    height: 330,
                    // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.3),
                            topRight: Radius.circular(20.3))),
                     
                    // Setting Design...
                    child: Column(
                      children: [
                         Padding(
                          padding: const EdgeInsets.only(right: 130, top: 30),
                          child: Text("Manage Notification",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500)),
                        ),
                          
             
                      // 3. Order..........
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 14),
                          child: ListTile(
                              leading: Image.asset(
                                'assets/icons/order.png',
                                width: 28,
                                height: 28,
                              ),
                              title: Text(
                                'order',
                                style: TextStyle(fontSize: 19),
                              ),
                              trailing: ReCustomWitchButton(),
                          ),
                        ),
             
                         Padding(
                          padding: const EdgeInsets.only(left: 70, right: 30),
                          child: Divider(
                            thickness: 0.9,
                          ),
                        ),
                     
                      // 4. Promotional............
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 14),
                          child: ListTile(
                              leading: Image.asset(
                                'assets/icons/promotional.png',
                                width: 28,
                                height: 28,
                              ),
                              title: Text(
                                'Promotional',
                                style: TextStyle(fontSize: 19),
                              ),
                              trailing: ReCustomWitchButton(),
                          ),
                        ),
             
                         Padding(
                          padding: const EdgeInsets.only(left: 70, right: 30),
                          child: Divider(
                            thickness: 0.9,
                          ),
                        ),
                     
                        // 5. Market Indices.............
                         Padding(
                          padding: const EdgeInsets.only(left: 15, top: 14),
                          child: ListTile(
                              leading: Image.asset(
                                'assets/icons/advisory.png',
                                width: 28,
                                height: 28,
                              ),
                              title: Text(
                                'Advisory',
                                style: TextStyle(fontSize: 19),
                              ),
                              trailing: ReCustomWitchButton(),
                          ),
                        ),
                        SizedBox(height: 13), 
             
                      ],
                    ),
                ), 
                         ),
             )
          ],
        ),
      ),
    );
  }
}

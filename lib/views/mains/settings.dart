import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/themes/colors.dart';

import '../../components/buttons/switch_button.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: InkWell(
          onTap: () => context.push('/home'),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: appBackgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 14),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Image.asset(
                    'assets/icons/lock.png',
                    width: 28,
                    height: 28,
                  ),
                ),
                title: const Text(
                  'Change PIN ',
                  style: TextStyle(fontSize: 19),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromARGB(255, 158, 156, 156),
                  size: 20,
                ),
              ),
            ),

            // ------------------- User Preference -----------------
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 30),
                  child: Text("User Preference",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                ),

                // 3. App Theme..........
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 14),
                  child: ListTile(
                    subtitle: const Text("Light Mode"),
                    leading: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Image.asset(
                        'assets/icons/theme.png',
                        width: 28,
                        height: 24,
                      ),
                    ),
                    title: const Text(
                      'App Theme',
                      style: TextStyle(fontSize: 19),
                    ),
                    trailing: const Icon(
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
                    title: const Text(
                      'Investment GUide',
                      style: TextStyle(fontSize: 19),
                    ),
                    trailing: const ReCustomWitchButton(),
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
                    title: const Text(
                      'Market Indices',
                      style: TextStyle(fontSize: 19),
                    ),
                    trailing: const ReCustomWitchButton(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // INDiCES..........
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: const Center(
                            child: Text(
                              "NIFTY",
                              style: TextStyle(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: const Center(
                            child: Text(
                              "NIFTY",
                              style: TextStyle(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: const Center(
                            child: Text(
                              "NIFTY",
                              style: TextStyle(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: const Center(
                            child: Text(
                              "NIFTY",
                              style: TextStyle(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 10),
                  child: Text("Select any two market indices"),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            // -------------------- Manage Notification --------------------
            Padding(
              padding: const EdgeInsets.only(bottom: 50.3),
              child: Card(
                shadowColor: Colors.black,
                elevation: 2,
                child: Container(
                  height: 330,
                  // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.3),
                          topRight: Radius.circular(20.3))),

                  // Setting Design...
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 30),
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
                          title: const Text(
                            'order',
                            style: TextStyle(fontSize: 19),
                          ),
                          trailing: const ReCustomWitchButton(),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 70, right: 30),
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
                          title: const Text(
                            'Promotional',
                            style: TextStyle(fontSize: 19),
                          ),
                          trailing: const ReCustomWitchButton(),
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(left: 70, right: 30),
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
                          title: const Text(
                            'Advisory',
                            style: TextStyle(fontSize: 19),
                          ),
                          trailing: const ReCustomWitchButton(),
                        ),
                      ),
                      const SizedBox(height: 13),
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

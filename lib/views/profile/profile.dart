// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/states/userstate.dart';
import 'package:trading_app/utils/alerts.dart';

import '../../components/listview.dart';
import '../../services/api.dart';

class AccountPage extends HookConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    const containerColors = Color.fromARGB(255, 255, 255, 255);

    ValueNotifier<bool> isLoading = useState<bool>(true);
    final userStateW = ref.watch(userState);
    ValueNotifier<int> userid = useState(0);
    ValueNotifier<Map<String, dynamic>> userdata =
        useState<Map<String, dynamic>>({});

    Future<void> init() async {
      userid.value = await userStateW.getUserData(UserData.id, context);

      final data = await apiCall(
        query:
            "query getUserById(\$id:Int!){getUserById (id:\$id){ id, role, name, bio, username, email, profile, number, address}} ",
        variables: {"id": userid.value},
        headers: {"content-type": "*/*"},
      );
      userdata.value = data.data["getUserById"];
      isLoading.value = false;
    }

    useEffect(() {
      init();
      return null;
    }, []);

    const List optName = ['Subscription Plans', 'Settings', 'Contact Us'];
    const List optIcon = [
      'assets/icons/subs.png',
      'assets/icons/settings.png',
      'assets/icons/email_2.png'
    ];
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 245, 250),
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: const Color.fromARGB(255, 244, 245, 250),
          scrolledUnderElevation: 0,
          elevation: 0,
          title: const Padding(
            padding: EdgeInsets.only(top: 28.0),
            child: Text(
              'Profile',
              style: TextStyle(
                fontSize: 21,
                letterSpacing: -0.3,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 28.0, right: 10),
              child: InkWell(
                onTap: () => {context.go("/contact")},
                child: Container(
                  height: 41,
                  width: 41,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 0.5,
                          blurRadius: 3.5,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(25)),
                  child: Image.asset(
                    'assets/icons/msg.png',
                    color: const Color.fromARGB(185, 0, 0, 0),
                    scale: 1.4,
                    opacity: const AlwaysStoppedAnimation(.8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: InkWell(
                onTap: () => context.go("/editprofile"),
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 39,
                  width: 40,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 0.5,
                          blurRadius: 3.5,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  // child: const Icon(
                  //   Icons.mode_edit_sharp,
                  //   size: 19,
                  //   color: Color.fromARGB(145, 0, 0, 0),
                  // ),
                  child: Image.asset(
                    'assets/icons/sqr_edit.png',
                    scale: 3,
                    color: const Color.fromARGB(200, 0, 0, 0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
        body: isLoading.value
            ? SizedBox(
                width: size.width,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scrollbar(
                thumbVisibility: false,
                trackVisibility: false,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ______________ Top Nav Bar ____________
                      const SizedBox(height: 30),
                      // _________________ Profile, name and bio __________________
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: size.width,
                            padding: const EdgeInsets.only(bottom: 19),
                            margin: const EdgeInsets.only(bottom: 7),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                              color: containerColors,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1.6,
                                  blurRadius: 0.1,
                                  offset: const Offset(-2, 0),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 50),
                                Text(
                                  userdata.value["name"] ??
                                      userdata.value["username"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22,
                                      letterSpacing: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: 250,
                                  child: Center(
                                    child: Text(
                                      userdata.value["bio"] ?? '',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(183, 0, 0, 0),
                                          fontSize: 17,
                                          letterSpacing: -0.2,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: -30,
                            left: size.width / 2 - 35.2,
                            child: Container(
                              height: 80,
                              width: 75,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl: userdata.value["profile"] ?? "",
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    "assets/images/user.png",
                                    fit: BoxFit.cover,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // _________________ Trading Balance __________________
                      Container(
                        width: size.width,
                        // height: 300,
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        padding: const EdgeInsets.all(17),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: containerColors,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0.5,
                              blurRadius: 0.1,
                              offset: const Offset(1, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Trading Balance',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Color.fromARGB(176, 41, 41, 41)),
                            ),
                            const SizedBox(height: 5),
                            InkWell(
                              onTap: () =>
                                  context.go("/wallet/${userdata.value['id']}"),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹ 0.00',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 13),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Expanded(
                                //   child: InkWell(
                                //     onTap: () {},
                                //     child: Container(
                                //       height: 50,
                                //       // width: 130,
                                //       decoration: BoxDecoration(
                                //           borderRadius:
                                //               BorderRadius.circular(5),
                                //           border: Border.all(
                                //               color: const Color.fromARGB(
                                //                   255, 98, 3, 207),
                                //               width: 1.2,
                                //               strokeAlign: BorderSide
                                //                   .strokeAlignInside)),
                                //       child: const Center(
                                //           child: Text(
                                //         'WIDHRAW',
                                //         style: TextStyle(
                                //             fontSize: 13,
                                //             color:
                                //                 Color.fromARGB(255, 98, 3, 207),
                                //             fontWeight: FontWeight.w600),
                                //       )),
                                //     ),
                                //   ),
                                // ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 50,
                                      // width: size.width * 0.5,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 98, 3, 207),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 97, 118, 211),
                                              // width: 0.2,
                                              strokeAlign: BorderSide
                                                  .strokeAlignInside)),
                                      child: const Center(
                                          child: Text(
                                        'ADD FUNDS',
                                        style: TextStyle(
                                            fontSize: 13,
                                            // letterSpacing: -1,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      // _________________ Personal Details __________________
                      Container(
                        width: size.width,
                        // height: 290,
                        margin: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 1),
                        padding: const EdgeInsets.all(17),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0.5,
                              blurRadius: 0.1,
                              offset: const Offset(1, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Personal Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.5,
                                  color: Color.fromARGB(176, 41, 41, 41)),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ReusableListView(
                              icon: Icons.phone_outlined,
                              label: "Mobile Number",
                              info:
                                  "+91 ${userdata.value["number"] ?? "No mobile number provided"}",
                              onTap: () {},
                            ),
                            const SizedBox(height: 18),
                            ReusableListView(
                              icon: Icons.mail_outline_outlined,
                              label: "Email",
                              info: userdata.value["email"] ?? "",
                              onTap: () {},
                            ),
                            const SizedBox(height: 18),
                            ReusableListView(
                              icon: Icons.pin_drop_outlined,
                              label: "Address",
                              info: userdata.value["address"] ??
                                  "No address provided",
                              onTap: () {},
                            ),
                            const SizedBox(height: 15)
                          ],
                        ),
                      ),

                      // ___________________ Setting, Subscription plan, Contact us ___________________
                      Container(
                        width: size.width,
                        // height: 290,
                        margin: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 7),
                        padding:
                            const EdgeInsets.only(top: 7, left: 17, right: 17),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: containerColors,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0.5,
                              blurRadius: 0.1,
                              offset: const Offset(1, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (int i = 0; i < 3; i++) ...[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  onTap: () {
                                    context.go("/settings");
                                  },
                                  minLeadingWidth: 30,
                                  leading: Image.asset(
                                    optIcon[i],
                                    scale: 1.23,
                                    color:
                                        const Color.fromARGB(255, 28, 15, 179),
                                  ),
                                  title: Text(
                                    optName[i],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(184, 0, 0, 0),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 16,
                                    color: Color.fromARGB(255, 172, 172, 172),
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 0.5,
                                height: 0,
                                color: Color.fromARGB(52, 0, 0, 0),
                              ),
                            ]
                          ],
                        ),
                      ),

                      // ___________________ Logout, Switch ___________________
                      Container(
                        width: size.width,
                        // height: 100,
                        margin: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 0),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: containerColors,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0.5,
                              blurRadius: 0.1,
                              offset: const Offset(1, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // .....Switch Account.....
                            // ListTile(
                            //   contentPadding:
                            //       const EdgeInsets.symmetric(horizontal: 22),
                            //   onTap: () => exitAlert(context),
                            //   title: const Padding(
                            //     padding: EdgeInsets.only(left: 8.0),
                            //     child: Text(
                            //       'SWITCH ACCOUNT',
                            //       style: TextStyle(
                            //           fontSize: 14.2,
                            //           color: Colors.black,
                            //           fontWeight: FontWeight.w500),
                            //     ),
                            //   ),
                            //   trailing: Padding(
                            //     padding: const EdgeInsets.only(right: 8.0),
                            //     child: Image.asset(
                            //       'assets/icons/switch_accnt.png',
                            //       // color: const Color.fromARGB(154, 0, 0, 0),
                            //       scale: 1.2,
                            //     ),
                            //   ),
                            // ),
                            // const Padding(
                            //   padding: EdgeInsets.symmetric(vertical: 5.0),
                            //   child: Divider(
                            //     thickness: 0.5,
                            //     height: 0,
                            //     endIndent: 15,
                            //     indent: 15,
                            //     color: Color.fromARGB(52, 0, 0, 0),
                            //   ),
                            // ),

                            // .....LOGOUT.....
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              onTap: () => logoutAlert(context, ref),
                              title: const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'LOGOUT',
                                  style: TextStyle(
                                      fontSize: 14.2,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Image.asset(
                                  'assets/icons/swtich_off.png',
                                  scale: 1.4,
                                  // color: const Color.fromARGB(154, 0, 0, 0)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 50)

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: InkWell(
                      //           onTap: () {
                      //             exitAlert(context);
                      //           },
                      //           child: Container(
                      //             // width: 100,
                      //             height: 35,
                      //             decoration: BoxDecoration(
                      //                 color: roseColor,
                      //                 borderRadius: BorderRadius.circular(49)),
                      //             child: const Center(
                      //               child: Text(
                      //                 "Exit",
                      //                 style: TextStyle(
                      //                     fontSize: 17,
                      //                     fontWeight: FontWeight.bold,
                      //                     color: Colors.white),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         width: 20,
                      //       ),
                      //       Expanded(
                      //         child: InkWell(
                      //           onTap: () {
                      //             logoutAlert(context, ref);
                      //           },
                      //           child: Container(
                      //             // width: 100,
                      //             height: 35,
                      //             decoration: BoxDecoration(
                      //                 color: indigoColor,
                      //                 borderRadius: BorderRadius.circular(49)),
                      //             child: const Center(
                      //               child: Text(
                      //                 "Logout",
                      //                 style: TextStyle(
                      //                     fontSize: 17,
                      //                     fontWeight: FontWeight.bold,
                      //                     color: Colors.white),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

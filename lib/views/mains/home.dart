// ignore_for_file: use_build_context_synchronously, deprecated_member_use, unused_local_variable

import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/components/drawer.dart';
import 'package:trading_app/components/listview.dart';
import 'package:trading_app/states/mainstate.dart';
import 'package:trading_app/states/userstate.dart';
import 'package:trading_app/themes/colors.dart';

import '../../services/api.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    Color secondaryColor = const Color.fromARGB(255, 36, 2, 95);

    final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

    ValueNotifier<bool> isLoading = useState<bool>(true);
    final userStateW = ref.watch(userState);
    ValueNotifier<int> userid = useState(0);
    ValueNotifier<String> username = useState<String>("");
    ValueNotifier<String?> userimg = useState<String?>(null);
    ValueNotifier<String?> token = useState<String?>(null);
    ValueNotifier<String?> role = useState<String?>(null);
    ValueNotifier<String?> email = useState<String?>(null);
    ValueNotifier<List<dynamic>> users = useState<List<dynamic>>([]);

    Future<void> init() async {
      userid.value = await userStateW.getUserData(UserData.id, context);
      role.value = await userStateW.getUserData(UserData.role, context);
      token.value = await userStateW.getUserData(UserData.token, context);

      final data = await apiCall(
        query:
            "query getUserById(\$id:Int!){getUserById (id:\$id){ id, role, name, username, email, profile, iscomplete}} ",
        variables: {"id": userid.value},
        headers: {"content-type": "*/*"},
      );
      if (data.data.length == 0) {
        await ref.watch(mainState).setLogin(false);
      }
      username.value = data.data["getUserById"]["username"];
      userimg.value = data.data["getUserById"]["profile"];
      email.value = data.data["getUserById"]["email"];

      final getusers = await apiCall(
        query:
            "query getAllUser{getAllUser{ id, role, name, username, email, profile, iscomplete}} ",
        variables: {"id": userid.value},
        headers: {"content-type": "*/*"},
      );
      log(getusers.toString());
      if (getusers.status) {
        users.value = getusers.data["getAllUser"];
        log(getusers.data.toString());
      }

      isLoading.value = false;

      // if (!data.data["getUserById"]["iscomplete"]) {
      //   if (context.mounted) profileComplated(context);
      // }
    }

    Future<void> intisocket() async {
      io.Socket socket = io.io("http://localhost:3000", <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": false,
        "query": {"username": "karan"}
      });
      socket.connect();
      socket.onConnect((_) {
        log("connected to websocket");
      });
      socket.on('newChat', (message) {
        log(message.toString());
        log("new chat");
      });

      socket.emit("chat", {"test": "test message"});
    }

    useEffect(() {
      init();
      intisocket();
      return null;
    }, []);
    String empty = " ";
    TextEditingController searchText = TextEditingController();
    return Scaffold(
      backgroundColor: appBarColor,
      key: drawerKey,
      drawer: isLoading.value
          ? null
          : CustomDrwer(
              scaffoldkey: drawerKey,
              id: userid.value,
              name: username.value,
              email: email.value!,
              profile: userimg.value ?? "",
            ),
      body: isLoading.value
          ? SizedBox(
              width: size.width,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 35),
                    // ______________TOP________________
                    Container(
                      width: size.width,
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? size.height * 0.1
                          : size.height * 0.2,
                      margin: const EdgeInsets.only(top: 0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      decoration: BoxDecoration(color: appBarColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => drawerKey.currentState!.openDrawer(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                width: 44,
                                height: 44,
                                child: CachedNetworkImage(
                                  imageUrl: userimg.value ?? "",
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
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
                          const SizedBox(
                            width: 9,
                          ),
                          Text(
                            'Hi, ${username.value}',
                            textScaler: const TextScaler.linear(1),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
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
                                      offset: const Offset(
                                          0, 1), // changes position of shadow
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
                          const SizedBox(
                            width: 11,
                          ),
                          InkWell(
                              onTap: () => context.go('/notification'),
                              child: Container(
                                height: 41,
                                width: 41,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.15),
                                        spreadRadius: 0.5,
                                        blurRadius: 3.5,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Image.asset(
                                  'assets/icons/bell.png',
                                  color: const Color.fromARGB(185, 0, 0, 0),
                                  scale: 2.7,
                                  opacity: const AlwaysStoppedAnimation(.9),
                                ),
                              )),
                          const SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ),

                    // ______________ SearchBox _________________
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.maxFinite,
                          // height: 120,
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 5),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0.5,
                                blurRadius: 2,
                                offset: const Offset(2, 1),
                              ),
                            ],
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: searchText,
                              decoration: InputDecoration(
                                  hintText: "Search for stocks",
                                  prefixIcon: Image.asset(
                                    'assets/icons/search.png',
                                    scale: 2.7,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none),
                                  suffix: InkWell(
                                    onTap: () => searchText.text = '',
                                    child: Container(
                                      // width: 34,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: secondaryColor,
                                        borderRadius: BorderRadius.circular(29),
                                      ),
                                      child:
                                          Image.asset('assets/icons/croos.png'),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        // ______________ Heading Text _________________
                        Container(
                          width: double.maxFinite,
                          height: 110,
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0.5,
                                blurRadius: 2,
                                offset: const Offset(2, 1),
                              ),
                            ],
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Start your trade ",
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                " learn trade now !!",
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Color.fromARGB(255, 161, 161, 161),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // _____________________ vertical scrool widget __________________

                        Container(
                          width: double.maxFinite,
                          height: 245,
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0.5,
                                blurRadius: 2,
                                offset: const Offset(2, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  context.go("/visitprofile/${1}");
                                },
                                child: const Text(
                                  "Look for help ",
                                  textScaler: TextScaler.linear(1),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 21,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                        width: 125,
                                        height: 145,
                                        decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.9),
                                              spreadRadius: 1.5,
                                              blurRadius: 5,
                                              offset: const Offset(3,
                                                  6), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: const Row(
                                          children: [
                                            SizedBox(width: 19),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  height: 9,
                                                ),
                                                Icon(
                                                  Icons.home_max_sharp,
                                                  color: Colors.yellow,
                                                  size: 28,
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  "43",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.yellow,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Text(
                                                    "Home",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                )
                                              ],
                                            ),
                                          ],
                                        )),
                                    const SizedBox(
                                      width: 19,
                                    ),

                                    // box2.....
                                    Container(
                                        width: 125,
                                        height: 135,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 0.5,
                                              blurRadius: 5,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: 19),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 12.0),
                                                  child: Icon(
                                                    Icons.map,
                                                    color: Colors.grey,
                                                    size: 31,
                                                  ),
                                                ),
                                                Text(
                                                  "Discover",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                )
                                              ],
                                            ),
                                          ],
                                        )),
                                    const SizedBox(
                                      width: 19,
                                    ),

                                    // Box3............
                                    Container(
                                        width: 125,
                                        height: 135,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 0.5,
                                              blurRadius: 5,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: 19),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 12.0),
                                                  child: Icon(
                                                    Icons.arrow_outward_sharp,
                                                    color: Colors.grey,
                                                    size: 31,
                                                  ),
                                                ),
                                                Text(
                                                  "Stock",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                )
                                              ],
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // _________________________ Find member _________________________
                        Container(
                          width: double.maxFinite,
                          // height: 245,
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0.5,
                                blurRadius: 2,
                                offset: const Offset(2, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Look for traders ",
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 21,
                                  color: Colors.black,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "view all",
                                  style: TextStyle(fontSize: 19),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 29,
                        ),

                        // ignore: sized_box_for_whitespace
                        Container(
                          height: size.height * 0.28,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (int i = 7; i < users.value.length; i++) ...[
                                UserListView(
                                  profilesPic: users.value[i]["profile"] ?? "",
                                  name: users.value[i]["name"] ?? "",
                                  onTapForward: () {
                                    context.push(
                                        "/visitprofile/${users.value[i]["id"]}");
                                  },
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                              ],
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

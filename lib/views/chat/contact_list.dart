import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/components/listview.dart';
import 'package:trading_app/services/api.dart';
import 'package:trading_app/states/userstate.dart';
import 'package:trading_app/themes/colors.dart';

// ignore: camel_case_types
class ChatList extends HookConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    TabController controller =
        useTabController(initialLength: 2, initialIndex: 0);

    ValueNotifier<bool> isLoading = useState<bool>(true);
    final userStateW = ref.watch(userState);
    ValueNotifier<int> currentuserid = useState<int>(0);
    ValueNotifier<List> rooms = useState<List>([]);

    Future<void> init() async {
      isLoading.value = true;
      currentuserid.value = await userStateW.getUserData(UserData.id, context);
      final data = await apiCall(
        query:
            "query getChatRooms(\$id:Int!){getChatRooms (id:\$id){ id, latestMessage{ message, createdAt },members{id,user{ id, profile,username,}}}}",
        variables: {"id": currentuserid.value},
        headers: {"content-type": "*/*"},
      );

      if (data.status) {
        for (int i = 0; i < data.data["getChatRooms"].length; i++) {
          List myuser = [];

          for (int j = 0;
              j < data.data["getChatRooms"][i]["members"].length;
              j++) {
            if (data.data["getChatRooms"][i]["members"][j]["user"]["id"] ==
                currentuserid.value) continue;
            myuser.add(data.data["getChatRooms"][i]["members"][j]);
          }
          rooms.value = [
            ...rooms.value,
            {
              "id": data.data["getChatRooms"][i]["id"],
              "sender": myuser[0]["user"]["id"],
              "latestMessage": data.data["getChatRooms"][i]["latestMessage"]
                  ["message"],
              "time": data.data["getChatRooms"][i]["latestMessage"]
                  ["createdAt"],
              "profile": myuser[0]["user"]["profile"],
              "name": myuser[0]["user"]["username"],
            }
          ];
        }
      }
      isLoading.value = false;
    }

    useEffect(() {
      init();
      return null;
    }, []);
    return Scaffold(
      backgroundColor: appBarColor,
      // ___________ App Bar ___________
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: whiteColor,
        elevation: 0.0,
        title: const Padding(
          padding: EdgeInsets.only(top: 28.0),
          child: Text(
            'Chat',
            style: TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: InkWell(
              onTap: () {
                context.go("/searchuser");
              },
              child: const Icon(
                Icons.person_add_alt_1_outlined,
                color: Colors.black,
                size: 25,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
        bottom: TabBar(
          controller: controller,
          labelColor: indigoColor,
          indicatorColor: indigoColor,
          indicator: UnderlineTabIndicator(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Colors.deepPurpleAccent, width: 2.7)),
          dividerColor: Colors.black,
          tabs: const [
            Tab(
              child: Text("Chats"),
            ),
            Tab(
              child: Text("Groups"),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: isLoading.value
            ? SizedBox(
                width: width,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : TabBarView(
                controller: controller,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (rooms.value.isEmpty) ...[
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: Center(
                                child: Text(
                                  "You have no chat history.",
                                  textScaler: TextScaler.linear(1),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          ] else ...[
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 30.0, bottom: 10, left: 5),
                              child: Text(
                                'Contacts',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            for (int i = 0; i < rooms.value.length; i++) ...[
                              Contactlist(
                                id: rooms.value[i]["sender"],
                                path: rooms.value[i]["profile"],
                                name: rooms.value[i]["name"],
                                status: rooms.value[i]["latestMessage"],
                                time:
                                    "${DateTime.parse(rooms.value[i]["time"] as String).hour}:${DateTime.parse(rooms.value[i]["time"] as String).minute}",
                              ),
                            ],
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: Center(
                              child: Text(
                                "You have not joined any grouop yet.",
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

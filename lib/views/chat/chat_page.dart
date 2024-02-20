import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/services/api.dart';
import 'package:trading_app/states/userstate.dart';
import 'package:trading_app/utils/utilsmethod.dart';

import '../../components/switch.dart';
import '../../utils/alerts.dart';

class ChatPage extends HookConsumerWidget {
  final int reciver;
  const ChatPage({super.key, required this.reciver});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    ValueNotifier<bool> isLoading = useState<bool>(true);
    final userStateW = ref.watch(userState);
    ValueNotifier<int> currentuserid = useState<int>(0);

    ValueNotifier<int> userid = useState<int>(0);
    ValueNotifier<String> profilephoto = useState<String>("");
    ValueNotifier<String> name = useState<String>("");
    ValueNotifier<String> username = useState<String>("");

    ValueNotifier<int> roomid = useState<int>(0);
    final message = useTextEditingController();
    ValueNotifier<List<dynamic>> roommessages = useState<List<dynamic>>([]);

    ScrollController scrollController = useScrollController();

    void scrollToEnd() {
      scrollController.jumpTo(
        scrollController.position.maxScrollExtent,
      );
    }

    Future<void> init() async {
      currentuserid.value = await userStateW.getUserData(UserData.id, context);

      final data = await apiCall(
        query:
            "query getUserById(\$id:Int!){getUserById (id:\$id){ id, role, name, username, email, profile, number, address}} ",
        variables: {"id": reciver},
        headers: {"content-type": "*/*"},
      );

      userid.value = data.data["getUserById"]["id"] ?? 0;
      name.value = data.data["getUserById"]["name"] ?? "";
      username.value = data.data["getUserById"]["username"] ?? "";
      profilephoto.value = data.data["getUserById"]["profile"] ?? "";

      final roomdata = await apiCall(
        query:
            "query getChatboxByUser(\$sender:Int!,\$recevier:Int!){getChatboxByUser (sender:\$sender,recevier:\$recevier){ id }} ",
        variables: {"sender": currentuserid.value, "recevier": userid.value},
        headers: {"content-type": "*/*"},
      );

      if (roomdata.status) {
        roomid.value = roomdata.data["getChatboxByUser"]["id"];

        final messagedata = await apiCall(
          query:
              "query getChatHistory(\$roomid:Int!){getChatHistory (id:\$roomid){ id,senderId,message }} ",
          variables: {"roomid": roomid.value},
          headers: {"content-type": "*/*"},
        );

        if (messagedata.status) {
          for (int i = 0; i < messagedata.data["getChatHistory"].length; i++) {
            roommessages.value = [
              ...roommessages.value,
              {
                "id": messagedata.data["getChatHistory"][i]["senderId"],
                "message": messagedata.data["getChatHistory"][i]["message"],
              }
            ];
          }
        }
      }
      isLoading.value = false;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        scrollToEnd();
      });
    }

    useEffect(() {
      init();
      return null;
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        scrollToEnd();
      });
      return null;
    });

    Future<void> sendmessage() async {
      if (message.text == "") return;

      var req = {
        "senderId": currentuserid.value,
        "receiverId": userid.value,
        "message": message.text,
      };
      if (roomid.value != 0) {
        req["roomId"] = roomid.value;
      }
      final sendmessage = await apiCall(
        query:
            "mutation createMessage(\$CreateMessageInput:CreateMessageInput!){createMessage (createMessageInput:\$CreateMessageInput){ id, message,senderId }} ",
        variables: {"CreateMessageInput": req},
        headers: {"content-type": "*/*"},
      );
      if (!sendmessage.status) {
        if (context.mounted) {
          erroralert(context, "Error", "Unable to send message. Try againg!");
        }
      }
      roommessages.value = [
        ...roommessages.value,
        {
          "id": sendmessage.data["createMessage"]["senderId"],
          "message": sendmessage.data["createMessage"]["message"],
        }
      ];
      message.text = "";
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: isLoading.value
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: width,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),

                // __________ Top Info Bar ___________
                appBar: AppBar(
                  elevation: 0.5,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  title: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          child: CachedNetworkImage(
                            imageUrl: profilephoto.value,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/user.png",
                              fit: BoxFit.cover,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        longtext(username.value, 15),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),

                // ______________ Chats _______________
                body: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < roommessages.value.length; i++) ...[
                        MessageViewer(
                          message: roommessages.value[i]["message"],
                          textColor:
                              currentuserid.value == roommessages.value[i]["id"]
                                  ? Colors.white
                                  : Colors.black,
                          messageType: UpperNipMessageClipperTwo(
                              currentuserid.value == roommessages.value[i]["id"]
                                  ? MessageType.send
                                  : MessageType.receive),
                          boxColor:
                              currentuserid.value == roommessages.value[i]["id"]
                                  ? const Color.fromARGB(255, 68, 60, 213)
                                  : const Color(0xffeeeeee),
                          padding:
                              currentuserid.value == roommessages.value[i]["id"]
                                  ? const EdgeInsets.only(left: 80)
                                  : const EdgeInsets.only(right: 80),
                          messageAlign:
                              currentuserid.value == roommessages.value[i]["id"]
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                        ),
                      ]
                    ],
                  ),
                ),

                // __________________ Message Field __________________
                bottomSheet: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: TextFormField(
                    controller: message,
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 239, 234, 234),
                      filled: true,
                      hintText: 'Type your message',
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(40)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(40)),
                      suffixIconConstraints: const BoxConstraints(),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: InkWell(
                          onTap: sendmessage,
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 53, 46, 188),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

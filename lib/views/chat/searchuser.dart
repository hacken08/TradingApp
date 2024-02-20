import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/services/api.dart';
import 'package:trading_app/states/userstate.dart';
import 'package:trading_app/utils/alerts.dart';

import '../../themes/colors.dart';

// ignore: camel_case_types
class SearchUser extends HookConsumerWidget {
  const SearchUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersearch = useTextEditingController();

    final userStateW = ref.watch(userState);
    ValueNotifier<int> userid = useState(0);
    Future<void> init() async {
      userid.value = await userStateW.getUserData(UserData.id, context);
    }

    useEffect(() {
      init();
      return null;
    }, []);

    ValueNotifier<List<dynamic>> users = useState<List<dynamic>>([]);
    ValueNotifier<bool> isSearching = useState<bool>(false);
    ValueNotifier<bool> isSearched = useState<bool>(false);

    void searchUser() async {
      isSearching.value = true;
      if (usersearch.text == "") {
        erroralert(
          context,
          "Error",
          "Enter username in order to search",
        );
      } else {
        final data = await apiCall(
            query:
                "query searchUsername(\$username:String!){searchUsername (username:\$username){ id, name, profile, username}} ",
            variables: {"username": usersearch.text},
            headers: {"content-type": "*/*"});

        if (data.status) {
          users.value = data.data["searchUsername"];
          users.value = data.data["searchUsername"]
              .where((val) => val["id"] != userid.value)
              .toList();
        } else {
          if (context.mounted) erroralert(context, "Error", data.message);
        }
      }
      isSearched.value = true;
      usersearch.text = "";
      isSearching.value = false;
    }

    return Scaffold(
      backgroundColor: Colors.white,

      // ___________ App Bar ___________
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            context.go("/home");
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Search User',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ), // AppBar end......

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // ____________ Search Box ____________
              TextFormField(
                controller: usersearch,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: InkWell(
                    onTap: searchUser,
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(color: stoneColor, fontSize: 17),
                  fillColor:
                      const Color.fromARGB(255, 238, 238, 238).withOpacity(0.8),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    gapPadding: 2.0,
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 2.0,
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ), // Search box End...........
              if (isSearching.value) ...[
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: CircularProgressIndicator(),
                ),
                const Center(
                  child: Text(
                    'Searching...',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ] else if (!isSearched.value)
                ...[]
              else ...[
                if (users.value.isEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text(
                        "No User found with ${usersearch.text} username.",
                        textScaler: const TextScaler.linear(1),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ] else ...[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30.0, bottom: 10, left: 5),
                    child: Row(
                      children: [
                        const Text(
                          'Search Result',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Found : ${users.value.length}',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  for (int i = 0; i < users.value.length; i++) ...[
                    SearchResult(
                      profile: users.value[i]["profile"],
                      name: users.value[i]["name"],
                      username: users.value[i]["username"],
                      id: users.value[i]["id"],
                    ),
                  ],
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class SearchResult extends HookConsumerWidget {
  final String profile;
  final String name;
  final String username;
  final int id;
  const SearchResult({
    super.key,
    required this.profile,
    required this.name,
    required this.username,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(right: 10),
          onTap: () {
            context.go("/contact/chat/$id");
          },
          focusColor: Colors.white,
          hoverColor: Colors.white,
          splashColor: Colors.white,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
              width: 35,
              height: 35,
              child: CachedNetworkImage(
                imageUrl: profile,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/user.png",
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            name,
            textScaler: const TextScaler.linear(1),
            style: const TextStyle(
              fontSize: 19,
              // fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text(
            username,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          dense: false,
          horizontalTitleGap: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          child: Divider(thickness: 0.6),
        ),
      ],
    );
  }
}

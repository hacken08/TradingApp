// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trading_app/services/api.dart';
import 'package:trading_app/themes/colors.dart';

class ProfileVisitpage extends HookConsumerWidget {
  final int id;
  const ProfileVisitpage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    ValueNotifier<bool> isLoading = useState<bool>(true);
    ValueNotifier<Map<String, dynamic>> userdata =
        useState<Map<String, dynamic>>({});

    Future<void> init() async {
      final data = await apiCall(
        query:
            "query getUserById(\$id:Int!){getUserById (id:\$id){ id, role, name, bio, username, profile }} ",
        variables: {"id": id},
        headers: {"content-type": "*/*"},
      );
      if (!data.status && context.mounted) return context.go("/home");
      userdata.value = data.data["getUserById"];

      isLoading.value = false;
    }

    useEffect(() {
      init();
      return null;
    }, []);

    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: appBarColor,
      body: isLoading.value
          ? SizedBox(
              width: width,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 15,
                ),

                Container(
                  height: 60,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: ListTile(
                      title: Row(
                        children: [
                          InkWell(
                            onTap: () => context.go('/home'),
                            child: const Icon(Icons.arrow_back),
                          ),
                          const Spacer(),
                          Text(
                            '${userdata.value["name"] ?? ""} Profile ',
                            textScaler: const TextScaler.linear(1),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.5,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                //____________________ pic and Bground ____________________
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            shape: BoxShape.circle,
                          ),
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: userdata.value["profile"] ?? "",
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
                      ),
                      // Stack(
                      //   clipBehavior: Clip.none,
                      //   alignment: Alignment.center,
                      //   children: [
                      //     Positioned(
                      //       bottom: -50,
                      //       child: Container(
                      //         alignment: Alignment.center,
                      //         child: Container(
                      //           padding: const EdgeInsets.all(5),
                      //           decoration: BoxDecoration(
                      //             color: whiteColor,
                      //             shape: BoxShape.circle,
                      //           ),
                      //           width: 100,
                      //           height: 100,
                      //           child: ClipRRect(
                      //             borderRadius: BorderRadius.circular(100),
                      //             child: CachedNetworkImage(
                      //               imageUrl: userdata.value["profile"] ?? "",
                      //               progressIndicatorBuilder: (context, url,
                      //                       downloadProgress) =>
                      //                   CircularProgressIndicator(
                      //                       value: downloadProgress.progress),
                      //               errorWidget: (context, url, error) =>
                      //                   Image.asset(
                      //                 "assets/images/user.png",
                      //                 fit: BoxFit.cover,
                      //               ),
                      //               fit: BoxFit.cover,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     )
                      //     // editButton(),
                      //   ],
                      // ),

                      // ____________________ Name and username ______________________
                      const SizedBox(
                        height: 55,
                      ),
                      Text(
                        userdata.value["name"] ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            letterSpacing: 1),
                      ),

                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "@${userdata.value["username"] ?? ""}",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 31,
                      ),

                      // ____________________ Bio and Info ______________________
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          userdata.value["bio"] ?? "",
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      if (userdata.value["id"] != id) ...[
                        SizedBox(
                          height: 75,
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              messagButton(size),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            messagButton(size),
                            shareButton(size),
                            randomButton(size)
                          ],
                        )
                      ],
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  InkWell randomButton(Size size) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 49,
        width: size.width * 0.15,
        decoration: BoxDecoration(
            color: const Color.fromARGB(230, 34, 31, 224),
            borderRadius: BorderRadius.circular(12)),
        child: const Center(
            child: Icon(
          Icons.add_to_queue_sharp,
          color: Colors.white,
        )),
      ),
    );
  }

  InkWell shareButton(Size size) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 49,
        width: size.width * 0.15,
        decoration: BoxDecoration(
            color: const Color.fromARGB(230, 34, 31, 224),
            borderRadius: BorderRadius.circular(12)),
        child: const Center(
          child: Icon(
            Icons.share,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  InkWell messagButton(Size size) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 48,
        width: size.width * 0.56,
        decoration: BoxDecoration(
            color: const Color.fromARGB(230, 34, 31, 224),
            border: Border.all(
              color: const Color.fromARGB(230, 34, 31, 224),
            ),
            borderRadius: BorderRadius.circular(12)),
        child: const Center(
          child: Text(
            "Message",
            style: TextStyle(
                color: Colors.white, fontSize: 19, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  // Positioned editButton() {
  //   return Positioned(
  //     left: 311,
  //     bottom: 75,
  //     child: IconButton(
  //         onPressed: () {},
  //         icon: const Icon(
  //           Icons.edit,
  //           color: Colors.white,
  //           size: 24,
  //         )),
  //   );
  // }
}

Positioned profileImage() {
  return Positioned(
    top: 85,
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 7),
          borderRadius: BorderRadius.circular(49)),
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade800,
        radius: 39,
        backgroundImage: const AssetImage('assets/profiles/sample_9.png'),
      ),
    ),
  );
}

Positioned backButton(BuildContext context) {
  return Positioned(
    top: 15,
    left: 10,
    child: IconButton(
      onPressed: () => context.go("/home"),
      icon: const Icon(
        Icons.arrow_back_outlined,
        size: 29,
        color: Colors.white,
      ),
    ),
  );
}

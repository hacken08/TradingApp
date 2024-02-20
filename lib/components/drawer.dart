// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomDrwer extends HookConsumerWidget {
  final GlobalKey<ScaffoldState> scaffoldkey;
  final String name;
  final String email;
  final String profile;
  final int id;
  const CustomDrwer({
    super.key,
    required this.scaffoldkey,
    required this.id,
    required this.name,
    required this.email,
    required this.profile,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      width: size.width * 0.7,
      child: SizedBox(
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 40,
                left: 15,
                right: 15,
                bottom: 10,
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/drawerbg.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CachedNetworkImage(
                        imageUrl: profile,
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
                    width: 10,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          textScaler: const TextScaler.linear(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          email,
                          textScaler: const TextScaler.linear(1),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
                context.push("/visitprofile/$id");
              },
              leading: const Icon(Icons.person),
              title: const Text(
                "Profile",
                textScaler: TextScaler.linear(1),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                context.go("/orders");
              },
              leading: const Icon(Icons.history),
              title: const Text(
                "History",
                textScaler: TextScaler.linear(1),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                context.go("/settings");
              },
              leading: const Icon(Icons.settings),
              title: const Text(
                "Settings",
                textScaler: TextScaler.linear(1),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                context.go("/notification");
              },
              leading: const Icon(Icons.notifications),
              title: const Text(
                "Notificaton",
                textScaler: TextScaler.linear(1),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Help",
                textScaler: TextScaler.linear(1),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.star),
              title: Text(
                "Privacy Policy",
                textScaler: TextScaler.linear(1),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.help),
              title: Text(
                "Help",
                textScaler: TextScaler.linear(1),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                context.go("/login");
              },
              child: const ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  "Logout",
                  textScaler: TextScaler.linear(1),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}

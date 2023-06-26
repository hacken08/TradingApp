import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomDrwer extends HookConsumerWidget {
  final GlobalKey<ScaffoldState> scaffoldkey;
  const CustomDrwer({super.key, required this.scaffoldkey});

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
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/images/signUp.png"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Username",
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Tagline of the user this is can be long",
                          textScaleFactor: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Navigation",
                textScaleFactor: 1,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text(
                "Profile",
                textScaleFactor: 1,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.history),
              title: Text(
                "History",
                textScaleFactor: 1,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                "Settings",
                textScaleFactor: 1,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.notifications),
              title: Text(
                "Notificaton",
                textScaleFactor: 1,
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
                textScaleFactor: 1,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.star),
              title: Text(
                "Privacy Policy",
                textScaleFactor: 1,
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
                textScaleFactor: 1,
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
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

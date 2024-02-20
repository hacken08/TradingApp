import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trading_app/components/text_form_fields.dart';

import '../../services/api.dart';
import '../../states/userstate.dart';
import '../../themes/colors.dart';
import '../../utils/alerts.dart';
import '../../utils/utilsmethod.dart';

class ProfileCreating extends HookConsumerWidget {
  const ProfileCreating({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());

    ValueNotifier<bool> isLoading = useState<bool>(true);
    final userStateW = ref.watch(userState);
    ValueNotifier<int> userid = useState<int>(0);
    ValueNotifier<Map<String, dynamic>> userdata =
        useState<Map<String, dynamic>>({});

    ValueNotifier<String> profilephoto = useState<String>("");

    TextEditingController name = useTextEditingController();
    TextEditingController bio = useTextEditingController();
    TextEditingController username = useTextEditingController();
    TextEditingController phone = useTextEditingController();
    TextEditingController email = useTextEditingController();
    TextEditingController address = useTextEditingController();

    Future<void> init() async {
      userid.value = await userStateW.getUserData(UserData.id, context);

      final data = await apiCall(
        query:
            "query getUserById(\$id:Int!){getUserById (id:\$id){ id, role, name, bio, username, email, profile, number, address}} ",
        variables: {"id": userid.value},
        headers: {"content-type": "*/*"},
      );
      userdata.value = data.data["getUserById"];

      name.text = data.data["getUserById"]["name"] ?? "";
      bio.text = data.data["getUserById"]["bio"] ?? "";
      username.text = data.data["getUserById"]["username"] ?? "";
      phone.text = data.data["getUserById"]["number"] ?? "";
      email.text = data.data["getUserById"]["email"] ?? "";
      address.text = data.data["getUserById"]["address"] ?? "";
      profilephoto.value = data.data["getUserById"]["profile"] ?? "";

      isLoading.value = false;
    }

    useEffect(() {
      init();
      return null;
    }, []);

    ValueNotifier<File?> profileImage = useState<File?>(null);
    Future<void> changeImage() async {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        profileImage.value = File(image.path);
      } on PlatformException catch (e) {
        if (context.mounted) {
          erroralert(context, "Error", 'Failed to pick image: $e');
        }
      }
    }

    Future<void> updateUser() async {
      isLoading.value = true;
      var request = {
        "id": userid.value,
        "username": username.text,
        "email": email.text,
        "name": name.text,
        "bio": bio.text,
        "address": address.text,
        "number": phone.text,
      };

      // profile
      if (profileImage.value != null) {
        final responseimag =
            await uploadFile(profileImage.value!, userid.value.toString());
        if (!responseimag.status) {
          isLoading.value = false;
          if (context.mounted) {
            return erroralert(context, "Error", responseimag.message);
          }
        }
        request["profile"] = responseimag.data;
      } else {
        if (profilephoto.value == "") {
          isLoading.value = false;
          return erroralert(context, "Error", "Select your profile image");
        }
      }

      final data = await apiCall(
        query:
            "mutation updateUserById(\$updateUserInput:UpdateUserInput!){updateUserById (updateUserInput:\$updateUserInput){ id}} ",
        variables: {"updateUserInput": request},
        headers: {"content-type": "*/*"},
      );
      if (data.status) {
        if (context.mounted) {
          susalert(context, "Success", "User Updated");
          context.go("/home");
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        if (context.mounted) return erroralert(context, "Error", data.message);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // backgroundColor: appBackgroundColor,

      // -------- AppBar -------
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.push("/home"),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Profile Edit",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: isLoading.value
          ? SizedBox(
              width: width,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Form(
                      key: formKey,
                      child: Container(
                        width: width,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            // ------------ Profile Change ------------
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: profileImage.value == null
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                userdata.value["profile"] ?? "",
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              "assets/images/user.png",
                                              fit: BoxFit.cover,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : Image.file(
                                            profileImage.value!,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      await changeImage();
                                    },
                                    focusColor: Colors.white,
                                    hoverColor: Colors.white,
                                    splashColor: Colors.white,
                                    // overlayColor: Colors.white,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 0.3),
                                          color: indigoColor,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Text(
                                          "Change Profile",
                                          textScaler:
                                              const TextScaler.linear(1),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: whiteColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 30,
                            ),

                            // ---------------- Name ----------------
                            const Text(
                              'Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(height: 10),

                            ProfileTextFiel(
                                validation: (value) {
                                  if (value == "" ||
                                      value == null ||
                                      value.isEmpty) {
                                    return "Fill Your Name";
                                  }
                                  return null;
                                },
                                controller: name,
                                hintText: 'Name',
                                icon: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Image.asset(
                                      'assets/icons/name_1.png',
                                      scale: 2,
                                    ))),
                            const SizedBox(height: 20),
                            // ---------------- Bio ----------------
                            const Text(
                              'Your bio',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(height: 10),

                            ProfileTextFiel(
                              validation: (value) {
                                if (value == "" ||
                                    value == null ||
                                    value.isEmpty) {
                                  return "Fill Your bio";
                                }
                                return null;
                              },
                              controller: bio,
                              hintText: 'Something about you..',
                              icon: SizedBox(
                                width: 30,
                                height: 30,
                                child: Image.asset(
                                  'assets/icons/msg.png',
                                  scale: 2,
                                ),
                              ),
                              maxLength: 200,
                            ),
                            const SizedBox(height: 20),

                            // ---------------- Username ----------------
                            const Text(
                              'Username',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(height: 10),

                            ProfileTextFiel(
                              validation: (value) {
                                if (value == "" ||
                                    value == null ||
                                    value.isEmpty) {
                                  return "Fill Your Username";
                                }
                                return null;
                              },
                              controller: username,
                              hintText: 'Username',
                              icon: SizedBox(
                                width: 30,
                                height: 30,
                                child: Image.asset('assets/icons/username.png',
                                    scale: 1.7),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // ---------------- Phone Number ----------------
                            const Text(
                              'Mobile Number',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(height: 10),

                            ProfileTextFiel(
                              inputformatter: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validation: (value) {
                                if (value == "" ||
                                    value == null ||
                                    value.isEmpty) {
                                  return "Fill Your Contact Number";
                                }
                                return null;
                              },
                              textInputType: TextInputType.number,
                              controller: phone,
                              hintText: "Mobile Number",
                              icon: SizedBox(
                                width: 30,
                                height: 30,
                                child: Image.asset(
                                  'assets/icons/mobile.png',
                                  scale: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // ---------------- Email ----------------
                            const Text(
                              'Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(height: 10),

                            ProfileTextFiel(
                              validation: (value) {
                                if (value == "" ||
                                    value == null ||
                                    value.isEmpty) {
                                  return "Enter your email";
                                } else if (!validateEmail(value)) {
                                  return "Enter a valid email";
                                }
                                return null;
                              },
                              enable: true,
                              controller: email,
                              hintText: "Email",
                              icon: SizedBox(
                                width: 30,
                                height: 30,
                                child: Image.asset(
                                  'assets/icons/email.png',
                                  scale: 3.4,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            // ---------------- Address ----------------
                            const Text(
                              'Address',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(height: 10),

                            ProfileTextFiel(
                              maxLength: 80,
                              validation: (value) {
                                if (value == "" ||
                                    value == null ||
                                    value.isEmpty) {
                                  return "Fill Your address";
                                }
                                return null;
                              },
                              controller: address,
                              hintText: "Address",
                              icon: SizedBox(
                                width: 30,
                                height: 30,
                                child: Image.asset(
                                  'assets/icons/location.png',
                                  scale: 2.7,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),

                            // -------------------- SAVE BUTTON --------------------
                            InkWell(
                              onTap: () async {
                                // if (formKey.currentState!.validate()) {
                                await updateUser();
                                // }
                              },
                              child: Container(
                                // width: 100,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: roseColor,
                                    borderRadius: BorderRadius.circular(49)),
                                child: const Center(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

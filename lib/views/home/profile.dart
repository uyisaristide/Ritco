import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:ritco_app/main.dart';
import 'package:ritco_app/riverpod/providers/auth_providers.dart';
import 'package:ritco_app/theme/colors.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart' as vector_icons;
import 'widgets/cover_container.dart';
import 'widgets/language_dialog.dart';
import 'widgets/profile_item.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);
    var locale = ref.watch(localeProvider);
    return Scaffold(
      // backgroundColor: scaffold,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title:  const Text("profile.title").tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: scaffold,
                        child: const Icon(
                          Ionicons.person,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user!.user!.fname,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        user.user!.phone,
                      ),
                    ],
                  )
                ],
              ),
            ),
            CoverContainer(margin: 20, children: [
              ProfileItemIcon(
                  title: 'profile.tickets'.tr(),
                  iconSize: 18,
                  onPressed: () {
                    context.push('/myOrders');
                  },
                  leadingIcon: MaterialCommunityIcons.ticket,
                  avatarColor: const Color(0xffeff4f8)),
              ProfileItemIcon(
                  title: 'profile.notifications'.tr(),
                  onPressed: () {
                    // context.push('/cart');
                  },
                  isLast: true,
                  leadingIcon: vector_icons.Ionicons.notifications,
                  iconSize: 18,
                  avatarColor: const Color(0xffeff4f8)),
            ]),
            CoverContainer(margin: 20,
                children: [
              ProfileItemIcon(
                  title: 'profile.language'.tr(),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return LanguageChangeDialog();
                      },
                    );
                  },
                  leadingIcon: Icons.language,
                  isLast: true,
                  avatarColor: const Color(0xffeff4f8))
            ]),
            CoverContainer(margin: 20, children: [
              ProfileItemIcon(
                title: 'profile.edit'.tr(),
                // titleColor: Colors.red,
                onPressed: () {
                  // context.push("/newUser", extra: userState.user);
                },
                leadingIcon: Icons.edit,
                avatarColor: const Color(0xffeff4f8),
                // arrowColor: Colors.red,
              ),
              ProfileItemIcon(
                  title: 'profile.logout'.tr(),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title:  Text(
                            'profile.logout'.tr().toUpperCase(),
                            // style: TextStyle(color: Colors.red),
                          ),
                          content: const Text(
                              'Do you want to logout from your account?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                await ref
                                    .read(userProvider.notifier)
                                    .logout(ref, context);
                              },
                              child:  Text(
                                'profile.logout'.tr(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  leadingIcon: Icons.logout,
                  iconColor: Colors.red,
                  avatarColor: const Color(0xfffcefef)),
              ProfileItemIcon(
                title: 'profile.delete'.tr(),
                titleColor: Colors.red,
                onPressed: () {},
                leadingIcon: Icons.delete,
                iconColor: Colors.red,
                avatarColor: const Color(0xfffcefef),
                arrowColor: Colors.red,
                isLast: true,
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

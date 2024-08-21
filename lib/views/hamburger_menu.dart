import 'package:flutter/material.dart';
import 'home.dart';
import 'assets.dart';
import 'login_Screen.dart';

class AppDrawer extends StatelessWidget {
  final User user = User(
      username: 'UserName',
      email: 'username@gmail.com',
      image: 'assets/images/userProfileImage.png');

  AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            color: Colors.blue,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, bottom: 25.0, top: 40.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40,
                          backgroundImage: AssetImage(user.image),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.username,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.email,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Container(
                    height: 1.0,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 30.0, right: 25.0),
                        leading: const Icon(Icons.home,
                            color: Colors.white, size: 22),
                        title: const Text('Home',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.white, size: 15),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (Route<dynamic> route) => false,
                          );
                        },
                      ),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 30.0, right: 25.0),
                        leading: const Icon(Icons.person_outline_rounded,
                            color: Colors.white, size: 22),
                        title: const Text('My Profile',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.white, size: 15),
                        onTap: () {},
                      ),
                      ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 30.0, right: 25.0),
                          leading: const Icon(Icons.settings_outlined,
                              color: Colors.white, size: 22),
                          title: const Text('Assets',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.white, size: 15),
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AssetsPage(image: user.image),
                              ),
                              // image is passed as a parameter
                              (Route<dynamic> route) => false,
                            );
                          }),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 30.0, right: 25.0),
                        leading: const Icon(Icons.cloud_queue,
                            color: Colors.white, size: 22),
                        title: const Text('Sites',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.white, size: 15),
                        onTap: () {},
                      ),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 30.0, right: 25.0),
                        leading: const Icon(Icons.confirmation_num_outlined,
                            color: Colors.white, size: 22),
                        title: const Text('Tickets',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.white, size: 15),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1.0,
                  color: Colors.white,
                ),
                ListTile(
                  contentPadding:
                      const EdgeInsets.only(left: 30.0, right: 25.0),
                  leading:
                      const Icon(Icons.logout, color: Colors.white, size: 18),
                  title: const Text('Log Out',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => login_Screen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class User {
  late final String username;
  late final String email;
  late final String image;

  User({required this.username, required this.email, required this.image});
}

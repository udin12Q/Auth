import 'package:flutter/material.dart';
import 'package:login1/view/daftar_akun.dart';
import 'package:login1/view/login.dart';

class TabBarLogin extends StatefulWidget {
  const TabBarLogin({super.key});

  @override
  State<TabBarLogin> createState() => _TabBarLoginState();
}

class _TabBarLoginState extends State<TabBarLogin> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 10,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Login",
              ),
              Tab(
                text: "Daftar",
              ),
            ],
            labelStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            labelColor: Colors.green,
            indicatorColor: Colors.green,
            dividerColor: Colors.green,
          ),
        ),
        body: const TabBarView(children: [
          Login(),
          DaftarAkun(),
        ]),
      ),
    );
  }
}

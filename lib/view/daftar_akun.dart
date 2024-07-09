import 'package:login1/view/firebase_auth.dart';
import 'package:login1/view/widget/button_widget.dart';
import 'package:login1/view/widget/container_form.dart';
import 'package:login1/view/widget/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DaftarAkun extends StatefulWidget {
  const DaftarAkun({super.key});

  @override
  State<DaftarAkun> createState() => _DaftarAkunState();
}

class _DaftarAkunState extends State<DaftarAkun> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nowhatsappController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuthService _auth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: w,
                height: h * 0.4,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.blueAccent,
                  Colors.blueAccent,
                  Colors.blueAccent,
                ])),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 50),
                      const Text(
                        "Daftar Akun User",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Silahkan Isi Form dibawah ini",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: w,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(1, 102, 47, 0.15),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            FormWidgetContainer(
                              controller: _namaController,
                              hintText: 'Nama',
                              isPasswordField: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama Tidak Boleh Kosong';
                                }
                                return null;
                              },
                            ),
                            FormWidgetContainer(
                              controller: _nimController,
                              hintText: 'NIM',
                              isPasswordField: false,
                              inputType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'NIM Tidak Boleh Kosong';
                                }
                                return null;
                              },
                            ),
                            FormWidgetContainer(
                              controller: _nowhatsappController,
                              hintText: 'No WhatsApp',
                              isPasswordField: false,
                              inputType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'No WhatsApp Tidak Boleh Kosong';
                                }
                                return null;
                              },
                            ),
                            FormWidgetContainer(
                              controller: _emailController,
                              hintText: 'Email',
                              isPasswordField: false,
                              inputType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email Tidak Boleh Kosong';
                                }
                                return null;
                              },
                            ),
                            FormWidgetContainer(
                              controller: _passwordController,
                              hintText: 'Password',
                              isPasswordField: true,
                              inputType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password Tidak Boleh Kosong';
                                }
                                return null;
                              },
                            ),
                            FormWidgetContainer(
                              controller: _confirmPasswordController,
                              hintText: 'Ulangi Password',
                              isPasswordField: true,
                              inputType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Silahkan Ulangi Password';
                                } else if (value != _passwordController.text) {
                                  return 'Passwords Tidak Sama';
                                }
                                return null;
                              },
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                          height: 50,
                          width: 150,
                          child: CustomButton(
                              text: 'Daftar',
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  _register();
                                }
                              })),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    try {
      String email = _emailController.text;
      String password = _passwordController.text;
      User? user = await _auth.signUpWithEmailAndPassword(email, password);

      await _firestore.collection('users').doc(user!.uid).set({
        'nama': _namaController.text,
        'nim': _nimController.text,
        'nowa': _nowhatsappController.text,
        'email': _emailController.text,
      });

      showCustomDialog(
        context,
        color: Colors.yellowAccent,
        icon: Icons.verified,
        title: 'Daftar Berhasil',
        content: 'Registrasi berhasil. Anda akan diarahkan ke halaman login.',
      );
    } catch (e) {
      showCustomDialog(
        context,
        icon: Icons.error,
        color: Colors.red,
        title: 'Daftar Gagal',
        content: '$e',
      );
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/homescreen.dart';
import 'package:todo/models/myuser.dart';
import 'package:todo/provider/theme_provider.dart';
import 'package:todo/user/register.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/dialog_utils.dart';

class Login extends StatefulWidget {
  static const String routeName = "login";

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obscureText = true;
  late ThemeProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    themeProvider=Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Stack(
        children: [
          Container(
            decoration:  BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(themeProvider.splash), fit: BoxFit.fill)),
          ),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    height: MediaQuery.of(context).size.height * 0.40,
                    decoration: BoxDecoration(
                        color: const Color(0x80FFFFFF),
                        borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Spacer(),
                        TextFormField(
                          enabled: true,
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: const TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: AppColors.gray,
                                  width: 1.5,
                                  style: BorderStyle.solid),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: AppColors.gray,
                                  width: 1.5,
                                  style: BorderStyle.solid),
                            ),
                          ),
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return "Empty email are not allowed";
                            }
                            final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text);
                            if (!emailValid) {
                              return "This email format is not allowed";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          enabled: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: const TextStyle(color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: AppColors.gray,
                                    width: 1.5,
                                    style: BorderStyle.solid),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: AppColors.gray,
                                    width: 1.5,
                                    style: BorderStyle.solid),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color:
                                      obscureText ? Colors.grey : Colors.black,
                                ),
                              )),
                          validator: (text) {
                            if (text == null || text.length < 6) {
                              return "Please enter a valid password";
                            }
                            return null;
                          },
                        ),
                        const Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              login();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF32A5DD),
                              minimumSize: const Size(350, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Login account",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 25,
                                )
                              ],
                            )),
                        Spacer(),
                        Container(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, Register.routeName);
                                },
                                child: const Text(
                                  "Don't have an account ? Sign up now",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black,
                                      fontSize: 15,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Forgot Password?",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void login() async {
    try {
      DialogUtils.showLoading(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Myuser.currentUser = await getUserFromUserFromFireStore(credential.user!.uid);
      DialogUtils.hideLoading(context);
      Navigator.pushNamed(context, HomeScreen.routeName);

    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        DialogUtils.showError(context, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        DialogUtils.showError(
            context, "Wrong password provided for that user.");
      } else {
        DialogUtils.showError(context);
      }
    }
  }

  Future<Myuser> getUserFromUserFromFireStore(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("users");
    DocumentReference userdoc = collectionReference.doc(id);
    DocumentSnapshot documentSnapshot = await userdoc.get();
    Map json = documentSnapshot.data() as Map;
    Myuser myuser = Myuser.fromJson(json);
    return myuser;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/homescreen.dart';
import 'package:todo/models/myuser.dart';
import 'package:todo/provider/theme_provider.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/dialog_utils.dart';

class Register extends StatefulWidget {
  static const String routeName = "register";

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmationPasswordController =
      TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obscureText = true;
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    themeProvider=Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
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
                    height: MediaQuery.of(context).size.height * 0.49,
                    decoration: BoxDecoration(
                        color: Color(0x80FFFFFF),
                        borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Spacer(),
                        TextFormField(
                          enabled: true,
                          controller: userNameController,
                          decoration: InputDecoration(
                            labelText: "User Name",
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
                              return "Please enter a valid user name";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
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
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          enabled: true,
                          controller: confirmationPasswordController,
                          decoration: InputDecoration(
                            labelText: "Confirmation Password",
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
                                  // Toggle the obscureText value when the eye icon is pressed
                                  obscureText = !obscureText;
                                });
                              },
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: obscureText ? Colors.grey : Colors.black,
                              ),
                            ),
                          ),
                          validator: (text) {
                            if (text == null || text.length < 6) {
                              return "Please enter a valid password";
                            }
                            if (text != passwordController.text) {
                              return "Two passwords does not match";
                            }
                            return null;
                          },
                        ),
                        const Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              registerAccount();
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
                                  "Create account",
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

  void registerAccount() async {
    if (!formKey.currentState!.validate()) return;
    try {
      DialogUtils.showLoading(context);

      UserCredential authCreds = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      Myuser.currentUser = Myuser(
          id: authCreds.user!.uid,
          email: emailController.text,
          userName: userNameController.text);
      await registerUserToFireStore(Myuser.currentUser!);
      DialogUtils.hideLoading(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideLoading(context);
      if (e.code == 'weak-password') {
        DialogUtils.showError(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.showError(
            context, "The account already exists for t0hat email.");
      } else {
        DialogUtils.showError(context);
      }
    }
  }

  Future<void> registerUserToFireStore(Myuser user) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("users");
    DocumentReference newDoc = collectionReference.doc(user.id);
    await newDoc.set(user.toJson());
  }
}

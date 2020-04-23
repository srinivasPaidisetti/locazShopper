import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locazshopper/constants/route_paths.dart';
import 'package:locazshopper/constants/strings.dart';
import 'package:locazshopper/ui/custom_views/custom_naivigation_button.dart';
import 'package:locazshopper/utils/common_utils.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(signInTxt),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(top: 20, bottom: 50, left: 20, right: 20),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          child: Text(
                            appTitle,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          )),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CustomNavigationButton(
                            title: signInTxt.toUpperCase(),
                            widthFactor: 0.8,
                            onPressed: () {
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: nameController.text,
                                      password: passwordController.text)
                                  .then((result) {
                                print("result ${result.user.email}");
                                removeUntilNavigateTo(
                                    context: context,
                                    value: RoutePaths.homeScreen);
                              }).catchError((error) {
                                print("error ${error.toString()}");
                              });
                            },
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

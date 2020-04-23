import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:locazshopper/constants/strings.dart';
import 'package:locazshopper/ui/custom_views/custom_naivigation_button.dart';
import 'package:locazshopper/ui/screens/register/register_screen.dart';
import 'package:locazshopper/ui/screens/sign_in/sign_in_screen.dart';
import 'package:locazshopper/utils/common_utils.dart';
import 'package:locazshopper/utils/image_utils.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 75, bottom: 50),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ImageUtils.getImage(
                        imageType: IMAGE.LOGO, imageName: 'grocery-1.png'),
                    GradientText(
                      appTitle,
                      gradient: gradient,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff04c5d5)),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CustomNavigationButton(
                            title: signInTxt.toUpperCase(),
                            widthFactor: 0.8,
                            onPressed: () {
                              navigateTo(context, SignInScreen());
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomNavigationButton(
                            title: registerTxt.toUpperCase(),
                            widthFactor: 0.8,
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

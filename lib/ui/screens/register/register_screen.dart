import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locazshopper/constants/route_paths.dart';
import 'package:locazshopper/constants/strings.dart';
import 'package:locazshopper/ui/custom_views/custom_naivigation_button.dart';
import 'package:locazshopper/ui/custom_views/register_text_field.dart';
import 'package:locazshopper/ui/shared/base_widget.dart';
import 'package:locazshopper/utils/common_utils.dart';
import 'package:locazshopper/utils/validations.dart';
import 'package:locazshopper/viewmodels/register/register_model.dart';
import 'package:toast/toast.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<RegisterModel>(
      model: RegisterModel(),
      onModelReady: (model) => null,
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Registeration'),
            ),
            body: SafeArea(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: RegisterTextField(
                            inputHintName: 'John Doe',
                            inputName: 'Username',
                            controller: model.usernameController,
                            validate: validateUsername,
                            isEmail: false,
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: RegisterTextField(
                            onChange: (value) {},
                            inputName: 'Email',
                            inputHintName: 'johndoe@gmail.com',
                            controller: model.emailController,
                            validate: validateUserInput,
                            isEmail: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: RegisterTextField(
                            inputHintName: '0123456789',
                            inputName: 'Phone Number',
                            controller: model.phoneNumberController,
                            validate: validateUsername,
                            isEmail: false,
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: RegisterTextField(
                            isPassword: true,
                            inputName: 'Password',
                            inputHintName: '*****************',
                            controller: model.passwordController,
                            validate: validatePassword,
                            isEmail: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: RegisterTextField(
                            inputHintName: 'George colony, main road',
                            inputName: 'Address',
                            controller: model.addressController,
                            validate: validateUsername,
                            isEmail: false,
                            maxLins: 4,
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomNavigationButton(
                            title: registerTxt.toUpperCase(),
                            widthFactor: 0.9,
                            onPressed: () {
                              validateForm(model);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )));
      },
    );
  }

  validateForm(RegisterModel model) {
    if (_formKey.currentState.validate()) {
      register(model);
      Toast.show('Please wait...', context, gravity: Toast.CENTER);
      return true;
    } else {
      model.setValidate(true);
      return false;
    }
  }

  void register(RegisterModel model) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: model.emailController.text,
            password: model.passwordController.text)
        .then((user) {
      Firestore.instance.collection('users').document(user.user.uid).setData({
        'user_name': model.usernameController.text,
        'email': model.emailController.text,
        'phone': model.phoneNumberController.text,
        'address': model.addressController.text,
        'user_id': user.user.uid
      });
      removeUntilNavigateTo(context: context, value: RoutePaths.homeScreen);
      showToast('Registeration successfull', context);
    }).catchError((error) {
      showToast('Something went wrong', context);
    });
  }
}

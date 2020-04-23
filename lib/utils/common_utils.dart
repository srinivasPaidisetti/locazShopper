import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:locazshopper/constants/route_paths.dart';
import 'package:toast/toast.dart';

Gradient gradient = LinearGradient(colors: [Color(0xff04c5d5), Colors.blue]);

navigateTo(BuildContext context, Widget name) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => name));
}

navigateToWithArg(BuildContext context, String value, {dynamic dynamicValue}) {
  Navigator.pushNamed(
    context,
    value,
    arguments: dynamicValue,
  );
}

void showToast(String msg, BuildContext context, {int duration, int gravity}) {
  Toast.show(msg, context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
      textColor: Colors.blue,
      backgroundColor: Colors.white,
      border: Border.all(width: 0.5, color: Colors.grey));
}

removeUntilNavigateTo({BuildContext context, String value}) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    value,
    ModalRoute.withName(
      RoutePaths.signInScreen,
    ),
  );
}

class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getQuantities() {
    return <Company>[
      Company(1, '1'),
      Company(2, '2'),
      Company(3, '3'),
      Company(4, '4'),
      Company(5, '5'),
      Company(6, '6'),
      Company(7, '7'),
      Company(8, '8'),
      Company(9, '9'),
      Company(10, '10'),
    ];
  }
}

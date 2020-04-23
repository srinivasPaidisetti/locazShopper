import 'package:fimber/fimber_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:locazshopper/constants/route_paths.dart';
import 'package:locazshopper/provider_setup.dart';
import 'package:locazshopper/ui/shared/base_widget.dart';
import 'package:locazshopper/viewmodels/app/app_model.dart';
import 'package:provider/provider.dart';
import 'constants/router.dart';

bool isFreshInstall = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final _status = await DatabaseChecker().getStatus();
  isFreshInstall = !_status;

  Fimber.plantTree(DebugTree());
  runApp(MultiProvider(providers: providers, child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BaseWidget<AppModel>(
      model: AppModel(navigationService: Provider.of(context)),
      onModelReady: (model) => model.startBackgroundSevice(true),
      builder: (context, model, child) {
        return MaterialApp(
          navigatorKey: model.navationKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              fontFamily: 'OpenSans',
              primaryColor: Colors.blue,
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              })),
          onGenerateRoute: Router.generateRoute,
          initialRoute:
              isFreshInstall ? RoutePaths.splashScreen : RoutePaths.userOrdersScreen,
        );
      },
    );
  }
}

class DatabaseChecker {
  Future<bool> getStatus() async {
    var user = await FirebaseAuth.instance.currentUser();
    return user != null;
  }

//  Future<UserModel> getUser() async {
//    final user = await FirebaseAuth.instance.currentUser();
//    final userModel = user != null
//        ? await getDoc('${CollectionNames.USERS}/${user.uid}', UserModel())
//        : null;
//    if (userModel?.activeConfig != null) {
//      userModel.grantedConfigModel = GrantedConfigModel.fromSnapshot(await Firestore
//          .instance
//          .document(
//          '${CollectionNames.PERMISSIONS}/${userModel.ref.documentID}/${SubCollectionNames.GRANTED_CONFIGS}/${userModel.activeConfig.documentID}')
//          .get(source: Source.cache));
//    }
//    return userModel;
//  }
}

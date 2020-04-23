import 'package:locazshopper/services/navigation_service.dart';
import 'package:locazshopper/viewmodels/app/app_model.dart';
import 'package:locazshopper/viewmodels/home/home_model.dart';
import 'package:locazshopper/viewmodels/register/register_model.dart';
import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildCloneableWidget> independentServices = [
  Provider.value(value: NavigationService()),
];

List<SingleChildCloneableWidget> dependentServices = [];

List<SingleChildCloneableWidget> uiConsumableProviders = [
  ChangeNotifierProxyProvider<NavigationService, AppModel>(
    builder: (context, navigation, app) =>
        AppModel(navigationService: navigation),
  ),
  ChangeNotifierProvider(builder: (context) => HomeModel()),
  ChangeNotifierProvider(builder: (context) => RegisterModel()),
];

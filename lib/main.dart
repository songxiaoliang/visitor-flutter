import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './route/routes.dart';
import './constants/theme.dart';
import './utils/time_util.dart';
import './config/application.dart';
import './pages/home/home_page.dart';
import './models/state_model/main_state_model.dart';

void main() async {
  int themeIndex = await getTheme();
  runApp(App(themeIndex));
}

Future<int> getTheme() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  int themeIndex = sp.getInt("themeIndex");
  if (themeIndex != null) {
    return themeIndex;
  }
  return 0;
}

class App extends StatefulWidget {
  final int themeIndex;

  App(this.themeIndex);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  dynamic subscription;
  MainStateModel mainStateModel;

  @override
  void initState() {
    super.initState();
    mainStateModel = MainStateModel();
    Application.eventBus = EventBus();
    final Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
    TimeUtil.initLocaleLanguage();
    initListener();
  }

  initListener() {
    subscription = new Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      String networkResult = "";
      switch (result) {
        case ConnectivityResult.mobile:
          networkResult = "当前处于移动网络";
          break;
        case ConnectivityResult.wifi:
          networkResult = "当前处于wifi网络";
          break;
        case ConnectivityResult.none:
          networkResult = "当前没有网络连接！";
          break;
        default:
          break;
      }
      Fluttertoast.showToast(
        msg: networkResult,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        backgroundColor: themeList[mainStateModel.themeIndex != null
          ? mainStateModel.themeIndex
          : widget.themeIndex],
        textColor: Colors.white,
        fontSize: 16.0
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainStateModel>(
        model: mainStateModel,
        child: ScopedModelDescendant<MainStateModel>(
          builder: (context, child, model) {
            return MaterialApp(
              debugShowCheckedModeBanner: false, // 去除 DEBUG 标签
              theme: ThemeData(
                  platform: TargetPlatform.iOS,
                  primaryColor: themeList[model.themeIndex != null
                      ? model.themeIndex
                      : widget.themeIndex]),
              home: HomePage(),
              onGenerateRoute: Application.router.generator,
            );
          },
        ));
  }
}

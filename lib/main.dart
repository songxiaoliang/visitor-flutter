import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './route/routes.dart';
import './config/application.dart';
import './pages/home/home_page.dart';
import './constants/theme.dart';
import './models/state_model/main_state_model.dart';

void main() async {
  int themeIndex = await getTheme();
  runApp(App(themeIndex));
}

Future<int> getTheme() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  int themeIndex = sp.getInt("themeIndex");
  if(themeIndex != null) {
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

  MainStateModel mainStateModel;

  @override
  void initState() {
    super.initState();
    mainStateModel = MainStateModel();
    Application.eventBus = EventBus();
    final Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainStateModel>(
      model: mainStateModel,
      child: ScopedModelDescendant<MainStateModel>(
        builder: (context, child, model) {
          return  MaterialApp(
            debugShowCheckedModeBanner: false, // 去除 DEBUG 标签
            theme: ThemeData(
              primaryColor: themeList[model.themeIndex != null ? model.themeIndex : widget.themeIndex]
            ),
            home: HomePage(),
            onGenerateRoute: Application.router.generator,
          );
        },
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'db/da_helper.dart';

import 'services/theme_service.dart';
import 'ui/theme.dart';
import 'ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDB();
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeSurvace().theme,
      home: HomePage(),
    );
  }
}

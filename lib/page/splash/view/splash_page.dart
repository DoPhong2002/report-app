import 'package:exercise_demo/comon/data_local/shared_preferences_manager.dart';
import 'package:exercise_demo/models/service/api_service.dart';
import 'package:exercise_demo/models/user.dart';
import 'package:exercise_demo/comon/data_local/hive_manager.dart';
import 'package:exercise_demo/comon/data_local/flutter_secure_storage.dart';
import 'package:exercise_demo/comon/navigator.dart';
import 'package:exercise_demo/page/login/view/login_page.dart';
import 'package:exercise_demo/page/report/view/report_page.dart';
import 'package:flutter/material.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: FlutterLogo(
        size: 100,
      )),
    );
  }

  Future initData() async {
    await sharedPrefs.init();
    await secureStorage.init();
    await hive.init();

    final userJson = await hive.getValue(userKey);
    if (userJson != null) {
      final user = User.fromJson(userJson);
      // apiService.token = user.token??'';
      print('_SplashPageState.initData: ${user.name}');

      apiService.user = user;
      print('token: ${user.token}');
      navigatorPushAndRemoveUntil(context,  const ReportPage());
    } else {
      navigatorPushAndRemoveUntil(context,  const LoginPage());
    }
  }
}

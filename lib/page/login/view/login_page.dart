import 'package:exercise_demo/comon/MyTextField.dart';
import 'package:exercise_demo/comon/data_local/hive_manager.dart';
import 'package:exercise_demo/comon/data_local/flutter_secure_storage.dart';
import 'package:exercise_demo/comon/Mybuttom.dart';
import 'package:exercise_demo/comon/data_local/shared_preferences_manager.dart';
import 'package:exercise_demo/comon/navigator.dart';
import 'package:exercise_demo/comon/progress_dialog.dart';
import 'package:exercise_demo/comon/toast_overlay.dart';
import 'package:exercise_demo/models/service/api_service.dart';
import 'package:exercise_demo/models/service/user_service.dart';
import 'package:exercise_demo/page/register/view/register_page.dart';
import 'package:exercise_demo/page/report/view/report_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  var notifier = ValueNotifier<bool>(false);
  late ProgressDialog progress;

  @override
  void initState() {
    progress = ProgressDialog(context);
    secureStorage.getString(phoneKey).then((value) {
      phoneController.text = value ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {},
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Image.network(
                        'https://photo-cms-sggp.zadn.vn/w580/Uploaded/2022/yfsgf/2019_06_20/lazadamasterlogo_esvv.png',
                        width: 188,
                      ),
                      MyTextField(
                        controller: phoneController,
                        labelText: 'Số điện thoại',
                        hintText: '0867..',
                        keyboardType: TextInputType.number,
                        onChanged: (_) => valadate(
                            phoneController.text, passwordController.text),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MyTextField(
                        controller: passwordController,
                        labelText: 'Password',
                        hintText: 'pass..',
                        obscureText: true,
                        onChanged: (_) => valadate(
                            phoneController.text, passwordController.text),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MyButton(
                              text: 'Register',
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              onTap: () {
                                navigatorPush(context, const RegisterPage());
                                // print('cancel');
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: ValueListenableBuilder<bool>(
                              valueListenable: notifier,
                              builder: (context, value, _) {
                                return MyButton(
                                  text: 'Login',
                                  backgroundColor: Colors.cyanAccent,
                                  textColor: Colors.white,
                                  enable: value,
                                  onTap: () {
                                    buildLogin();
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'HotLine: ',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  Text(
                    '1800.1186',
                    style: TextStyle(color: Colors.cyanAccent),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// nhap du moi cho click
  void valadate(String string1, String string2) {
    if (string1.isNotEmpty && string2.isNotEmpty) {
      notifier.value = true;
    } else {
      notifier.value = false;
    }
  }

  void buildLogin() async {
    progress.show();
    await Future.delayed(const Duration(seconds: 1));
    apiService
        .login(phone: phoneController.text, password: passwordController.text)
        .then((user) {
      sharedPrefs.setString(phoneKey, phoneController.text);
      secureStorage.setString(phoneKey, phoneController.text);
      // hive.setValue(userTokeKey, user.token);
      hive.setValue(userKey, user);
      progress.hide();

      apiService.token = user.token ?? '';
      ToastOverlay(context)
          .show(message: 'Hello ${user.name}', type: ToastType.error);
      apiService.token = user.token ?? '';
      apiService.user = user;
      navigatorPushAndRemoveUntil(context, const ReportPage());
    }).catchError((e) {
      progress.hide();
      ToastOverlay(context).show(message: e.toString(), type: ToastType.error);
    });
  }

  void resgister() {}

  void login() {}
}

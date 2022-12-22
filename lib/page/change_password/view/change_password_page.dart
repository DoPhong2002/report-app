import 'package:exercise_demo/comon/MyTextField.dart';
import 'package:exercise_demo/comon/Mybuttom.dart';
import 'package:exercise_demo/comon/navigator.dart';
import 'package:exercise_demo/comon/toast_overlay.dart';
import 'package:exercise_demo/models/service/api_service.dart';
import 'package:exercise_demo/models/service/user_service.dart';
import 'package:exercise_demo/page/login/view/login_page.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  var notifier = ValueNotifier<bool>(false);
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newAgainPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Change Password')),
      ),
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
              child: buildList())),
    );
  }

  Widget buildList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          MyTextField(
            controller: oldPasswordController,
            labelText: 'Old Password',
            onChanged: (_) => valadate(oldPasswordController.text,
                newPasswordController.text, newAgainPasswordController.text),
          ),
          const SizedBox(height: 16),
          MyTextField(
            controller: newPasswordController,
            labelText: 'Enter Password',
            obscureText: true,
            onChanged: (_) => valadate(oldPasswordController.text,
                newPasswordController.text, newAgainPasswordController.text),
          ),
          const SizedBox(
            height: 16,
          ),
          MyTextField(
            controller: newAgainPasswordController,
            labelText: 'Enter The Password ',
            obscureText: true,
            onChanged: (_) => valadate(oldPasswordController.text,
                newPasswordController.text, newAgainPasswordController.text),
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<bool>(
            valueListenable: notifier,
            builder: (context, value, _) {
              return MyButton(
                text: 'Đồng ý',
                onTap: () {
                  apiChangePassword();
                },
                backgroundColor: Colors.blue,
                enable: value,
              );
            },
          )
        ],
      ),
    );
  }

  /// nhap du moi cho click
  void valadate(String string1, String string2, String string3) {
    if (string1.isNotEmpty &&
        string2.isNotEmpty &&
        string3.isNotEmpty &&
        string2 == string3) {
      notifier.value = true;
    } else {
      notifier.value = false;
    }
  }

  void apiChangePassword() {
    apiService.changePassword(
        oldPassword: oldPasswordController.text,
        newPassword: newAgainPasswordController.text).then((value){
          ToastOverlay(context).show(message: 'Thanh Cong', type: ToastType.success);
          navigatorPushAndRemoveUntil(context, LoginPage());
    }).catchError((e){
      ToastOverlay(context).show(message: e.toString(), type: ToastType.error);
    });
  }
}

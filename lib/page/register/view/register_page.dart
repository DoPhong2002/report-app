import 'package:exercise_demo/comon/MyTextField.dart';
import 'package:exercise_demo/comon/Mybuttom.dart';
import 'package:exercise_demo/comon/navigator.dart';
import 'package:exercise_demo/comon/progress_dialog.dart';
import 'package:exercise_demo/comon/toast_overlay.dart';
import 'package:exercise_demo/models/service/api_service.dart';
import 'package:exercise_demo/models/service/user_service.dart';
import 'package:exercise_demo/page/login/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late ProgressDialog progress;

  @override
  void initState() {
    progress = ProgressDialog(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // const SizedBox(height: 64,),
            Image.network(
              'https://photo-cms-sggp.zadn.vn/w580/Uploaded/2022/yfsgf/2019_06_20/lazadamasterlogo_esvv.png',
              width: 188,
            ),
            MyTextField(
              labelText: 'Name',
              controller: nameController,
              keyboardType: TextInputType.name,
            ),
            MyTextField(
              controller: phoneController,
              labelText: 'Phone Number',
              keyboardType: TextInputType.number,
            ),
            MyTextField(
              controller: emailController,
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),

            MyTextField(
              controller: passwordController,
              labelText: 'PassWord',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(
              height: 64,
            ),
            Row(
              children: [
                Expanded(
                  child: MyButton(
                    text: 'Cancel',
                    backgroundColor: Colors.white,
                    textColor: Colors.cyanAccent,
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: MyButton(
                    text: 'Register',
                    backgroundColor: Colors.cyanAccent,
                    textColor: Colors.white,
                    onTap: () {
                      apiRegister();
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void apiRegister() {
    apiService
        .register(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      password: passwordController.text,
    )
        .then((user) {
      progress.hide();
      ToastOverlay(context)
          .show(message: 'Đăng kí thành công', type: ToastType.error);
      apiService.token = user.token ?? '';
      apiService.user = user;
      navigatorPushAndRemoveUntil(context, const LoginPage());
    }).catchError((e) {
      progress.hide();
      ToastOverlay(context).show(message: e.toString(), type: ToastType.error);
    });
    ;
  }
}

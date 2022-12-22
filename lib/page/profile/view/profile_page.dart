import 'package:exercise_demo/comon/MyTextField.dart';
import 'package:exercise_demo/comon/Mybuttom.dart';
import 'package:exercise_demo/comon/toast_overlay.dart';
import 'package:exercise_demo/models/service/api_service.dart';
import 'package:exercise_demo/models/service/photo_service.dart';
import 'package:exercise_demo/const/const.dart';
import 'package:exercise_demo/models/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker picker = ImagePicker();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController dateOfBirthController = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  XFile? file;
  var url = apiService.user?.avatar ??'';

  @override
  void initState() {
    nameController.text = apiService.user!.name!;
    dateOfBirthController.text = apiService.user!.dateOfBirth!;
    addressController.text = apiService.user!.address!;
    emailController.text = apiService.user!.email!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Tài khoản',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            buildAvt(),
            const SizedBox(
              height: 32,
            ),
            buildTextFields(),
            const SizedBox(
              height: 32,
            ),
            MyButton(
              text: 'Lưu',
              backgroundColor: Colors.cyanAccent,
              textColor: Colors.white,
              onTap: () {
                print(apiService.user!.avatar);
                apiUpdateProfile();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildAvt() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
            child: imageAVT(),
          ),
        ),
        Positioned(
          bottom: -10,
          right: -10,
          child: IconButton(
            onPressed: () {
              upLoadImage(source: ImageSource.camera);
            },
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.cyanAccent,
            ),
          ),
        ),
      ],
    );
  }

  Future upLoadImage({required ImageSource source}) async {
    try {
      final image = await picker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 10,
      );
      if (image != null) {
        upLoad(image);
      }
    } catch (e) {
      ToastOverlay(context).show(message: "co loi roi", type: ToastType.error);
    }
  }

  void upLoad(XFile f) {
    apiService.upLoadAvatar(file: f).then((value) {
      url = '$baseUrl${value.path}';
    }).catchError((e) {
      ToastOverlay(context).show(message: e, type: ToastType.error);
    });
  }

  Widget imageAVT() {
    if (apiService.user?.avatar != null) {
      return Image.network(
        apiService.user?.avatar??'',
        fit: BoxFit.cover,
      );
    }
    if (url.isNotEmpty) {
      return Image.network(url, fit: BoxFit.cover);
    }
    return Image.network('https://scr.vn/wp-content/uploads/2020/07/Avatar-m%E1%BA%B7c-%C4%91%E1%BB%8Bnh-m%C3%A0u-s%E1%BA%AFc.jpg');
  }

  Widget buildTextFields() {
    return Column(
      children: [
        const SizedBox(height: 16),
        MyTextField(
          controller: nameController,
          labelText: 'Họ & tên',
        ),
        const SizedBox(height: 16),
        MyTextField(
          controller: dateOfBirthController,
          labelText: 'Ngày sinh',
          keyboardType: TextInputType.datetime,
        ),
        const SizedBox(height: 16),
        MyTextField(controller: addressController, labelText: 'Địa chỉ'),
        const SizedBox(height: 16),
        MyTextField(
          labelText: 'Số điện thoại',
          hintText: apiService.user?.phoneNumber,
          readOnly: true,
        ),
        const SizedBox(height: 16),
        MyTextField(
          controller: emailController,
          labelText: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        const MyTextField(
          labelText: 'Gender',
        ),
      ],
    );
  }

  void apiUpdateProfile() {
    apiService
        .setProfile(
      name: nameController.text,
      address: addressController.text,
      avatar: url,
      dateOfBirth: dateOfBirthController.text,
      email: emailController.text,
    )
        .then((value) {
      value = apiService.user!;
      ToastOverlay(context).show(message: 'Thành công', type: ToastType.error);
    }).catchError((e) {
      ToastOverlay(context).show(message: e.toString(), type: ToastType.error);
    });
  }

  void showdialogAvt() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.grey.withOpacity(0.2),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      pageBuilder: (_, __, ___) {
        return Container(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                width: 300,
                height: 150,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Thay đổi ảnh đại diện',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Huy')),
                        ElevatedButton(
                            onPressed: () {}, child: const Text('Yes')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
//
// class MyAvtDialog extends StatefulWidget {
//   final Widget child;
//
//   const MyAvtDialog({super.key, required this.child});
//
//   @override
//   State<MyAvtDialog> createState() => _MyAvtDialogState();
// }
//
// class _MyAvtDialogState extends State<MyAvtDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: widget.child,
//     );
//   }
// }

import 'package:exercise_demo/comon/MyTextField.dart';
import 'package:exercise_demo/comon/Mybuttom.dart';
import 'package:exercise_demo/comon/toast_overlay.dart';
import 'package:exercise_demo/models/service/api_service.dart';
import 'package:exercise_demo/models/service/issue_service.dart';
import 'package:exercise_demo/models/service/photo_service.dart';
import 'package:exercise_demo/page/report/view/report_page.dart';
import 'package:exercise_demo/const/const.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddReportPage extends StatefulWidget {
  const AddReportPage({Key? key}) : super(key: key);

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  List<String> itemListSelected = [];
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  bool stateInit = true;
  final picker = ImagePicker();
  var listPhoto = StringBuffer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD Report'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportPage()),
                );
              },
              icon: const Icon(Icons.report))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTitleAddReport(),
                  const SizedBox(height: 16),
                  buildListImageAdded(),
                  const SizedBox(height: 16),
                  buildImageAdd(),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              buildOntapAdd()
            ],
          ),
        ),
      ),
    );
  }

  Future upLoadImage({required ImageSource source}) async {
    try {
      final image = await picker.pickImage(
        source: source,
        imageQuality: 100,
        preferredCameraDevice: CameraDevice.rear,
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
      itemListSelected.add('$baseUrl${value.path}');
      print('check xFile: $itemListSelected');
    }).catchError((e) {
      ToastOverlay(context).show(message: e.toString(), type: ToastType.error);
    });
  }

  Widget buildOntapAdd() {
    return MyButton(
      text: 'Them',
      backgroundColor: Colors.cyanAccent,
      textColor: Colors.black,
      onTap: () {
        convertToString();
        apiSetIssue();
        contentController.text = '';
        titleController.text = '';
        itemListSelected = [];
      },
    );
  }

  Widget buildTitleAddReport() {
    return Column(
      children: [
        Column(
          children: [
            MyTextField(
              controller: titleController,
              textAlign: TextAlign.center,
              hintText: 'Tiêu đề',
              labelText: 'Tiêu đề',
              maxLines: 1,
              minLines: 2,
            ),
            const SizedBox(
              height: 16,
            ),
            MyTextField(
              controller: contentController,
              hintText: 'hello',
              labelText: 'Noi dung',
              minLines: 5,
              maxLines: 10,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildListImageAdded() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: itemListSelected.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (_, index) {
        return ImageAdded(index);
      },
    );
  }

  Widget buildImageAdd() {
    return InkWell(
      onTap: showBottomSheet,
      child: SizedBox(
        height: 80,
        width: 80,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            'https://static.thenounproject.com/png/558642-200.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget ImageAdded(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        itemListSelected[index],
        fit: BoxFit.cover,
        width: 90,
        height: 90,
      ),
    );
  }

  Widget buildPopUp() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 200,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 10),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MyButton(
            text: "Camera",
            onTap: () {
              upLoadImage(source: ImageSource.camera);
            },
            textColor: Colors.black,
            backgroundColor: Colors.cyanAccent,
          ),
          MyButton(
            text: "Gallery",
            onTap: () {
              upLoadImage(source: ImageSource.gallery);
            },
            textColor: Colors.black,
            backgroundColor: Colors.cyanAccent,
          ),
        ],
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return buildPopUp();
      },
    );
  }

  void apiSetIssue() {
    print('so luong phan tu ${itemListSelected}');
    apiService
        .setIssue(
      title: titleController.text,
      content: contentController.text,
      photos: listPhoto.toString(),
    )
        .then((value) {
      ToastOverlay(context).show(message: 'Thanh cong', type: ToastType.error);
    }).catchError((e) {
      ToastOverlay(context).show(message: e.toString(), type: ToastType.error);
    });
  }


  void convertToString() {
    for (var item in itemListSelected) {
      if(item == itemListSelected.last){
        listPhoto.write(item);
        print(listPhoto);
        return;
      }
      listPhoto.write('$item|');
    }
  }
}

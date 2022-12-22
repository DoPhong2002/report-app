import 'dart:convert';

import 'package:exercise_demo/comon/MyAvt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class BigCubit extends Cubit<BigState> {
  BigCubit() : super(BigInitState());
  List<ReportModel> listAddReport = [];
  List<ReportModel> listReport = [];
  final listImage = <String>[];
  bool isEnable = false;



  //add json zo mảng model
  Future<List<MyAvt>> getMyAvts() async {
    final uri = Uri.parse('http://api.quynhtao.com/api/users');
    final response = await http.get(uri);
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body);
      return List<MyAvt>.from(json.map((e) => MyAvt.fromJson(e)));
    }

    throw Exception('Có lỗi xảy ra, http status code: ${response.statusCode}');
  }

  void addListReport(String itemTitle, String itemContent, List todo) {
    listAddReport.addAll(
      [
        ReportModel(
          urlPictureAvt: 'https://tinhte.vn/store/2016/10/3893837_1_1.jpg',
          urlPicture: todo,
          textContentReport: itemContent.toString(),
          textTitleReport: itemTitle.toString(),
        )
      ],
    );
    emit(BigState());
  }
}

class BigState {}

class BigInitState extends BigState {}

class ReportModel {
  String? textTitleReport;
  String? textContentReport;
  String? urlPictureAvt;
  List? urlPicture;

  ReportModel(
      {this.textContentReport,
      this.textTitleReport,
      this.urlPictureAvt,
      this.urlPicture});
}

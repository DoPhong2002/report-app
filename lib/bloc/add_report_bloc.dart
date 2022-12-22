import 'dart:async';

import 'package:exercise_demo/models/issue.dart';

class AddReportBloc {
  ///Them broadcast()  để có thể nhiều thằng có thể Stream được nó!
  final _AddReportStreamController = StreamController<Issue>.broadcast();

  Stream<Issue> get addImageStream => _AddReportStreamController.stream;

  Issue? issue;


}


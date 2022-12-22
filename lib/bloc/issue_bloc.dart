import 'dart:async';

import 'package:exercise_demo/models/issue.dart';
import 'package:exercise_demo/models/service/api_service.dart';
import 'package:exercise_demo/models/service/issue_service.dart';

class IssueBloc {
  ///Them broadcast()  để có thể nhiều thằng có thể Stream được nó!

  final _issueStreamController = StreamController<List<Issue>>.broadcast();

  Stream<List<Issue>> get streamIssue => _issueStreamController.stream;

  final issues = <Issue>[];

  IssueBloc() {
    getIssues();
  }

  ///API
  void getIssues() {
    apiService.getIssue(offset: issues.length).then((value) {
      if (value.isNotEmpty) {
        issues.addAll(value);
        _issueStreamController.add(issues);
      }
    }).catchError((e) {
      _issueStreamController.addError(e.toString());
    });
  }
}

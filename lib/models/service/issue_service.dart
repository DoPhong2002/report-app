import 'api_service.dart';
import '../issue.dart';

extension IssueService on APIService {
  Future<List<Issue>> getIssue({
    int limit = 5,
    required int offset,
  }) async {
    final result = await request(
      path: '/api/issues?limit=$limit&offset=$offset',
      method: Method.get,
    );

    final issues = List<Issue>.from(result.map((e) => Issue.fromJson(e)));
    return issues;
  }

  Future<List<Issue>> setIssue({
    required String title,
    required String content,
    required String photos,
  }) async {
    final body = {
      "Title": title,
      "Content": content,
      "Photos": photos,
    };
    final result = await request(
      path: '/api/issues',
      method: Method.post,
      body: body,
    );
    final issues = List<Issue>.from(result.map((e) => Issue.fromJson(e)));
    return issues;
  }
}

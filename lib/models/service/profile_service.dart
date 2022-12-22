import 'api_service.dart';
import '../issue.dart';

extension ProfileService on APIService {
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
}

import 'package:exercise_demo/models/photo.dart';
import 'package:image_picker/image_picker.dart';

import 'api_service.dart';

extension PhotoService on APIService {
  Future<Photo> upLoadAvatar({
    required XFile file,
  }) async {
    final result = await request(path: '/api/upload', file: file);
    final photo = Photo.fromJson(result);
    return photo;
  }
}

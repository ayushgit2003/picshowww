


import '../../../data/models/images/images.dart';

abstract class ImagesRepository {
  Future<List<ImagesModel>> getImages(int page, int limit);
}
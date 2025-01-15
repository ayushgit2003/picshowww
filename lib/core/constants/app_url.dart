
class AppUrl {

  static const String baseUrl = 'https://picsum.photos/v2';

  static String imagesList({int page = 7, int limit = 10}) {

    return '$baseUrl/list?page=$page&limit=$limit';
  }
}
class ImageRepository {
  static final ImageRepository _instance = ImageRepository._internal();
  ImageRepository._internal();

  factory ImageRepository() {
    return _instance;
  }

  final _images = List.generate(
    100,
    (index) {
      if (index > 49) {
        return 'https://w-dog.ru/wallpapers/10/17/498507816329484/gory-skaly-ozero-derevya-nebo-oblaka.jpg';
      }
      return 'https://w-dog.ru/wallpapers/5/18/379518920379901/kot-koshka-glaza-zhivotnoe.jpg';
    },
  );

  int get totalCount => _images.length;

  List<String> fetchImage(int offset, int size) {
    if (offset >= totalCount) return [];
    if (offset + size > totalCount) return _images.sublist(offset);
    return _images.sublist(offset, offset + size);
  }
}

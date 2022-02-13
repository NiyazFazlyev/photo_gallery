import 'package:flutter_test/flutter_test.dart';
import 'package:photo_gallery/repositories/image_repository.dart';

void main() {
  group('Image Repository fetchImage tests', () {
    test('Fetch images from start', () {
      final repository = ImageRepository();
      final images = repository.fetchImage(0, 10);
      expect(images.length, 10);
    });

    test('Fetch images (offset > totalCount)', () {
      final repository = ImageRepository();
      final images = repository.fetchImage(repository.totalCount + 1, 10);
      expect(images.length, 0);
    });

    test('Fetch images from end (offset + size > totalCount)', () {
      final repository = ImageRepository();
      final images = repository.fetchImage(repository.totalCount - 5, 10);
      expect(images.length, 5);
    });
  });
}

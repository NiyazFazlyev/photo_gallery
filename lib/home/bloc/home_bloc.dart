import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_gallery/repositories/image_repository.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

const pageSize = 10;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const _Initial()) {
    on<ImageFetched>(
      imageFetchedEventHanndler,
    );
    add(const ImageFetched());
  }

  Future<void> imageFetchedEventHanndler(ImageFetched event, Emitter<HomeState> emit) async {
    await state.map<Future<void>>(
      initial: (_) async {
        final images = await loadImages(0, pageSize);
        emit(Loaded(images, canLoadMore: images.length == pageSize));
      },
      loaded: (loadedState) async {
        final images = await loadImages(loadedState.images.length, pageSize);
        final newImages = [...loadedState.images, ...images];
        emit(Loaded(
          newImages,
          canLoadMore: images.length == pageSize,
        ));
      },
    );
  }

  Future<List<File?>> loadImages(int offset, int pageSize) async {
    final urls = ImageRepository().fetchImage(offset, pageSize);

    List<File?> data = [];
    for (var url in urls) {
      try {
        var file = await DefaultCacheManager().getSingleFile(url);
        data.add(file);
      } catch (e) {
        data.add(null);
      }
    }
    return data;
  }

  @override
  void onChange(Change<HomeState> change) {
    debugPrint('#HomeBloc# onChange: $change');
    super.onChange(change);
  }

  @override
  void onEvent(HomeEvent event) {
    debugPrint('#HomeBloc# onEvent: $event');
    super.onEvent(event);
  }
}

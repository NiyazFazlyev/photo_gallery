part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loaded(List<File?> images, {@Default(true) bool canLoadMore}) = Loaded;
}

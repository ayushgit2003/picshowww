
part of 'images_bloc.dart';

class ImagesState extends Equatable {

  final List<ImagesModel> images;
  final bool isLoadingMore;
  final bool hasReachedMax;
  final Status status;

  const ImagesState({
    this.images = const [],
    this.isLoadingMore = false,
    this.hasReachedMax = false,
    required this.status,
  });

  ImagesState copyWith({
    List<ImagesModel>? images,
    bool? isLoadingMore,
    bool? hasReachedMax,
    Status? status,
  }) {
    return ImagesState(
      images: images ?? this.images,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [images, isLoadingMore, hasReachedMax, status];
}



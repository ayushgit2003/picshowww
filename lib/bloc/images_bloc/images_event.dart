
part of 'images_bloc.dart';

abstract class ImagesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchImagesEvent extends ImagesEvent {
  final int limit;
  final int page;

  FetchImagesEvent({required this.page, required this.limit});

  @override
  List<Object?> get props => [page,limit];
}


import 'package:bloc/bloc.dart';
import '../../core/response/status.dart';
import '../../data/models/images/images.dart';
import '../../../domain/repository/images/images_repository.dart';
import 'package:equatable/equatable.dart';
part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final ImagesRepository repository;

  ImagesBloc({required this.repository})
      : super(ImagesState(status: Status.loading)) {
    on<FetchImagesEvent>(_fetchImages);
  }

  Future<void> _fetchImages(
      FetchImagesEvent event, Emitter<ImagesState> emit) async {
    if (state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final newImages = await repository.getImages(event.page, event.limit);
      final hasReachedMax = newImages.isEmpty;

      emit(
        state.copyWith(
          images: List.of(state.images)..addAll(newImages),
          hasReachedMax: hasReachedMax,
          isLoadingMore: false,
          status: Status.completed,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        isLoadingMore: false,
        status: Status.error,
      ));
    }
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/images_bloc/images_bloc.dart';
import '../../../core/components/error_widget.dart';
import '../../../core/response/status.dart';


/// A widget to display error messages related to image loading.
class ImageErrorWidget extends StatelessWidget {
  const ImageErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagesBloc, ImagesState>(
      buildWhen: (previous, current) => previous.images != current.images,
      builder: (context, state) {
        // Check if the error message indicates no internet connection
        if (Status.error.toString() == "No Internet Connection") {
          // Display InternetExceptionWidget if there's no internet connection
          return InterNetExceptionWidget(
            onPress: () {
              // Retry fetching images
              context.read<ImagesBloc>().add(FetchImagesEvent(page: 1, limit: 20));
            },
          );
        } else {
          // Display the error message as clickable text if it's not internet-related
          return InterNetExceptionWidget(
            onPress: () {
              // Retry fetching images
              context.read<ImagesBloc>().add(FetchImagesEvent(page: 1, limit: 20));
            },
          );
        }
      },
    );
  }
}
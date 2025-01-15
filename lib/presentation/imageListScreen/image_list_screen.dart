
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picshow/presentation/imageListScreen/widgets/image_grid_item.dart';
import 'package:picshow/presentation/imageListScreen/widgets/images_error_widget.dart';
import '../../bloc/images_bloc/images_bloc.dart';
import '../../core/response/status.dart';
import '../../data/repository/local/cacheManager/custom_cache_manager.dart';
import '../fullScreenImageView/full_screen_image_view.dart';

class ImagesScreen extends StatefulWidget {
  @override
  _ImagesScreenState createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  final int _limit = 20;

  @override
  void initState() {
    super.initState();
    context.read<ImagesBloc>().add(FetchImagesEvent(page: _page, limit: _limit));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent &&
          !context.read<ImagesBloc>().state.isLoadingMore &&
          !context.read<ImagesBloc>().state.hasReachedMax) {
        _page++;
        context.read<ImagesBloc>().add(FetchImagesEvent(page: _page, limit: _limit));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Gallery'),
      ),
        body:BlocBuilder<ImagesBloc, ImagesState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.loading:
                if (state.images.isEmpty) {
                  // Show loading indicator when data is being fetched initially
                  return Center(
                    child: CircularProgressIndicator(color: Colors.grey[800]),
                  );
                }
                break;

              case Status.error:
                return ImageErrorWidget();

              case Status.completed:

                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                      ),
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {

                          return ImageGridItem(image: state.images[index], );
                        },
                        childCount: state.images.length,
                      ),
                    ),
                    if (state.isLoadingMore)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(60.0),
                          child: Center(
                            child: CircularProgressIndicator(color: Colors.grey[800]),
                          ),
                        ),
                      ),
                  ],
                );
            }
            return SizedBox.shrink();
          },
        ),
    );
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    // super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:picshow/presentation/fullScreenImageView/full_screen_image_view.dart';
import '../../../data/repository/local/cacheManager/custom_cache_manager.dart';



class ImageGridItem extends StatefulWidget {
  final dynamic image; // Replace `dynamic` with the appropriate type


  const ImageGridItem({Key? key, required this.image}) : super(key: key);

  @override
  _ImageGridItemState createState() => _ImageGridItemState();
}

class _ImageGridItemState extends State<ImageGridItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImageViewer(

              imageUrl: widget.image.downloadUrl,
            ),
          ),
        );
      },
      child: CachedNetworkImage(
        cacheManager: CustomCacheManager(),
        imageUrl: widget.image.downloadUrl,
        placeholder: (context, url) => Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.cloud_off,
                  color: Colors.red,
                  size: 40.0,
                ),
                Text("No Internet Connection"),
              ],
            ),
          ),
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}

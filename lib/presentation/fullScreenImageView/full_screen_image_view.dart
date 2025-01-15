import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class FullScreenImageViewer extends StatefulWidget {
  final String imageUrl;


  const FullScreenImageViewer({Key? key, required this.imageUrl, }) : super(key: key);

  @override
  _FullScreenImageViewerState createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 1.0,
          maxScale: 10.0,
          child: CachedNetworkImage( imageUrl:widget.imageUrl,fit: BoxFit.contain,),

        ),
      ),
    );
  }
}


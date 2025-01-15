
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picshow/presentation/imageListScreen/image_list_screen.dart';

import 'bloc/images_bloc/images_bloc.dart';
import 'di/injection_container.dart';

void main() {
  setup(); // Initialize dependency injection
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImagesBloc>(
          create: (_) => sl<ImagesBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Image Gallery',
        home: ImagesScreen(),
      ),
    );
  }
}

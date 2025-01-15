import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class InterNetExceptionWidget extends StatelessWidget {
  final VoidCallback onPress;
  const InterNetExceptionWidget({Key? key, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off,
              color: Colors.red,
              size: 100,
            ),
            const SizedBox(height: 20),
            Text(
              "We’re unable to show images \nPlease check your internet connection.",
            textAlign: TextAlign.center,
              style:  TextStyle(color: Colors.black,fontSize: 20)
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: onPress,
              child: const Text('Retry',style: TextStyle(color: Colors.black),),
            ),
          ],
        ),
      ),
    );
  }
}
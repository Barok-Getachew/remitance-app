import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NetworkDisconnectScreen extends StatelessWidget {
  const NetworkDisconnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Icon(
            Icons.cloud_off_rounded,
            size: 12.h,
          )),
          SizedBox(height: 2.h),
          Text(
            'No Internet Connection',
            style: TextStyle(
              fontSize: 19.sp,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Trying to connect...',
            style: TextStyle(
              fontSize: 17.sp,
            ),
          ),
        ],
      ),
    );
  }
}

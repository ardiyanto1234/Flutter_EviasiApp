import 'package:flutter/material.dart';

class OrderinAppConstant {
  static String baseURL = "http://efiasi.tifnganjuk.com/api/apieviasi";
  static String productgetURL = '${OrderinAppConstant.baseURL}/dataproduct';
  static String uploadURL = '${OrderinAppConstant.baseURL}/uploadproduct';
  static String updateURL = '${OrderinAppConstant.baseURL}/product';

   static void showLoading({
    required BuildContext context,
    bool canPop = false,
    Color loadingColor = Colors.red,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => canPop,
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
              ),
            ),
          ),
        );
      },
     );
}
}

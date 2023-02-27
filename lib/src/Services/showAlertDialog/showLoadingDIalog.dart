import 'package:flutter/cupertino.dart';

showAlertLoading(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        content: CupertinoActivityIndicator(),
      );
    },
  );
}

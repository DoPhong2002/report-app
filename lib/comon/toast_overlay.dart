import 'package:flutter/material.dart';

class ToastOverlay {
  final BuildContext context;
  OverlayEntry? overlayEntry;

  ToastOverlay(this.context);

  void show({
    required String message,
    required ToastType type,
    Duration duration = const Duration(seconds: 5),
  }) {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }

    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        top: 64,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.orange,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(message),
                ),
                IconButton(
                  onPressed: () {
                    // Navigator.of(context).pop();
                    print(overlayEntry);
                    if (overlayEntry != null) {
                      overlayEntry!.remove();
                      overlayEntry = null;
                    }
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
          ),
        ),
      );
    });

    if (overlayEntry != null) {
      Overlay.of(context)!.insert(overlayEntry!);
      Future.delayed(duration, () {
        if (overlayEntry != null) {
          overlayEntry!.remove();
          overlayEntry = null;
        }
      });
    }
  }
}

enum ToastType {
  success,
  warning,
  info,
  error,
}

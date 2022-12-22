import 'package:flutter/material.dart';

import 'Mybuttom.dart';

void showConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String confirm,
  required String unConfirm,
  required VoidCallback onConfirm,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.grey.withOpacity(0.2),
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    pageBuilder: (_, __, ___) {
      return Container(
        alignment: Alignment.center,
        child: Material(
          color: Colors.transparent,
          child: ComfirmDialog(
            title: title,
            message: message,
            textComfirm: confirm,
            textUnConfirm: unConfirm,
            onComfirm: onConfirm,
          ),
        ),
      );
    },
  );
}

class ComfirmDialog extends StatefulWidget {
  final String title;
  final String message;
  final String textComfirm;
  final String textUnConfirm;
  final VoidCallback onComfirm;

  const ComfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.textComfirm,
    required this.textUnConfirm,
    required this.onComfirm,
  });

  @override
  State<ComfirmDialog> createState() => _ComfirmDialogState();
}

class _ComfirmDialogState extends State<ComfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            width: 300,
            height: 150,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title, style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),),
                Text(widget.message),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Expanded(
                      child: MyButton(
                          text: widget.textUnConfirm,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          onTap: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    Expanded(
                      child: MyButton(
                          text: widget.textComfirm,
                          backgroundColor: Colors.cyanAccent,
                          textColor: Colors.white,
                          onTap: widget.onComfirm),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

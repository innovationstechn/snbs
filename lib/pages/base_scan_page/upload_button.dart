import 'package:flutter/material.dart';

class UploadButton extends StatefulWidget {
  final Future Function() onTap;

  UploadButton({required this.onTap});

  @override
  _UploadButtonState createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        setState(() {
          uploading = true;
        });

        await widget.onTap();

        setState(() {
          uploading = false;
        });
      },
      label: Text("FINISH/SEND"),
      icon: uploading
          ? SizedBox(
              height: 25,
              width: 25,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            )
          : Icon(Icons.cloud_upload_rounded),
    );
  }
}

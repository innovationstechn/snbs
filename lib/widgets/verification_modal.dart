import 'package:flutter/material.dart';

class VerificationModal extends StatelessWidget {
  final TextEditingController _textEditingController;
  final String _barcode;
  final Function(String) onVerified;
  final Function() onRetake;

  VerificationModal(
      {required String barcode,
      required this.onVerified,
      required this.onRetake})
      : _textEditingController = TextEditingController(text: barcode),
        this._barcode = barcode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 5),
            Text(
              "Verify Scanned Barcode",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 5.0),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () => onRetake(),
                    child: Text("RETAKE"),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () => onVerified(_textEditingController.text),
                    child: Text("FINISH"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

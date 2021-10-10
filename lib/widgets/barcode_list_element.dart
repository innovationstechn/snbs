import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BarcodeListElement extends StatelessWidget {
  final String barcode;
  final int index;
  final Function(int) onTap;
  final Function(int) onDelete;
  final Function(int) onUpdate;
  const BarcodeListElement(
      {required this.index,
      required this.barcode,
      required this.onTap,
      required this.onDelete,
      required this.onUpdate,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(index),
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),
        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (_) => onDelete(index),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (_) => print('Change  pressed'),
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.loop,
            label: 'Loop',
          ),
        ],
      ),
      child: ListTile(
        onTap: () => onTap(index),
        leading: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor, shape: BoxShape.circle),
          padding: EdgeInsets.all(10),
          child: Text(
            (index + 1).toString(),
            style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: Colors.white, fontSize: 16) ??
                Theme.of(context).textTheme.caption,
          ),
        ),
        title: Text(barcode),
      ),
    );
  }
}

import 'package:access_control/src/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class PCustomModalBottom {
  final BuildContext context;
  final IconData icon;
  final String modalTitle;
  final Widget modalBody;
  final bool isLoader;
  final bool isScrollControlled;
  final bool enableDrag;
  final Widget actionsWidget;
  final double iconSize;
  final Color color;

  const PCustomModalBottom({
    required this.context,
    required this.icon,
    required this.modalTitle,
    required this.modalBody,
    this.isScrollControlled = false,
    this.isLoader = false,
    this.enableDrag = false,
    this.actionsWidget = const Center(),
    this.iconSize = 50,
    this.color = Colors.blueGrey,
  });

  void show() => showModalBottomSheet(
        enableDrag: enableDrag,
        showDragHandle: enableDrag,
        isScrollControlled: isScrollControlled,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        builder: (BuildContext bc) {
          return PCustomContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Column(
                  children: [
                    Icon(icon, size: iconSize, color: color),
                    const SizedBox(height: 12),
                    Text(
                      modalTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    isLoader ? const LinearProgressIndicator() : const Center(),
                    const SizedBox(height: 12),
                    modalBody,
                  ],
                ),
                PCustomContainer(
                  child: actionsWidget,
                ),
              ],
            ),
          );
        },
      );

  void hide() => Navigator.pop(context);
}

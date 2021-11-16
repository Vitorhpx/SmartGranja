import 'package:flutter/material.dart';

enum SpacerSize { small, medium, large }

class BlankSpacer extends StatelessWidget {
  final SpacerSize _size;

  const BlankSpacer(
      this._size, {
        Key? key,
      }) : super(key: key);

  double _getHeightValue(SpacerSize size) {
    switch (size) {
      case SpacerSize.small:
        return 10;
      case SpacerSize.medium:
        return 20;
      case SpacerSize.large:
        return 30;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: this._getHeightValue(this._size));
  }
}
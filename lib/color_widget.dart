import 'package:flutter/material.dart';
import 'package:inherited_model_example/main.dart';

class ColorWidget extends StatelessWidget {

  final AvailableColors color;
  const ColorWidget({Key? key,required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final provider = AvailableColorModel.of(context, color);

    switch(color){

      case AvailableColors.one:
        print("rebuild color1");
        break;
      case AvailableColors.two:
        print("rebuild color2");
        break;
    }
    return Container(
      height: 100,
      color: color == AvailableColors.two ? provider?.colors2 : provider?.colors1,
    );
  }
}

// built a container with width 70 heigh 2 container

import 'package:flutter/material.dart';

class Connector extends StatelessWidget {
  double width = 30;
  Connector({super.key, this.width = 46});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width as double,
      height: 2,
      color: const Color.fromARGB(255, 159, 155, 155),
    );
  }
}

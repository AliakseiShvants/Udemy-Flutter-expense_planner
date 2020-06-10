import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'No data',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 300,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            )),
      ],
    );
  }
}

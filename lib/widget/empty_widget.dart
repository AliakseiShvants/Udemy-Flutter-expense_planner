import 'package:expense_planner/utils/constants.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {

  const EmptyWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          Constants.NO_DATA,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        const SizedBox(
          height: Constants.SIZED_BOX_HEIGHT,
        ),
        Container(
          height: Constants.ASSET_HEIGHT,
          child: Image.asset(
            Constants.ASSET,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

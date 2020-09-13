import 'package:expense_planner/utils/constants.dart';
import 'package:flutter/material.dart';

class ChartBarWidget extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBarWidget(
      this.label, this.spendingAmount, this.spendingPctOfTotal,);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: constraints.maxHeight * Constants.CHART_BAR_TEXT_HEIGHT,
              child: FittedBox(
                child: Text(
                  '\$${spendingAmount.toStringAsFixed(0)}',
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * Constants.CHART_BAR_SIZE_BOX,
            ),
            Container(
              height: constraints.maxHeight *
                  Constants.CHART_BAR_MAIN_CONTAINER_HEIGHT,
              width: Constants.CHART_BAR_MAIN_CONTAINER_WIDTH,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey, width: Constants.BORDER_WIDTH),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius:
                          BorderRadius.circular(Constants.BORDER_RADIUS),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius:
                            BorderRadius.circular(Constants.BORDER_RADIUS),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * Constants.CHART_BAR_SIZE_BOX,
            ),
            Container(
              height: constraints.maxHeight * Constants.CHART_BAR_TEXT_HEIGHT,
              child: FittedBox(
                child: Text(
                  label,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

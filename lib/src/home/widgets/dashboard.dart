import 'package:access_control/src/constants/constants.dart';
import 'package:access_control/src/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/incomes_provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    final incomesProvider = Provider.of<IncomesProvider>(context);

    return PCustomContainer(
      height: 150,
      color: Colors.blueGrey.shade50,
      marginTop: 25,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              AppSpanishLabels.collaboratorsToday,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
          ),
          Center(
            child: Text(
              '🧑‍🏭 ${incomesProvider.numberOfCollaborators}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}

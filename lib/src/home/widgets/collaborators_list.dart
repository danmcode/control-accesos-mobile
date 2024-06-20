import 'package:access_control/src/constants/app_spanish_labels.dart';
import 'package:access_control/src/models/incomes.dart';
import 'package:access_control/src/providers/incomes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollaboratorList extends StatefulWidget {
  const CollaboratorList({super.key});

  @override
  State<CollaboratorList> createState() => _CollaboratorListState();
}

class _CollaboratorListState extends State<CollaboratorList> {
  @override
  Widget build(BuildContext context) {
    final incomesProvider =
        Provider.of<IncomesProvider>(context, listen: false);

    incomesProvider.loadIncomes(context);
    List<Datum> incomes = incomesProvider.incomesList;

    return Container(
      padding: const EdgeInsets.all(9),
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(AppSpanishLabels.collaboratorList),
              IconButton(
                onPressed: () {
                  incomesProvider.loadIncomes(context);
                  incomes = incomesProvider.incomesList;
                },
                icon: const Icon(Icons.sync),
              ),
            ],
          ),
          const Divider(),
          (incomes.isEmpty)
              ? const Center(
                  child: Text('Esperando información...'),
                )
              : SizedBox(
                  height: 450,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: incomes.length,
                    itemBuilder: (context, int index) {
                      return ListTile(
                        title: Text(incomes[index].fullName),
                        subtitle: Text(incomes[index].dateTimeIn.toString()),
                      );
                    },
                    separatorBuilder: (_, __) {
                      return const Divider();
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

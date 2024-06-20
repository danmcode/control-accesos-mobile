import 'dart:convert';
import 'package:access_control/src/constants/app_spanish_labels.dart';
import 'package:access_control/src/home/repository/fetch_collaborator_attendance.dart';
import 'package:access_control/src/providers/providers.dart';
import 'package:access_control/src/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../../custom_widgets/custom_widgets.dart';

class ScanButton extends StatefulWidget {
  const ScanButton({super.key});

  @override
  State<ScanButton> createState() => _ScanButtonState();
}

class _ScanButtonState extends State<ScanButton> {
  @override
  Widget build(BuildContext context) {
    final identificationProvider = Provider.of<IdentificationProvider>(context);
    final incomesProvider =
        Provider.of<IncomesProvider>(context, listen: false);

    return FloatingActionButton(
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          AppColors.mainColorStr,
          AppSpanishLabels.cancel,
          false,
          ScanMode.QR,
        );

        if (barcodeScanRes == '-1') return;

        String scanDecode = utf8.decode(base64.decode(barcodeScanRes));
        double identification = double.parse(scanDecode);

        identificationProvider.identification =
            identification.toStringAsFixed(0);
        if (!context.mounted) return;
        PCustomModalBottom loaderModal = _loaderModal(
          context: context,
          identificationProvider: identificationProvider,
        );
        loaderModal.show();
        final response = await FetchCollaboratorAttendance.fetchData(
          identification: identificationProvider.identification!,
        );

        switch (response['status']) {
          case 200:
            loaderModal.hide();
            if (!context.mounted) return;
            incomesProvider.loadIncomes(context);
            _collaboratorLoaded(
                    context: context,
                    user: response['user'] ?? '',
                    message: response['message'])
                .show();
          case 400:
            loaderModal.hide();
            if (!context.mounted) return;
            _errorLoader(
              context: context,
              message: response['error'],
            ).show();
            return;
          case 504:
            loaderModal.hide();
            if (!context.mounted) return;
            _errorLoader(
              context: context,
              message: AppSpanishLabels.couldntConnectToServer,
            ).show();
            return;
          default:
            loaderModal.hide();
            if (!context.mounted) return;
            _errorLoader(
              context: context,
              message: AppSpanishLabels.couldntConnectToServer,
            ).show();
            return;
        }
      },
      child: const Icon(Icons.qr_code_scanner_rounded),
    );
  }
}

_loaderModal({
  required BuildContext context,
  required IdentificationProvider identificationProvider,
}) {
  return PCustomModalBottom(
    context: context,
    icon: Icons.access_time,
    modalTitle: AppSpanishLabels.loadingCollaboratorInformation,
    isLoader: true,
    modalBody: const Text(AppSpanishLabels.pleaseWait),
  );
}

_errorLoader({required BuildContext context, required message}) {
  return PCustomModalBottom(
    enableDrag: true,
    context: context,
    icon: Icons.error,
    color: AppColors.errorColor,
    modalTitle: message,
    modalBody: const Text(AppSpanishLabels.tryAgain),
    actionsWidget: PCustomContainer(
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        child: const Text(AppSpanishLabels.goBack),
      ),
    ),
  );
}

_collaboratorLoaded({
  required BuildContext context,
  required user,
  required message,
}) {
  return PCustomModalBottom(
    enableDrag: true,
    context: context,
    isScrollControlled: true,
    icon: Icons.check,
    color: AppColors.successColor,
    modalTitle: AppSpanishLabels.loadedCollaboratorInformation,
    modalBody: PCustomContainer(
      height: 120,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(message),
              subtitle: Text('${AppSpanishLabels.fromCollaborator}: $user'),
            )
          ],
        ),
      ),
    ),
    actionsWidget: PCustomContainer(
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        child: const Text(AppSpanishLabels.goBack),
      ),
    ),
  );
}

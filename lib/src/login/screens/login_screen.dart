import 'package:access_control/src/Home/home.dart';
import 'package:access_control/src/constants/constants.dart';
import 'package:access_control/src/custom_widgets/custom_widgets.dart';
import 'package:access_control/src/helpers/helpers.dart';
import 'package:access_control/src/providers/auth_provider.dart';
import 'package:access_control/src/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Control de accesos'),
      ),
      body: Center(
        child: PCustomContainer(
          marginTop: 20,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _pageTitle(title: 'Iniciar Sesión'),
                const SizedBox(height: 40),
                _loginForm(authProvider: authProvider),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    if (!authProvider.isValidForm()) return;
                    FocusScope.of(context).unfocus();
                    _modalLoginLoading(context: context).show();

                    final response = await authProvider.login(
                      authProvider.username,
                      authProvider.password,
                    );

                    switch (response['status']) {
                      case 200:
                        if (!context.mounted) return;
                        _modalLoginLoading(context: context).hide();

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const HomeScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );

                      case 400:
                        if (!context.mounted) return;
                        _modalLoginLoading(context: context).hide();
                        _errorLoader(
                          context: context,
                          message: 'Usuario o contraseñas incorrectos',
                        ).show();
                        return;
                      case 504:
                        if (!context.mounted) return;
                        _modalLoginLoading(context: context).hide();
                        _errorLoader(
                          context: context,
                          message: AppSpanishLabels.couldntConnectToServer,
                        ).show();
                        return;
                      default:
                        if (!context.mounted) return;
                        _modalLoginLoading(context: context).hide();
                        _errorLoader(
                          context: context,
                          message: AppSpanishLabels.couldntConnectToServer,
                        ).show();
                        return;
                    }
                  },
                  child: const Text('Acceder'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_pageTitle({required String title}) => Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );

_loginForm({
  required AuthProvider authProvider,
}) {
  return Form(
    key: authProvider.formKey,
    child: Column(
      children: [
        PTextFormField(
          hintText: 'Nombre de usuario',
          labelText: 'Nombre de usuario',
          prefixIcon: Icons.person,
          isPasswordField: false,
          validator: (value) => InputValidations.validateServerDirection(value),
          keyboardType: TextInputType.text,
          onchange: (value) => authProvider.username = value!.trim(),
        ),
        const SizedBox(height: 12),
        PTextFormField(
          hintText: 'Contraseña',
          labelText: 'Contraseña',
          prefixIcon: Icons.lock,
          isPasswordField: true,
          validator: (value) => InputValidations.validateServerDirection(value),
          keyboardType: TextInputType.text,
          onchange: (value) => authProvider.password = value!.trim(),
        ),
      ],
    ),
  );
}

_modalLoginLoading({required BuildContext context}) {
  return PCustomModalBottom(
    context: context,
    icon: Icons.door_front_door,
    modalTitle: 'Iniciando sesión',
    isLoader: true,
    modalBody: const Column(
      children: [
        Text(AppSpanishLabels.pleaseWait),
      ],
    ),
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

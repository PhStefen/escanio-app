import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/components/loading.dart';
import 'package:escanio_app/extensions/context_extension.dart';
import 'package:escanio_app/services/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;

  Future _signIn(bool googleSignIn) async {
    setState(() {
      loading = true;
    });
    await (googleSignIn
        ? AuthService.signInGoogle()
        : AuthService.signInAnonymously());

    FirebaseFirestore.instance
        .collection("users")
        .doc(AuthService.user!.uid)
        .set({});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: loading
              ? const Loading()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 44),
                          child: SvgPicture.asset(
                            context.logoPath,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            LoginPageButton(
                              onPressed: () => _signIn(false),
                              label: "Continuar como anônimo",
                              iconPath: "images/logo_incognito.svg",
                            ),
                            const SizedBox(height: 20),
                            if (!kIsWeb) ...[
                              LoginPageButton(
                                onPressed: () => _signIn(true),
                                label: "Continuar como Google",
                                iconPath: "images/logo_google.svg",
                              ),
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class LoginPageButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final String iconPath;
  const LoginPageButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          context.isDarkMode
              ? context.theme.cardColor
              : context.theme.colorScheme.primary,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 4, left: 8, top: 8, bottom: 8),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Text(label),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(
                  iconPath,
                  height: 32,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

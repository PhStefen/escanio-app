import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escanio_app/extensions/context_extension.dart';
import 'package:escanio_app/models/history_model.dart';
import 'package:escanio_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserPage extends StatefulWidget {
  final List<HistoryModel> history;
  final void Function() onBack;
  final void Function() onFavourite;
  final void Function() onHistory;
  const UserPage(
      {super.key,
      required this.history,
      required this.onBack,
      required this.onFavourite,
      required this.onHistory});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final currentUser = AuthService.user;

  //Criar produtos
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  color: context.theme.colorScheme.primary,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(top: 40),
                      child: Text(
                        currentUser!.isAnonymous
                            ? 'Anônimo'
                            : FirebaseAuth.instance.currentUser!.displayName
                                .toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
            Positioned(
              child: ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(132 / 2),
                    color: Colors.white,
                  ),
                  height: 132,
                  width: 132,
                  padding: currentUser!.isAnonymous
                      ? const EdgeInsets.all(16)
                      : null,
                  child: currentUser!.isAnonymous
                      ? SvgPicture.asset(
                          "images/logo_incognito.svg",
                          height: 132,
                        )
                      : Image.network(
                          FirebaseAuth.instance.currentUser!.photoURL
                              .toString(),
                          fit: BoxFit.cover,
                          height: 132,
                          width: 132,
                        ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                color: Colors.white,
                onPressed: widget.onBack,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UserPageButton(
                  onPressed: widget.onFavourite,
                  label: "Favoritos",
                  icon: Icons.favorite_rounded,
                  counter: widget.history
                      .where((element) => element.isFavourite)
                      .length,
                ),
                const SizedBox(
                  height: 8,
                ),
                UserPageButton(
                  onPressed: widget.onHistory,
                  label: "Histórico",
                  icon: Icons.history_rounded,
                  counter: widget.history.length,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: UserPageButton(
                        onPressed: AuthService.signOut,
                        label: "Sair",
                        icon: Icons.logout_rounded,
                        backgroundColor: context.theme.cardColor == Colors.white
                            ? context.theme.colorScheme.primary
                            : context.theme.cardColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class UserPageButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final IconData icon;
  final int? counter;
  final Color? backgroundColor;
  const UserPageButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
    this.counter,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    var bgColor = backgroundColor ?? context.theme.colorScheme.primary;

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(bgColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 4, left: 8, top: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(label),
            Wrap(
              spacing: 8,
              children: [
                if (counter != null) Text(counter.toString()),
                Icon(icon),
              ],
            )
          ],
        ),
      ),
    );
  }
}

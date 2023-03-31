import 'package:flutter/material.dart';

class CircleImageButton extends StatelessWidget {
  final ImageProvider image;
  final void Function()? onTap;
  const CircleImageButton({
    super.key,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundImage: image,
            ),
          ),
        ),
      ),
    );
  }
}

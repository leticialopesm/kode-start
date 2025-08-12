import 'package:flutter/material.dart';

const kPurple = Color(0xFF87A1FA);

class CharacterCard extends StatelessWidget {
  final int id;
  final String name;
  final String imageUrl;
  final VoidCallback? onTap;

  const CharacterCard({
    super.key,
    required this.id,
    required this.name,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero da miniatura (lista)
                Hero(
                  tag: 'char-$id',
                  transitionOnUserGestures: true,
                  child: AspectRatio(
                    aspectRatio: 16 / 9, // ~320x180
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  color: kPurple,
                  child: Text(
                    name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      letterSpacing: 1.0,
                    ),
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

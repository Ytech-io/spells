import 'package:flutter/material.dart';
import 'package:spells/data/spell.dart';

class SpellCard extends StatelessWidget {
  const SpellCard({Key? key, required this.spell}) : super(key: key);

  final Spell spell;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            spell.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(spell.description)
        ]),
      ),
    );
  }
}

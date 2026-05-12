import 'dart:math';
import 'package:flutter/material.dart';
import 'package:party_games/dinner_roulette/ingredients.dart';

class DinnerRoulettePage extends StatefulWidget {
  const DinnerRoulettePage({super.key});

  @override
  State<DinnerRoulettePage> createState() => _DinnerRoulettePageState();
}

class _DinnerRoulettePageState extends State<DinnerRoulettePage> {
  final _random = Random();
  String? _protein;
  List<String> _veggies = [];
  String? _carb;

  @override
  void initState() {
    super.initState();
    _spin();
  }

  TableRow _ingredientRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
          child: Text(
            '$label:',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
          child: Text(value, style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  void _spin() {
    final shuffledVeggies = List<String>.from(vegetables)..shuffle(_random);
    setState(() {
      _protein = proteins[_random.nextInt(proteins.length)];
      _veggies = shuffledVeggies.take(2).toList();
      _carb = carbs[_random.nextInt(carbs.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dinner Roulette'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.restaurant, size: 72, color: Colors.deepPurple),
            const SizedBox(height: 24),
            const Text(
              'Dinner Roulette',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 400,
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
                  child: Table(
                    defaultColumnWidth: const IntrinsicColumnWidth(),
                    children: [
                      _ingredientRow('Protein', _protein!),
                      _ingredientRow('Veggies', _veggies.join(' & ')),
                      _ingredientRow('Carb', _carb!),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _spin,
              icon: const Icon(Icons.local_dining),
              label: const Text('Spin Again'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/lek_provider.dart';
import 'add_lek_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final leki = context.watch<LekProvider>().leki;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Moja Apteczka'),
      ),
      body: leki.isEmpty
          ? const Center(child: Text('Brak zapisanych leków'))
          : ListView.builder(
              itemCount: leki.length,
              itemBuilder: (context, index) {
                final lek = leki[index];
                final isExpired = lek.dataWaznosci.isBefore(DateTime.now());
                return ListTile(
                  title: Text(lek.nazwa),
                  subtitle: Text(
                    'Ilość: ${lek.ilosc}, Ważne do: ${DateFormat.yMMMd().format(lek.dataWaznosci)}',
                    style: TextStyle(
                      color: isExpired ? Colors.red : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => context.read<LekProvider>().usunLek(lek.id!),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DodajLekScreen()),
        ),
      ),
    );
  }
}

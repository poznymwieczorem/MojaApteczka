import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lek.dart';
import '../providers/lek_provider.dart';

class DodajLekScreen extends StatefulWidget {
  const DodajLekScreen({super.key});

  @override
  State<DodajLekScreen> createState() => _DodajLekScreenState();
}

class _DodajLekScreenState extends State<DodajLekScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nazwaController = TextEditingController();
  final _iloscController = TextEditingController();
  final _opisController = TextEditingController();
  DateTime? _wybranaData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dodaj lek')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nazwaController,
                decoration: const InputDecoration(labelText: 'Nazwa leku'),
                validator: (value) => value!.isEmpty ? 'Podaj nazwę' : null,
              ),
              TextFormField(
                controller: _iloscController,
                decoration: const InputDecoration(labelText: 'Ilość'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Podaj ilość' : null,
              ),
              TextFormField(
                controller: _opisController,
                decoration: const InputDecoration(labelText: 'Opis (opcjonalnie)'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _wybranaData == null
                          ? 'Wybierz datę ważności'
                          : 'Data: ${_wybranaData!.toLocal().toString().split(' ')[0]}',
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      final now = DateTime.now();
                      final data = await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: now,
                        lastDate: DateTime(now.year + 10),
                      );
                      if (data != null) {
                        setState(() {
                          _wybranaData = data;
                        });
                      }
                    },
                  )
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Zapisz'),
                onPressed: () {
                  if (_formKey.currentState!.validate() && _wybranaData != null) {
                    final lek = Lek(
                      id: null,
                      nazwa: _nazwaController.text,
                      ilosc: int.parse(_iloscController.text),
                      dataWaznosci: _wybranaData!,
                      opis: _opisController.text,
                    );
                    context.read<LekProvider>().dodajLek(lek);
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:crud_app/nutricionista/nutricionista_controller.dart';
import 'package:crud_app/nutricionista/nutricionista_modelo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NutricionistaForm extends StatefulWidget {
  NutricionistaModelo? nutricionistaSelecionado;

  NutricionistaForm({super.key, this.nutricionistaSelecionado});

  @override
  _NutricionistaFormState createState() => _NutricionistaFormState(nutricionistaSelecionado);
}

class _NutricionistaFormState extends State<NutricionistaForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DateFormat formatoData = DateFormat('dd/MM/yyyy');

  String nome = '';
  DateTime? dataNascimento;
  String email = '';
  String telefone = '';
  String endereco = '';
  int? id;

  _NutricionistaFormState(NutricionistaModelo? nutricionista) {
    if (nutricionista != null) {
      nome = nutricionista.nome;
      dataNascimento = nutricionista.dataNascimento;
      email = nutricionista.email;
      telefone = nutricionista.telefone;
      endereco = nutricionista.endereco;
      id = nutricionista.id;
    }
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? selecionado = await showDatePicker(
      context: context,
      initialDate: dataNascimento ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selecionado != null && selecionado != dataNascimento) {
      setState(() {
        dataNascimento = selecionado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final nutricionistaController = Provider.of<NutricionistaController>(context);
    final dataNascimentoFormatada = dataNascimento == null ? '' : formatoData.format(dataNascimento!);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar Nutricionista'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: nome,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Informe o nome';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      nome = value!;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          decoration: const InputDecoration(labelText: 'Data de Nascimento'),
                          controller: TextEditingController(text: dataNascimentoFormatada),
                          validator: (value) {
                            if (dataNascimento == null) {
                              return 'Selecione a data de nascimento';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () {
                          _selecionarData(context);
                        },
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: email,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: telefone,
                    decoration: const InputDecoration(labelText: 'Telefone'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o telefone';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      telefone = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: endereco,
                    decoration: const InputDecoration(labelText: 'Endereço'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o endereço';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      endereco = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        nutricionistaController.salvar(NutricionistaModelo(
                          nome: nome,
                          email: email,
                          dataNascimento: dataNascimento!,
                          telefone: telefone,
                          endereco: endereco,
                          id: id,
                        ));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

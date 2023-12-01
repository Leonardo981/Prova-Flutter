import 'package:flutter/material.dart';

class NavegacaoController extends ChangeNotifier {
  int _telaSelecionada = 0;

  int get telaSelecionada => _telaSelecionada;

  void atualizarTelaSelecionada(int index) {
    _telaSelecionada = index;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

/// Helper functions para usos gerais.
class THelperFunctions {
  /// Obter a safe area superior do dispositivo.
  static double getTopSafeArea(BuildContext context) {
    return MediaQuery.of(context).viewPadding.top;
  }

  /// Obter a safe area inferior do dispositivo.
  static double getBottomSafeArea(BuildContext context) {
    return MediaQuery.of(context).viewPadding.bottom;
  }

  /// Navegar para a tela fornecida.
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  /// Truncar o texto se exceder o comprimento máximo informado.
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return "${text.substring(0, maxLength)}...";
    }
  }

  /// Verificar se o modo escuro está ativado.
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Remover elementos duplicados de uma lista.
  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  /// Agrupar widgets em linhas com o tamanho especificado.
  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
        i,
        (i + rowSize > widgets.length) ? widgets.length : (i + rowSize),
      );
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }
}

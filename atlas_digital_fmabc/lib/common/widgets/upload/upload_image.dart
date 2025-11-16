import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';
import 'package:tar/tar.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

class UploadImage extends StatelessWidget {
  const UploadImage({super.key});

  Future<void> _getDirectory(BuildContext context) async {
    const String confirmButtonText = "Confirmar";
    final String? directoryPath = await getDirectoryPath(
      confirmButtonText: confirmButtonText,
    );
    if (directoryPath == null) {
      return;
    }
    final directory = Directory(directoryPath);
    final outputFileName = "${p.dirname(directoryPath)}/temp.tar";
    final outputFile = File(outputFileName).openWrite();
    final List<TarEntry> entries = [];
    await for (final entity in directory.list(recursive: true)) {
      if (entity is File) {
        entries.add(
          TarEntry.data(
            TarHeader(
              name: p.relative(entity.path, from: directoryPath),
              mode: int.parse('644', radix: 8),
            ),
            File(entity.path).readAsBytesSync(),
          ),
        );
      }
    }
    await Stream.fromIterable(entries).transform(tarWriter).pipe(outputFile);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Arquivo criado"),
        backgroundColor: Colors.green.shade700,
        duration: const Duration(seconds: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text("Escolha uma pasta para enviar"),
      onPressed: () => _getDirectory(context),
    );
  }
}

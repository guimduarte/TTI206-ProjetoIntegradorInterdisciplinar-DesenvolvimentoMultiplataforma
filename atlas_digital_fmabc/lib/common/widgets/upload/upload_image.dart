import 'package:atlas_digital_fmabc/services/upload_service.dart';
import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';
import 'package:tar/tar.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  UploadService uploadService = UploadService();
  late String _imageName;
  late String _imageDescription;
  late String _directoryPath;

  @override
  void initState() {
    _imageName = "";
    _imageDescription = "";
    _directoryPath = "";
    super.initState();
  }

  Future<void> _getDirectory(BuildContext context) async {
    const String confirmButtonText = "Confirmar";
    final String? directoryPath = await getDirectoryPath(
      confirmButtonText: confirmButtonText,
    );
    if (directoryPath == null) {
      return;
    }
    _directoryPath = directoryPath;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Pasta selecionada"),
        backgroundColor: Colors.green.shade700,
        duration: const Duration(seconds: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          child: const Text("Escolha uma pasta para enviar"),
          onPressed: () => _getDirectory(context),
        ),
        TextField(
          onChanged: (value) => setState(() {
            _imageName = value;
          }),
          decoration: InputDecoration(labelText: "Nome da Imagem"),
        ),
        TextField(
          onChanged: (value) => setState(() {
            _imageDescription = value;
          }),
          decoration: InputDecoration(labelText: "Descrição da Imagem"),
        ),
        ElevatedButton(
          child: const Text("Enviar Imagem"),
          onPressed: () => {
            uploadService.uploadImage(
              _directoryPath,
              _imageName,
              _imageDescription,
            ),
          },
        ),
      ],
    );
  }
}

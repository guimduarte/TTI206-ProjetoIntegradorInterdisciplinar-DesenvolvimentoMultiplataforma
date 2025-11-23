import 'package:flutter/material.dart';
import 'package:atlas_digital_fmabc/services/image_service.dart';

class ImageEditorForm extends StatefulWidget {
  final String imageName;
  final String currentDescription;
  final VoidCallback onSuccess;

  const ImageEditorForm({
    super.key,
    required this.imageName,
    required this.currentDescription,
    required this.onSuccess,
  });

  @override
  State<ImageEditorForm> createState() => _ImageEditorFormState();
}

class _ImageEditorFormState extends State<ImageEditorForm> {
  final ImageService _imageService = ImageService();
  late TextEditingController _descController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _descController = TextEditingController(text: widget.currentDescription);
  }

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  Future<void> _handleUpdate() async {
    setState(() => _isLoading = true);
    
    final result = await _imageService.updateImageDescription(
      imageName: widget.imageName,
      newDescription: _descController.text,
    );

    setState(() => _isLoading = false);

    if (mounted) {
      if (result.containsKey('success')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Descrição atualizada com sucesso!"), backgroundColor: Colors.green),
        );
        widget.onSuccess();
        Navigator.pop(context); 
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message']), backgroundColor: Colors.red),
        );
      }
    }
  }

  //Deletar
  Future<void> _handleDelete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Tem certeza?"),
        content: Text("Deseja excluir a imagem '${widget.imageName}'? Isso não pode ser desfeito."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Cancelar")),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true), 
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Excluir"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isLoading = true);
    
    final result = await _imageService.deleteImage(imageName: widget.imageName);

    setState(() => _isLoading = false);

    if (mounted) {
      if (result.containsKey('success')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Imagem deletada!"), backgroundColor: Colors.green),
        );
        widget.onSuccess();
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message']), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Editar Imagem: ${widget.imageName}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          
          //Descrição
          TextField(
            controller: _descController,
            decoration: const InputDecoration(
              labelText: "Descrição",
              border: OutlineInputBorder(),
              helperText: "Breve descrição sobre a lâmina",
            ),
            maxLines: 3,
          ),
          
          const SizedBox(height: 24),

          if (_isLoading)
             const Center(child: CircularProgressIndicator())
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: _handleDelete,
                  icon: const Icon(Icons.delete_forever),
                  label: const Text("Excluir Imagem"),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                ),
                
                // Botão de Salvar
                ElevatedButton.icon(
                  onPressed: _handleUpdate,
                  icon: const Icon(Icons.save),
                  label: const Text("Salvar Alterações"),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
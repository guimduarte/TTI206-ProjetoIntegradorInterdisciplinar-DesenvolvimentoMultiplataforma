import 'dart:io';

import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

const minDegress = 0.0;
const maxDegress = 360.0;

void main() => runApp(App());

class App extends StatefulWidget {
  const App({super.key});
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  ImageEditorController? _editorController;
  double degress = 0.0;

  void updateDegress(double newDegress) {
    _editorController?.rotate(degree: newDegress - degress);
    setState(() => degress = newDegress);
  }

  @override
  void initState() {
    _editorController = ImageEditorController();
    degress = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("PI - teste")),

        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onDoubleTap: () => print(
                    _editorController?.editActionDetails?.totalScale,
                  ),
                  child: ExtendedImage.file(
                    File("assets/level5.png"),
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.editor,
                    initEditorConfigHandler: (ExtendedImageState? state) {
                      return EditorConfig(
                        maxScale: 1000.0,
                        hitTestSize: 20.0,
                        cornerSize: Size(0, 0),
                        cropRectPadding: EdgeInsets.all(0),
                        lineHeight: 0.01,
                        lineColor: Color.fromRGBO(0, 0, 0, 0),
                        controller: _editorController,
                      );
                    },
                  ),
                ),
              ),
              Slider(
                value: degress,
                onChanged: (newDegress) => updateDegress(newDegress),
                min: minDegress,
                max: maxDegress,
              ),
              Align(
                child: ElevatedButton(
                  onPressed: () {
                    updateDegress(minDegress);
                    _editorController?.reset();
                  },
                  child: Text("Resetar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class FileImportDialog extends StatefulWidget {
  final Function(FileToImport)? onFileImportChoose;

  const FileImportDialog({super.key, this.onFileImportChoose});

  @override
  _FileImportDialogState createState() => _FileImportDialogState();
}

class FileToImport {
  String fileName;
  String? path;
  String fileExtension;
  Uint8List? fileBytes;

  FileToImport(
      {required this.fileName,
      this.path,
      required this.fileExtension,
      this.fileBytes});
}

class _FileImportDialogState extends State<FileImportDialog> {
  String? _fileName;
  String? _path;
  String? _fileExtension;
  int? _fileSize;
  Uint8List? _fileBytes;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        _fileName = file.name;
        _fileExtension = file.extension;
        _fileSize = file.size;
        _fileBytes = file.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              child: const Text("Select File"),
            ),
            if (_fileName != null) ...[
              TextField(
                controller: TextEditingController(text: _fileName),
                decoration: const InputDecoration(labelText: "File Name"),
                onChanged: (value) {
                  _fileName = value;
                },
              ),
              TextField(
                controller: TextEditingController(text: _path),
                decoration: const InputDecoration(labelText: "Path"),
                onChanged: (value) {
                  _path = value;
                },
              ),
              TextField(
                controller: TextEditingController(text: _fileExtension),
                decoration: const InputDecoration(labelText: "File Format"),
                readOnly: true,
              ),
              TextField(
                controller: TextEditingController(text: _fileSize.toString()),
                decoration:
                    const InputDecoration(labelText: "File Size (bytes)"),
                readOnly: true,
              ),
            ],
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (widget.onFileImportChoose != null) {
                      widget.onFileImportChoose!(FileToImport(
                          fileName: _fileName ?? "",
                          fileExtension: _fileExtension ?? "",
                          path: _path,
                          fileBytes: _fileBytes));
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text("Link File"),
                ),
              ],
            )
          ],
        ));
  }
}

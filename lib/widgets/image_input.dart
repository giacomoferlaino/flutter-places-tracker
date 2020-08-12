import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_places_tracker/services/device_storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ImageInput extends StatefulWidget {
  final void Function(File pickedImage) onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  bool _servicesLoaded = false;
  DeviceStorageService _storageService;
  File _storedImage;

  @override
  void initState() {
    super.initState();
    GetIt.instance
        .getAsync<DeviceStorageService>()
        .then((DeviceStorageService storageService) {
      _storageService = storageService;
      setState(() {
        _servicesLoaded = true;
      });
    });
  }

  Future<void> _takePicture() async {
    final PickedFile imageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) return;
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final String fileName = basename(imageFile.path);
    final savedImage =
        await _storageService.saveFile(_storedImage, '$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return !_servicesLoaded
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Row(
            children: [
              Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                child: _storedImage != null
                    ? Image.file(
                        _storedImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : const Text('No Image', textAlign: TextAlign.center),
                alignment: Alignment.center,
              ),
              SizedBox(width: 10),
              Expanded(
                child: FlatButton.icon(
                  icon: Icon(Icons.camera),
                  label: const Text('Take Picture'),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: _takePicture,
                ),
              ),
            ],
          );
  }
}

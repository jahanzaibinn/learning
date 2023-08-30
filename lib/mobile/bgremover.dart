import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class RemoveBackgroundScreen extends StatefulWidget {
  @override
  _RemoveBackgroundScreenState createState() => _RemoveBackgroundScreenState();
}

class _RemoveBackgroundScreenState extends State<RemoveBackgroundScreen> {
  final String apiKey = "jzoXqjsT51kGEeZgC2PazWaR";
  File? selectedImage;
  File? outputImage;
  final String apiUrl = "https://api.remove.bg/v1.0/removebg";

  Future<void> pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Future<void> removeBackground() async {
    if (selectedImage == null) {
      return;
    }

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers['X-Api-Key'] = apiKey;
    request.fields['size'] = 'auto';
    request.files.add(await http.MultipartFile.fromPath('image_file', selectedImage!.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      final appDocumentsDir = await getApplicationDocumentsDirectory();
      final outputFile = File('${appDocumentsDir.path}/no-bg.png');

      await outputFile.writeAsBytes(await response.stream.toBytes());

      setState(() {
        outputImage = outputFile;
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> downloadImage() async {
    if (outputImage == null) {
      return;
    }

    final appDocumentsDir = await getApplicationDocumentsDirectory();
    final outputFile = File('${appDocumentsDir.path}/no-bg.png');

    // Copy the output image to a location where the user can access it
    await outputImage!.copy(outputFile.path);

    // Show a confirmation message to the user
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Image downloaded successfully.'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remove Background'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              selectedImage != null
                  ? Image.file(selectedImage!)
                  : Text('No Image Selected'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: removeBackground,
                child: Text('Remove Background'),
              ),
              SizedBox(height: 20),
              if (outputImage != null)
                Image.file(outputImage!)
              else
                Text('No Output Image'),
              if (outputImage != null)
                ElevatedButton(
                  onPressed: downloadImage,
                  child: Text('Download Image'),
                )
            ],
          ),
        ),
      ),
    );
  }
}

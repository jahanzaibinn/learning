import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class RemoveBackgroundScreen extends StatefulWidget {
  @override
  _RemoveBackgroundScreenState createState() => _RemoveBackgroundScreenState();
}

class _RemoveBackgroundScreenState extends State<RemoveBackgroundScreen> {

  //photoroom
  // id :doe@yopmail.com
  //api.video
  //id : doe@yopmail.com , pass: doe.123456
  final String apiKey = "jzoXqjsT51kGEeZgC2PazWaR";
  final String apiKey2 = "587865b6d8a0efd8dc7761706d456a5db0dfdfa5";
  File? selectedImage;
  File? outputImage;
  final String apiUrl = "https://api.remove.bg/v1.0/removebg";
  final String apiUrl2 = "https://sdk.photoroom.com/v1/segment";

  Future<void> pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera,preferredCameraDevice: CameraDevice.rear);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Future<void> removeBackground2() async {
    //
    // var headers = {
    //   'X-Api-Key': '587865b6d8a0efd8dc7761706d456a5db0dfdfa5'
    // };
    // var request = http.MultipartRequest('POST', Uri.parse('https://sdk.photoroom.com/v1/segment'));
    // request.files.add(await http.MultipartFile.fromPath('image_file', selectedImage!.path));
    // request.headers.addAll(headers);
    // var response = await request.send();
    // if (response.statusCode == 200) {
    //   final appDir = await getTemporaryDirectory();
    //   File file = File('${appDir.path}/sth.jpg');
    //   await file.writeAsBytes(await response.stream.toBytes());
    //   final List<int> _bytes = [];
    //   response.stream.listen((value) {
    //     _bytes.addAll(value);
    //   }).onDone(() async {
    //     await file.writeAsBytes(_bytes);
    //     // pd.close();
    //     setState(() {
    //       outputImage = file;
    //       // var a = CleverCloset.base64String(file.readAsBytesSync());
    //       // stackChildren.add(MoveableStackItem(CleverCloset.imageFromBase64String(a).image));
    //     });
    //   });
    //
    // }
    // else {
    //   setState(() {
    //     // var base64String = CleverCloset.base64String(image);
    //     // stackChildren.add(MoveableStackItem(CleverCloset.imageFromBase64String(base64String).image));
    //   });
    // }
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
                onPressed: removeBackground2,
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

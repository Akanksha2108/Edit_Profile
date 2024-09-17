import 'dart:async';
import 'dart:typed_data';
import 'dart:io';
import 'dart:html' as html; // Only for web
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:image_picker/image_picker.dart';


import 'web_image_picker.dart' if (dart.library.io) 'mobile_image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _lookingFor = 'Open to all';
  String _language = 'Open to all';
  String _religion = 'Open to all';
  String _kids = 'Open to all';

  dynamic _image1;
  dynamic _image2;
  dynamic _image3;
  dynamic _image4;
  dynamic _image5;

  final ImagePicker _picker = ImagePicker();


Future<XFile?> pickImageMobile(ImagePicker picker) async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  return pickedFile;
}

 Future<void> _pickImage(int imageNumber) async {
  if (foundation.kIsWeb) {
    final data = await pickImageWeb();
    if (data != null) {
      setState(() {
        if (imageNumber == 1) {
          _image1 = data;
        } else if (imageNumber == 2) {
          _image2 = data;
        } else if (imageNumber == 3) {
          _image3 = data;
        } else if (imageNumber == 4) {
          _image4 = data;
        } else if (imageNumber == 5) {
          _image5 = data;
        }
      });
    }
  } else {
    final pickedFile = await pickImageMobile(_picker);
    if (pickedFile != null) {
      setState(() {
        if (imageNumber == 1) {
          _image1 = File(pickedFile.path);
        } else if (imageNumber == 2) {
          _image2 = File(pickedFile.path);
        } else if (imageNumber == 3) {
          _image3 = File(pickedFile.path);
        } else if (imageNumber == 4) {
          _image4 = File(pickedFile.path);
        } else if (imageNumber == 5) {
          _image5 = File(pickedFile.path);
        }
      });
    }
  }
}


  void _setImage(int imageNumber, dynamic imageData) {
    switch (imageNumber) {
      case 1:
        _image1 = imageData;
        break;
      case 2:
        _image2 = imageData;
        break;
      case 3:
        _image3 = imageData;
        break;
      case 4:
        _image4 = imageData;
        break;
      case 5:
        _image5 = imageData;
        break;
    }
  }

  void _removeImage(int imageNumber) {
    setState(() {
      _setImage(imageNumber, null);
    });
  }

  void _showImageOptions(BuildContext context, int imageNumber) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Replace Image'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(imageNumber);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Remove Image'),
                onTap: () {
                  Navigator.pop(context);
                  _removeImage(imageNumber);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageFrame(int imageNumber, dynamic imageData) {
    return GestureDetector(
      onTap: () {
        if (imageData != null) {
          _showImageOptions(context, imageNumber);
        } else {
          _pickImage(imageNumber);
        }
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: imageData == null
                ? Icon(Icons.add)
                : foundation.kIsWeb
                    ? Image.memory(imageData, fit: BoxFit.cover)
                    : Image.file(imageData, fit: BoxFit.cover),
          ),
          if (imageData != null)
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: () {
                  _showImageOptions(context, imageNumber);
                },
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(248, 241, 223, 240),
            Color.fromARGB(255, 193, 187, 224)
          ]),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.close),
                    ),
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.people),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 200,
                          width: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [_buildImageFrame(1, _image1)],
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          height: 200,
                          width: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [_buildImageFrame(2, _image2)],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [_buildImageFrame(3, _image3)],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [_buildImageFrame(4, _image4)],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [_buildImageFrame(5, _image5)],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _buildDropdown('Looking for', _lookingFor, [
                  'Open to all',
                  'Men',
                  'Women'
                ], (newValue) {
                  setState(() {
                    _lookingFor = newValue!;
                  });
                }),
                SizedBox(height: 16),
                _buildDropdown('Language', _language, [
                  'Open to all',
                  'English',
                  'Hindi',
                  'Gujarati'
                ], (newValue) {
                  setState(() {
                    _language = newValue!;
                  });
                }),
                SizedBox(height: 16),
                _buildDropdown('Religion', _religion, [
                  'Open to all',
                  'Hindu',
                  'Muslim',
                  'Christian'
                ], (newValue) {
                  setState(() {
                    _religion = newValue!;
                  });
                }),
                SizedBox(height: 16),
                _buildDropdown('Kids', _kids, [
                  'Open to all',
                  'Yes',
                  'No'
                ], (newValue) {
                  setState(() {
                    _kids = newValue!;
                  });
                }),
                 SizedBox(height: 70),
              ],
            ),
          ),
        ),
        
      ),
       bottomSheet: Save(),
    );
  }

  Widget _buildDropdown(
      String title, String currentValue, List<String> options, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: currentValue,
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

class Save extends StatelessWidget {
  const Save({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
        child: Padding(
          
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            child: Center(child: Text("Save",style: TextStyle(fontSize: 20,color: Colors.white,),)),
            height: 50,
            width: 400,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 2, 81, 219),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          
        ),
    );
  }
}
Future<Uint8List?> pickImageWeb() async {
    final completer = Completer<Uint8List?>();
    final input = html.FileUploadInputElement()..accept = 'image/*';
    input.click();

    input.onChange.listen((e) async {
      final files = input.files;
      if (files == null || files.isEmpty) {
        completer.complete(null);
        return;
      }

      final reader = html.FileReader();
      reader.readAsArrayBuffer(files[0]);
      reader.onLoadEnd.listen((e) {
        final data = reader.result as Uint8List?;
        completer.complete(data);
      });
    });

    return completer.future;
  }

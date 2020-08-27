import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/photo_field.dart';

class EditScreen extends StatefulWidget {
  static const routeName = '/edit';
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _detailController = TextEditingController();
  List<Asset> _images;

  void _selectImage(List<Asset> pickedImages) {
    _images = pickedImages;
  }

  void _saveProduct() async {
    if (_titleController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _priceController.text.isEmpty) {
      return;
    }
    // 사진 스토리지에 저장
    final String id = FirebaseAuth.instance.currentUser.uid;
    final StorageReference ref = FirebaseStorage.instance.ref().child(id);

    await Future.forEach(_images, (image) async {
      ByteData byteData = await image.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      await ref
          .child(DateTime.now().toString() + '.jpg')
          .putData(imageData)
          .onComplete;
    });

    // 디비에 제품 올리기
    await FirebaseFirestore.instance.collection('test').add({
      'title': _titleController.text,
      'price': _priceController.text,
      'detail': _detailController.text,
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글쓰기'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      child: PhotoField(_selectImage),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: '제목'),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: '가격'),
                      controller: _priceController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: '내용'),
                      controller: _detailController,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
            RaisedButton.icon(
              icon: Icon(Icons.file_upload),
              label: Text('게시'),
              onPressed: _saveProduct,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../widgets/photo_field.dart';
import '../helpers/db_helper.dart';

class EditScreen extends StatefulWidget {
  static const routeName = '/edit';
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<Asset> _images; // 스토리지에 올리는거
  bool _isLoading = false;

  void _selectImage(List<Asset> pickedImages) {
    _images = pickedImages;
  }

  void _saveProduct() async {
    setState(() {
      _isLoading = true;
    });
    if (_titleController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _priceController.text.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    // 사진 올리고, url 받아오기
    final List<String> _urls = await DBHelper.getImageUrls(_images);
    
    // DB에 내용 저장
    DBHelper.create(
      _titleController.text,
      int.parse(_priceController.text),
      _descriptionController.text,
      _urls,
    );
    // 홈으로 나가기
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
                      controller: _descriptionController,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
            RaisedButton.icon(
              icon: Icon(Icons.file_upload),
              label: Text(_isLoading ? '게시중...' : '게시'),
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

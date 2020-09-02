import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

import './image_picker.dart';
import '../../helpers/db_helper.dart';
import '../../providers/products.dart';

class EditForm extends StatefulWidget {
  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _title;
  String _price;
  String _description;
  List<Asset> _images;
  bool _isLoading = false;

  void _selectImage(List<Asset> pickedImages) {
    _images = pickedImages;
  }

  void _saveProduct() async {
    setState(() {
      _isLoading = true;
    });
    _formKey.currentState.save();
    if (_title.isEmpty || _price.isEmpty || _description.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    // 사진 올리고, url 받아오기
    final List<String> _urls = await DBHelper.getImageUrls(_images);

    // DB에 내용 저장
    DBHelper.create(
      _title,
      int.parse(_price),
      _description,
      _urls,
    );
    Provider.of<Products>(context, listen: false).fetchProducts();
    // 홈으로 나가기
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      child: PhotoField(_selectImage),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: '제목'),
                      maxLength: 50,
                      onSaved: (value) {
                        _title = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: '가격'),
                      keyboardType: TextInputType.number,
                      validator: (String value){
                        return value.length <= 11 ? value : '백억원 이상의 물건은 올릴 수 없습니다.';
                      },
                      onSaved: (value) {
                        _price = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: '내용'),
                      maxLines: 2,
                      maxLength: 500,
                      onSaved: (value) {
                        _description = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.file_upload),
            label: Text(_isLoading ? '게시중..' : '게시'),
            onPressed: _saveProduct,
          ),
        ],
      ),
    );
  }
}

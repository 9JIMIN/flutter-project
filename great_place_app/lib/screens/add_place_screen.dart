import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../providers/great_places.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // 칼럼안에 expanded한 칼럼을 넣어서, 위에 mainaxis.spacebetween을 안해도 높이를 최대로 사용하게 됨,
          // 그래서 버튼이 아래에 붙어 있을 수 있고, 내부 칼럼에 다른 axis, scroll 등의 다른 설정을 줄 수 있음.
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'title'),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Places'),
            onPressed: _savePlace,
            elevation: 0,
            materialTapTargetSize:
                MaterialTapTargetSize.shrinkWrap, // 버튼에 있는 디폴트 마진을 없애줌.
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}
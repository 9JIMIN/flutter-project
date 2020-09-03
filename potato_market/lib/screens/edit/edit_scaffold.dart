import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import './edit_form.dart';
import './image_picker.dart';
import '../../helpers/db_helper.dart';
import '../../providers/products.dart';

class EditScaffold extends StatefulWidget {
  static const routeName = '/edit';

  @override
  _EditScaffoldState createState() => _EditScaffoldState();
}

class _EditScaffoldState extends State<EditScaffold> {
  String _title;
  String _price;
  String _description;
  List<Asset> _assets;

  bool _isLoading = false;

  void _saveData(title, price, description) {
    _title = title;
    _price = price;
    _description = description;
  }

  void _saveImages(assets) {
    _assets = assets;
  }

  void _uploadData() async {
    List<String> _urls = await DBHelper.getImageUrls(_assets);
    int _intPrice = int.parse(_price);
    await DBHelper.create(
      _title,
      _intPrice,
      _description,
      _urls,
    );
    Provider.of<Products>(context, listen: false).fetchProducts();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글쓰기'),
        actions: <Widget>[
          FlatButton(
            child: Text('완료'),
            onPressed: _uploadData,
          )
        ],
      ),
      body: _isLoading
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      child: ImagePicker(_saveImages),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Colors.black54,
                    ),
                    EditForm(_saveData),
                  ],
                ),
              ),
            ),
    );
  }
}

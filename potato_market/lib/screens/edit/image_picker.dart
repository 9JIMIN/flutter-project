import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImagePicker extends StatefulWidget {
  final Function saveImages;

  ImagePicker(this.saveImages);
  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  List<Asset> _imagesAsset = List<Asset>();

  void syncData() {
    widget.saveImages(_imagesAsset);
  }

  Widget _buildGridView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_imagesAsset.length, (index) {
          Asset asset = _imagesAsset[index];
          return Container(
            margin: const EdgeInsets.only(right: 15),
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AssetThumb(
                    quality: 10,
                    asset: asset,
                    width: 300,
                    height: 300,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _imagesAsset.removeAt(index);
                      });
                    },
                    child: Icon(
                      Icons.cancel,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Future<void> _loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: _imagesAsset,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          statusBarColor: "#FF4E342E",
          actionBarColor: "#FF6D4C41",
          actionBarTitle: "사진선택",
          allViewTitle: "전체 사진",
          useDetailsView: false,
          selectCircleStrokeColor: "#FF6D4C41",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
      print(error);
    }

    if (!mounted) return;

    setState(() {
      _imagesAsset = resultList;
      syncData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: RaisedButton(
            onPressed: _loadAssets,
            color: Theme.of(context).primaryColorLight,
            padding: EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Icon(Icons.photo_camera),
                Text('${_imagesAsset.length}/10'),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: _buildGridView(),
        ),
      ],
    );
  }
}

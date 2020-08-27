import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PhotoField extends StatefulWidget {
  final Function selectImages;

  PhotoField(this.selectImages);
  @override
  _PhotoFieldState createState() => _PhotoFieldState();
}

class _PhotoFieldState extends State<PhotoField> {
  List<Asset> images = List<Asset>();

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return Container(
            margin: const EdgeInsets.only(left: 10),
            child: Stack(
              children: <Widget>[
                AssetThumb(
                  asset: asset,
                  width: 300,
                  height: 300,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        images.removeAt(index);
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

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();

    resultList = await MultiImagePicker.pickImages(
      maxImages: 10,
      enableCamera: true,
      selectedAssets: images,
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

    if (!mounted) return;

    setState(() {
      images = resultList;
      widget.selectImages(images);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: Container(
            color: Theme.of(context).primaryColorLight,
            padding: EdgeInsets.all(30),
            child: Icon(
              Icons.photo_camera,
            ),
          ),
          onTap: loadAssets,
        ),
        Expanded(
          child: buildGridView(),
        ),
      ],
    );
  }
}

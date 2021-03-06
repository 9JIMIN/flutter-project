import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

  class ImageInput extends StatefulWidget {
    final Function onSelectedImage;

    ImageInput(this.onSelectedImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final image = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (image == null) { // 사진 안찍고 나가는 경우의 에러 헨들링.
      return;
    }
    final imageFile = File(image.path); // 받은 image는 PickedFile이라는 특수한 타입이다. 그래서 File로 변경해줘야함.
    setState(() {
      _storedImage = imageFile;
    });

    // 앱이 하드에 맘대로 파일을 쓸 수는 없다. 
    // 정해진 앱의 경로에만 파일을 쓸 수 있음. 그래서 앱을 삭제하거나하면 OS가 알아서 해당 경로의 파일을 삭제함.
    final appDir = await syspaths.getApplicationDocumentsDirectory(); // Future를 리턴해서 await
    final fileName = path.basename(imageFile.path); // 카메라가 자동으로 주는 파일명으로 저장.
    final savedImage = await imageFile.copy('${appDir.path}/$fileName'); // 최종저장된 이미지. 다른데서 사용가능.
    
    widget.onSelectedImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity, // parent가 허용하는 가장 큰 크기
                )
              : Text(
                  'No Image',
                  textAlign: TextAlign.center,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          // Expanded는 그 child가 남은 공간 모두를 차지한다.
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}

// 로컬 디바이스 연결하는 법
// 휴대전화정보 - 커널버젼 연타 - "개발자가 되셨습니다." 확인
// 추가설정 - 개발자옵션 - USB디버깅 허용
// 휴대폰 연결 - 파일전송 허용 - run
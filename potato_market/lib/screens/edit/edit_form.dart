import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditForm extends StatefulWidget {
  final Function saveData;
  final GlobalKey formkey;

  EditForm(this.saveData, this.formkey);
  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  String _title;
  String _price;
  String _description;

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();

  void syncData() {
    widget.saveData(_title, _price, _description);
  }

  void _fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: '제목',
              border: InputBorder.none,
            ),
            textInputAction: TextInputAction.next,
            focusNode: _titleFocus,
            onFieldSubmitted: (_) {
              _fieldFocusChange(context, _titleFocus, _priceFocus);
            },
            validator: (String value) {
              if (value.isEmpty) {
                return '제목을 입력해주세요.';
              } else if (value.length > 50) {
                return '50자 이내로 입력하세요.';
              }
              return null;
            },
            onSaved: (value) {
              _title = value;
              syncData();
            },
          ),
          const Divider(
            color: Colors.black54,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: '가격',
              prefixText: '₩ ',
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            // maxLength: 15,
            focusNode: _priceFocus,
            onFieldSubmitted: (_) {
              _fieldFocusChange(context, _priceFocus, _descriptionFocus);
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            validator: (String value) {
              if (value.isEmpty) {
                return '가격을 입력해 주세요.';
              } else if (value.length >= 12) {
                return '백원원 이상의 물건을 올릴 수 없습니다.';
              }
              return null;
            },
            onSaved: (String value) {
              _price = value;
              syncData();
            },
          ),
          const Divider(
            color: Colors.black54,
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: '내용을 입력해 주세요.',
              border: InputBorder.none,
            ),
            maxLines: null,
            maxLength: 500,
            focusNode: _descriptionFocus,
            textInputAction: TextInputAction.newline,
            validator: (value) {
              if (value.isEmpty) {
                return '올리실 제품에 대한 정보를 입력해주세요.';
              }
              return null;
            },
            onSaved: (value) {
              _description = value;
              syncData();
            },
          ),
        ],
      ),
    );
  }
}

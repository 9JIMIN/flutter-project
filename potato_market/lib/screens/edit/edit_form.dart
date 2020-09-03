import 'package:flutter/material.dart';

class EditForm extends StatefulWidget {
  final Function saveData;

  EditForm(this.saveData);
  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _title;
  String _price;
  String _description;

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();

  void syncData() {
    widget.saveData(_title, _price, _description);
  }

  _fieldFocusChange(
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
      key: _formKey,
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
            onChanged: (value) {
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
            focusNode: _priceFocus,
            onFieldSubmitted: (_) {
              _fieldFocusChange(context, _priceFocus, _descriptionFocus);
            },
            validator: (String value) {
              if (value.length >= 12) {
                return '백억원 이상의 물건은 올릴 수 없습니다.';
              } else if (value.isEmpty) {
                return '가격을 입력해 주세요.';
              }
              return null;
            },
            onChanged: (value) {
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
            onChanged: (value) {
              _description = value;
              syncData();
            },
          ),
        ],
      ),
    );
  }
}

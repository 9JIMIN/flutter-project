import 'package:flutter/material.dart';

import './screens/chat_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatApp',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.amber,
      ),
      home: ChatScreen(),
    );
  }
}
// location not found error
// settings.gradle파일을 바꿔준다. => https://stackoverflow.com/questions/62348554/plugin-project-location-web-not-found-please-update-settings-gradle-how-do-i

// firebase 새 프로젝트=> google-servies.json, gradle설정 등등을 함.
// 클라우드 데이터베이스 만든다.
// cloud-firestore 설치.
// snapshot을 통해 문서를 추가하면 바로바로 통신할 수 있다.

// cloud-firestore에서 dex..에러
// android/app/build.gradle=> 
// defaultConfig => multiDexEnabled true추가
// dependencies => implementation 'com.android.support:multidex:1.0.3'추가
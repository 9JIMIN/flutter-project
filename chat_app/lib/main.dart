import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/chat_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatApp',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        backgroundColor: Colors.indigo,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        errorColor: Colors.redAccent,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.deepPurple,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          if (userSnapshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
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

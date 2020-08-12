# Flutter project

[1. Quiz app](#1.-Quiz-app)

[2. Personal Expense app](#2.-Personal-Expense-app)

[3. Meals app](#3.-Meals-app)

[4. Shop app](#4.-Shop-app)

[5. Great Place app](#5.-Great-Place-app)

[6. Chat app](#6.-Chat-app)



## 1. Quiz app

### 1-1. Screen shot
<p float="left">
  <img src="./images/quiz-1.jpg" width="300" />
  <img src="./images/quiz-2.jpg" width="300" /> 
</p>

### 1-2. Description
- 정해진 퀴즈를 풀고, 그에 따른 결과(score)를 보여주는 앱
- main.dart는 stful위젯, setState함수 정의, 퀴즈 리스트, 스코어를 가지고 있음.
- 그리고 이러한 함수, 퀴즈들은 index의 크기에 따라 Quiz, Result 위젯을 띄움.
- Quiz는 퀴즈리스트, 현재인덱스, 답선택함수를 받는다. 
  - Question은 현재 퀴즈인덱스의 질문 텍스를 받는다.
  -  Answer 는 현재 퀴즈인덱스의 답변리스트와 답선택함수를 받는다.
- Result는 스코어와 리셋함수를 받는다. 

<img src='./images/quiz-3.jpg'>

### 1-3. Learn
- Dart, flutter Basic (문법, stful, stless..)
    
    
## 2. Personal Expense app

### 2-1. Screen shot
<p float="left">
  <img src="./images/exp-2.jpg" width="300" />
  <img src="./images/exp-3.jpg" width="300" /> 
  <img src="./images/exp-4.jpg" width="300" /> 
</p>

### 2-2. Description
- 가계부 앱
- main.dart에 userTranscation리스트가 있고, 이걸로 지출 리스트를 만든다. 
  퀴즈앱과 마찬가지로 모든 함수, 변수가 MyhomePage클래스에 정의되어 관련 위짓으로 넘겨주고 있다. 
- 최근 7일의 지출리스트를 Chart 위짓에 보내고, CharBar와 함께 차트를 만든다. 
- 지출리스트와 지출내역삭제함수를 TransactionList 위짓에 보내고, ListView를 만든다. 
- 앱바와 하단 float버튼을 클릭하면, ModalBottomSheet함수가 실행된다. 지출내역추가함수를 NewTransaction에 보내고, 입력창을 만든다.

<img src="./images/exp-1.jpg"/> 

### 1-3. Learn
- 함수를 만드는 방법, 메소드 이용방법
- 스타일링
- for, if등의 다트 문법
   

## 3. Meals app



## 4. Shop app



## 5. Great Place app



## 6. Chat app
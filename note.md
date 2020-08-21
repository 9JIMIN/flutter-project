### 플러터 개념

**Flutter** = SDK+widget library, 툴셋(SDK)와 위젯모음을 제공하는 API이다. 다트 위에서 돌아가는 프레임워크이다.
flutter SDK의 툴킷은 다트로 작성한 코드를 iOS, android에 맞게 컴파일을 해준다.
플러터가 제공하는 미리 정의된 위젯 라이브러리를 써서, 쉽고 빠르게 개발이 가능하다.

- [기술개요](https://flutter-ko.dev/docs/resources/technical-overview)

- [인사이드 플러터](https://flutter-ko.dev/docs/resources/inside-flutter)

The widget building recursion bottoms out in `RenderObjectWidgets`, which are widgets that create nodes in the underlying *render* tree. The render tree is a data structure that stores the geometry of the user interface, which is computed during *layout* and used during *painting* and *hit testing*. Most Flutter developers do not author render objects directly but instead manipulate the render tree using widgets.

다트 언어는 UI에 특화된 프로그래밍언어이다. 
예를 들어 async-await, collection if, spread operator같은 기능이 있다.
그러니까 상태에 따라 서로 다른 응답을 보여줘야하는 그런 기능을 편리하게 만들 수 있는 문법이 많다. 

> dart는 아니지만, flutter에 보면 FutureBuilder, StreamBuilder 같은 기능이 있다. 
> dart에도 if, 삼항연산자(? :)로 상태에 따라 응답을 구분하는 등의 기능이 있다. 

UI vs UX
UI is made up of all the elements that enable someone to interact with a product or service. 
UX, on the other hand, is what the individual interacting with that product or service takes away from the entire experience.

> It’s important to distinguish the total user experience from the user interface (UI), even though the UI is obviously an extremely important part of the design. As an example, consider a website with movie reviews. Even if the UI for finding a film is perfect, the UX will be poor for a user who wants information about a small independent release if the underlying database only contains movies from the major studios. [출처](https://www.usertesting.com/blog/ui-vs-ux)

Dart에 대해서

```dart
class Person {
  var name; // 클래스에 만드는 변수를 프로퍼티라고 한다. 
  var age;
  bool human = true;
  
  Person(this.name, this.age); // constructor
}

void main() {
  var p1 = Person(name: 'Kim', age: 19);
  print(p1.name);
}

// 기타 자세한 내용은 dart-overview.pdf 참고!

```

void main() 은 다트가 젤 먼저 실행하는 특별한 함수이다. 이걸 실행해줘야 UI rendering을 시작한다. 
변수를 만들때, 값을 바로 넣으면, `var`를 쓴다.  그냥 만들기만 할때는 타입을 지정해줌.

- Parameter (= 매개변수) : 함수의 입력변수 명
- Argument (= 인자) : 함수의 입력 값

- Object : 데이터의 구조, 다트에서는 모든 값이 오브젝트이다. String, Integers, List... 
  내가 직접 오브젝트를 만들 수도 있다. 오브젝트를 만드는 것이 클래스이다. 
  클래스는 오브젝트를 만들기 위한 청사진(blue print)역할을 한다. (class=> instance)

flutter는 UI를 코드로 작성한다. 앱의 UI는 위젯트리이다.
위젯트리는 어떤 위젯을 렌더링하고, 다른 위젯과 어떤 관계인지를 보여준다.
모든 위젯은 다트의 클래스이다. 

플러터는 플랫폼에 있는 기존 네이티브 UI를 쓰지 않는다. 
컴파일을 할때 플랫폼의 컴포넌트로 만드는 것이 아니라, 자체적인 UI컴포넌트를 쓴다. 이것이 React native와의 차이이다. 
이러한 방식의 장점은 기존 UI에 묶이지 않아 더 자유로운 커스터마이징이 가능하다는 것이다. 

플러터는 디폴트로 material design system을 이용한다. 구글에서 만든 디자인 시스템이다. 
애플 스타일의 쿠퍼티노 위젯도 있다. 

setState((){여기}) 여기에 뭐가 들어가는지 마는지 의미가 있을까? 
어차피 다시 만들어지는거, 그냥 setState 이전에 값을 바꾸고, 그 다음에 setState((){}) 는 빈상태로 실행시켜도 되지 않을까?
[스택오버플로 답변](https://stackoverflow.com/questions/49980453/flutter-does-it-matter-what-code-is-in-setstate)
위의 답을 보면, 그냥 보기 좋게 할려고 그런다고 한다. 
하지만, 다큐먼트를 보면 꼭 그런 이유는 아닌것을 알 수 있다. [docs-setState](https://api.flutter.dev/flutter/widgets/State/setState.html)

Generally it is recommended that the `setState` method only be used to wrap the actual changes to the state, not any computation that might be associated with the change. For example, here a value used by the [build](https://api.flutter.dev/flutter/widgets/State/build.html) function is incremented, and then the change is written to disk, but only the increment is wrapped in the `setState`:

```dart
Future<void> _incrementCounter() async {
  setState(() {
    _counter++;
  });
  Directory directory = await getApplicationDocumentsDirectory();
  final String dirName = directory.path;
  await File('$dir/counter.txt').writeAsString('$_counter');
}
```

It is an error to call this method after the framework calls [dispose](https://api.flutter.dev/flutter/widgets/State/dispose.html). You can determine whether it is legal to call this method by checking whether the [mounted](https://api.flutter.dev/flutter/widgets/State/mounted.html) property is true.

왜 expense앱에서는 MyApp을 stless로 하고, 따로 stful MyHomePage를 만들었을까?
그냥 MyApp을 stful로 해서 거기에 변수랑 함수를 넣어도 되지 않을까? 

아마도, optimization의 일환인 것 같다. 그렇게 만들어도 되긴하지만, 
MyApp자체의 설정은 다시 만들필요가 없으니, stless로 하고, 따로 stful로 위짓을 분리하여 그 위짓만 다시 만들게 하려는 의도.

get과 set의 의미는 정확히 뭘까?
getter는 클래스의 멤버변수를 가져오는 역할을 하고, setter는 값을 쓰는 역할을 한다. [참고 브런치](https://brunch.co.kr/@mystoryg/127)
위 브런치 내용을 보면, private인 _변수명은 외부에서 직접접근이 불가능하지만, get또는 set을 쓰면 public으로 접근이 가능하게 하는 것이 목적인 듯 설명하고 있다.

하지만, get, set으로도 private한 변수를 설정하기도 한다.  
get으로 기존 class 멤버변수를 이용해서 새로운 변수를 만드는 등의 작업을 할 수 있다.
[dev에서의 설명](https://dev.to/newtonmunene_yg/dart-getters-and-setters-1c8f)

그리고, get과 set은 별 차이 없다. 그냥 get은 인자를 받지않고, set은 인자를 받는다는 차이가 있다. 

```dart
class Vehicle {
  String make;
  String model;
  int manufactureYear;
  int vehicleAge;
  String color;

  int get age {
    return vehicleAge;
  }

  void set age(int currentYear) {
    vehicleAge = currentYear - manufactureYear;
  }
    
  Vehicle({this.make,this.model,this.manufactureYear,this.color,});
}
```

플러터의 of 메서드에 대해서 
of: The state from the closest instance of this class that encloses the given context.
예를 들어 A라는 클래스의 child가 있을 경우, 그 **child의 build메서드 내에서** A를 참고하기 위해 쓰인다. 

[공식문서](https://api.flutter.dev/flutter/material/Scaffold/of.html)
만약에 같은 build메서드 안에서 A위젯이 생성되면, 그 build함수의 context인자로는 A위젯을 참고할 수 없다. 
왜냐하면, 그 context내에 A기 있기 때문이다. 
그래서 상위에 A위젯을 두게 하기 위해 builder함수를 써서 A위젯의 하위 context를 만들 수 있다. (위 문서 참고)

BuilContext란, 위젯트리에서 위젯의 위치이다. 
각각의 위젯은 고유의 BuildContext를 가진다. 
From the docs, `BuildContext` is: 

> A handle to the location of a widget in the widget tree.

`context` is a `BuildContext` instance which gets passed to the builder of a widget in order to let it know where it is inside the Widget Tree of your app.
One of the common uses is passing it to the `of` method when using an [Inherited Widget](https://docs.flutter.io/flutter/widgets/InheritedWidget-class.html).
Calling `Something.of(context)`, for example, returns the `Something` relative to the closest widget in the tree that can provide you that `Something`.
You can read more about `BuildContext` [here in the docs](https://docs.flutter.io/flutter/widgets/BuildContext-class.html).

### 기본

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
// 함수에서 실행되는게 한문장이면, {}와 return 없이 화살표로 표현가능.
// 다트에선 main함수가 제일먼저 실행된다. 
// flutter/material.dart에 있는 runApp함수는 위짓의 build를 실행한다. 

class MyApp extends StatelessWidget {
// flutter의 모든 위젯은 Stless또는 Stful의 확장이다. 
// 그리고 그 두 클래스는 위젯을 리턴하는 build함수가 포함되어있다. 
// build 함수는 context를 인자로 받는다. 
// context는 flutter가 알아서 만들어준다. 우린 그냥 집어넣기만 하면 됨.
// @override는 걍 주석, 없어도 되지만, 있으면 보기 좋음. 
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Text('Hello'),
      ),
    );
  }
}
```

위의 코드는 디자인이 정의되지않아서 구리다. 
미리 이쁘게 정의된 기본 위젯 구조, 디자인을 제공하는 `Scaffold`를 쓰면 좋다.

`Scaffold` 위짓의 `appbar`는 `PreferedSizedWidget`이다. 

다른 dart파일에서의 접근을 제한하기위해 _ 를 붙여서 private 프로퍼티를 만든다.
`enum`은 미리 정의된 value(값)이다. 

- static : instance를 만들필요없이 쓸 수 있는 클래스의 프로퍼티
- final : 한 번 값이 부여되면 이후로 변하지 않음.  = runtime constant
- const : 만들때 값을 넣어야함. 컴파일이 될때 값이 정해짐/   = compile time constant

> const는 애초에 만들때부터 정해진 값이 있는거고, final은 코드로 볼때는 잘 모르겠는데, 코드가 실행되서 값이 들어가면 그걸로 고정되는 거임.

```dart
final test = const ['a', 'b', 'c'];
```

**변수의 실제값은 메모리에 저장이 되고,** 
**변수에 저장되는 값은 실제값이 저장된 메모리의 포인터이다.**

그래서 const로 설정하면, 메모리를 아낄 수 있다.

함수와 같은 개념이다. 함수도 정의를 하면, callback으로 함수이름을 줄때는 그 함수의 포인터를 넘기는 것이다. 

stful위젯에서는 state에 상태유지를 위한 변수를 저장한다. 
이때, 변수를 조작할 함수도 같이 정의하게 된다. 
그리고 그 함수들은 주로 setState를 가지고 있어 조작된 변수로 다시 빌드를 한다. 

### build & context

- [인사이드플러터-sublinear widget building](https://flutter.dev/docs/resources/inside-flutter#sublinear-widget-building)

한번 생성된 위젯트리는 수정할 수 없다. 위젯트리는 부자관계를 모른다.
이러한 관계정보를 저장하고, stful위젯에서 state저장하는 등의 역할을 하는 것이 element tree이다.
element tree는 UI의 논리적인 구조이다. 

유저의 인풋에 의해 element가 변할 수 있다. 예를 들어 setState()로 build가 실행되면, flutter는 변한 element만 찾아낸다. 

- [build 공식문서](https://api.flutter.dev/flutter/widgets/State/build.html)

- **Widget Tree** - **Element Tree** - **Render Tree**

  - Widget Tree = 코딩하는 부분, 위젯 속성 설정. (자주 rebuild)
  - Element Tree = 렌더트리랑 위짓트리를 묶어줌. (드물게 rebuild)
    위젯트리와 렌더트리를 pointing 할 뿐, 자체적으로 설정내용을 가지지 않음. 그저 포인터.
    위젯트리의 각 위젯에 대한 Element 를 생성함. stful위젯의 state도 element트리에 속한다. 
    그러니까, 위젯트리가 실제 앱의 정보를 가지고 있으면, element트리는 그 정보를 메모리에서 포인팅하고 있고, 독립적인 state를 가지고 있기도하는 역할을 한다. 
    그리고 render트리랑 위젯트리를 연결시켜줌.
  - Render Tree = 스크린에 렌더되는 부분. 우리가 보는거 (드물게 rebuild)

  > rebuild는 플러터의 핵심기능 element, render트리는 그대로일때가 많기에, rebuild를 자주하는 것을 너무 문제삼을 필요없다. 

  **const constructor** 란, final프로퍼티를 받아서 const한 오브젝트를 만드는것.

  ```dart
  class ChartBar extends StatelessWidget:
  	final String label;
  	final double price;
  
  	const ChartBar(this.label, this.price);
  // ChartBar 인스턴스는 불변
  ```

  근데 위젯 자체가 불변. 그리고 stless는 원래가 불변이라, constructor에 const는 항상 붙일 수 있음. 
  위젯은 build메서드를 쓰면 constructor에 의해 새로운 인스턴스가 만들어짐.
  
  stless위젯은 constructor에 의해서만 만들어짐. 부모 요소가 다시만들어지면 자식 stless위젯도 다시 만들어짐. 
  중요한건 Contructor함수에 의해서만 build가 된다는 사실.
  
  stful위젯은 두개로 나뉜다. state오브젝트에서는 
  initState() => build() => setState() => didUpdateWidget() => build() => dispose()
  
  - initState()는 초기값을 줄때
  - didUpdateWidget은 부모의 값을 변했을때 
  
  context는 위젯트리에서의 위치 관계에 대해서 나타냄.



### Provider

- **1. ChangeNotifier**

> A class that can be extended or mixed in that provides a change notification API using [VoidCallback](https://api.flutter.dev/flutter/dart-ui/VoidCallback.html) for notifications.

플러터에 내장되어 있기에 따로 import가 필요없다. 
ChnageNotifier 를 확장하여 클래스를 만들면, 그 클래스의 변화를 구독할 수 있다. (상태관찰이 가능하다.)
예를들어, ChangeNotifier를 확장하여 클래스를 만들고, 거기에 **notifiyListener()**를 포함한 메서드를 정의한다. 
그러면, 외부에서 해당 모델을 listening하는 위젯들은 notifyListener()가 실행될때, rebuild가 된다.

- **2. ChangeNotifierProvider**

> Listens to a [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html), expose it to its descendants and rebuilds dependents whenever [ChangeNotifier.notifyListeners](https://api.flutter.dev/flutter/foundation/ChangeNotifier/notifyListeners.html) is called.

ChangeNotifier의 인스턴스를 제공하는 위젯.
provider패키지가 필요하다. 
여러 클래스를 provide할때는 Multiprovier를 쓴다.
해당 위젯의 하위 위젯에서는 ChangeNotifier를 확장한 클래스(모델)에 접근할 수 있다.  

- **3. Consumer**

> Obtains [Provider](https://pub.dev/documentation/provider/latest/provider/Provider-class.html) from its ancestors and passes its value to [builder](https://pub.dev/documentation/provider/latest/provider/Consumer/builder.html).
> The [Consumer](https://pub.dev/documentation/provider/latest/provider/Consumer-class.html) widget doesn't do any fancy work. It just calls [Provider.of](https://pub.dev/documentation/provider/latest/provider/Provider/of.html) in a new widget, and delegates its `build` implementation to [builder](https://pub.dev/documentation/provider/latest/provider/Consumer/builder.html).
> [builder](https://pub.dev/documentation/provider/latest/provider/Consumer/builder.html) must not be null and may be called multiple times (such as when the provided value change).

Consumer<클래스명> 위젯은 해당 클래스에 접근을 할 수 있게 해준다. 타입(클래스 명)을 반드시 적어야한다. 
컨슈머 위젯에서 요구되는 인자는 builder함수이다. 
builder함수는 ChangeNotifier가 변할때(즉, notifyListener가 실행될때) 실행된다.
builder함수는 3개의 인자를 받는다. 
첫번째는 모든 build메서드에서 제공하는 context
두번째는 ChangeNotifier의 인스턴스(이걸 얻기위함이 목적임.)
세번째는 chlid, optimization을 위해 존재한다. 예를 들어 Consumer위젯 하위에 큰 하위 위젯트리가 있고, 모델의 변화와 상관이 없는 경우에는 따로 child인자를 정의하고, 그걸 builder 함수의 인자로 넣어서 이미 만들어진 위젯을 넣음으로써 rebuild가 안되게 할 수도 있다.

```dart
return Consumer<CartModel>(
  builder: (context, cart, child) => Stack(
        children: [
          // Use SomeExpensiveWidget here, without rebuilding every time.
          child,
          Text("Total price: ${cart.totalPrice}"),
        ],
      ),
  // Build the expensive widget here.
  child: SomeExpensiveWidget(),
);
```

 그래서 가능한 Consumer를 위젯 깊숙이에 위치시키는 것이 좋다. 

- **Provider.of**
  Consumer는 UI변화를 위해서 모델의 데이터가 필요할때 쓰인다. 
  Provider.of는 UI변화랑은 상관없지만, 그래도 데이터가 필요할때 쓰인다.
  예를들어 예를들어서 상품을 담는 카트모델이 있고, 카트를 비우고 싶을때는 해당 모델의 특정 메서드만 쓰면 된다. 
  Consumer를 통해서도 모델인스턴스를 제공받아 메서드를 실행할 수 있지만, 불필요한 rebuild가 수반된다. 
  build는 다시할 필요없지만, 모델을 써야할때. Provider.of를 아래와 같이 쓸 수 있다. 

  ```dart
  Provider.of<CartModel>(context, listen: false).add(item);
  ```

  notifyListeners가 실행되어도, 위젯이 rebuild되지 않는다.  



- **4. ChangeNotifierProxyProvider**

> A [ChangeNotifierProvider](https://pub.dev/documentation/provider/latest/provider/ChangeNotifierProvider-class.html) that builds and synchronizes a [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html) with external values.

- [docs](https://pub.dev/documentation/provider/latest/provider/ChangeNotifierProxyProvider-class.html)
  외부값에 의존하는 ChangeNotifier를 provide할때 쓰인다.
  예를 들어 아래와 같은 Provider를 보자.

  ```dart
  ChangeNotifierProvider(
    create: (context) {
      return MyChangeNotifier(
        myModel: Provider.of<MyModel>(context, listen: false),
      );
    },
    child: ...
  )
  ```

  MyChangeNotifier 인스턴스를 만드는데, MyModel이라는 다른 provider가 쓰인다. 
  This works as long as `MyModel` never changes. But if it somehow updates, then our [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html) will never update accordingly.
  To solve this issue, we could instead use this class, like so:

  ```dart
  ChangeNotifierProxyProvider<MyModel, MyChangeNotifier>( // ChangeNotifierProxyProvider(참고할 프로바이더, 만들 프로바이더)
      // create, update, child
      create: (_) => MyChangeNotifier(), // 만들 프로바이더.
      update: (_, myModel, myNotifier) => myNotifier // (context, 참고할 프로바이더, 만들 프로바이더의 이전 인스턴스) => 새로운 인스턴스
      ..update(myModel),
      child: ...
  );
  ```

  MyModel이 업데이트 될때, MyChangeNotifier도 업데이트가 적용이 된다. 

  가능한 **ProxyProvider**를 쓰는 것이 좋다. 

> A provider that builds a value based on other providers.
> The exposed value is built through either `create` or `update`, then passed to [InheritedProvider](https://pub.dev/documentation/provider/latest/provider/InheritedProvider-class.html). 



### Life cycle

[블로그 설명](https://jaceshim.github.io/2019/01/28/flutter-study-stateful-widget-lifecycle/)
[미디엄 설명](https://medium.com/flutter-community/widget-state-buildcontext-inheritedwidget-898d671b7956)

- initState() 

위젯이 트리에 들어갈때 실행.
State 오브젝트가 생성될 때, 딱 한번만 실행이 된다. 

State의 build 메서드가 상태변경이 가능한 다른 오브젝트에 의존하는 경우.
다른 오브젝트를 참고 해서 위젯을 만드는 경우! (예를 들어 ChangeNotifier, Stream) 그럴때 쓰는 듯.

[docs](https://api.flutter.dev/flutter/widgets/State/initState.html)

- didUpdateWidget()

부모위젯의 속성이 변경될때 실행됨.
실행후에는 항상 build가 실행됨. 낡은 State를 변경하기 위함. 이전객체의 구독을 취소. 변경된 새로운 인스턴스를 다시 구독.
initState() 와 마찬가지로 위젯이 다른 변경가능한 오브젝트를 참고할때 그 변화를 subscribe하기위해 쓰인다. 

- In [initState](https://api.flutter.dev/flutter/widgets/State/initState.html), subscribe to the object.
- In [didUpdateWidget](https://api.flutter.dev/flutter/widgets/State/didUpdateWidget.html) unsubscribe from the old object and subscribe to the new one if the updated widget configuration requires replacing the object.
- In [dispose](https://api.flutter.dev/flutter/widgets/State/dispose.html), unsubscribe from the object.

***

- didChangeDependencies method

Called when a dependency of this [State](https://api.flutter.dev/flutter/widgets/State-class.html) object changes. initState()다음에 실행, 그리고 위젯이 의존하는 데이터 객체가 호출될때 실행
For example, if the previous call to [build](https://api.flutter.dev/flutter/widgets/State/build.html) referenced an [InheritedWidget](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html) that later changed, 
the framework would call this method to notify this object about the change.



itemBuilder는 스크롤해서 보이면 생성된다. 

***

### FutureBuilder vs Streambuilder

- FutureBuilder = [문서](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html)
  - `Future`는 하나의 응답만을 받는다. (http응답과 같은 비동기 처리에 쓰인다.)
  - 따라서 Future에서 들을 수 있는 것은 **상태**이다. `진행중-성공-오류` 와 같은 것들. 그게 전부.
- StreamBuilder = [문서](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html)
  - `Stream`은 Future와 달리, 하나의 응답이 아니라 시간에 따라 변하는 이벤트를 받는다. 
  - 그래서 Future처럼 한번 하고 마는 것이 아니라, 계속 듣고 있음
  - `클릭 - 웹소켓`과 같은 것들이 있다.
-  [질문글]([https://www.it-swarm.dev/ko/dart/flutter-streambuilder-%EB%B0%8F-futurebuilder/838047623/](https://www.it-swarm.dev/ko/dart/flutter-streambuilder-및-futurebuilder/838047623/))

```dart
// FutureBuilder
FutureBuilder(
    // future, builder 두 개가 필요함.
    future: http.get('http://somedata.com'), // Future를 리턴하는(시간이 걸리는) 작업
    builder: (context, snapshot) { // snapshot은 작업현재상태를 뜻함.
        snapshot.connectionState == ConnectionState.waiting
            ? ForwaitingScreen() // 작업이 끝나지 않았을때 보여줄 화면.(주로 로딩 화면.)
            : ResultScreen() // 최종 리턴 화면.
    }

)
```

```dart
// StreamBuilder
StreamBuilder(
    // stream, builder 두 개가 필요함. 
	stream: // stream을 리턴하는(그때그때 값이 바뀌는 작업)
    builder: (context, snapshot) {} // snapshot으로 현재상태를 받아서 서로다른 응답을 보낼 수 있음. 
)
```

***

### key

[블로그 설명](https://nsinc.tistory.com/214)

위젯은 생성자로 부터 Key를 받을 수 있다. 
위젯이 위젯트리에서 위치를 변경하더라도 Stateful위젯은 타입만 확인하므로, Element트리는 달리진 것을 인식하지 못할 수 있다. 
따라서 위젯을 구분해주기 위해 Key가 쓰인다. 

A [Key] is an identifier for [Widget]s, [Element]s and [SemanticsNode]s.
A new widget will only be used to update an existing element if its key is the same as the key of the current widget associated with the element.

***

### pushNamed, pushRelacementNamed

pushNamed는 현재창 위에 생성함. Navigator.pop()로 뒤로 가기 가능. 앱바에 자동으로 뒤로가기 버튼이 생김.
pushReplacementNamed는 현재창을 dispose하고 생성.



***

### DropDownButton

```dart
DropdownButton(
    // 보통, 앱바 오른쪽에 아이콘이 표시되고, 누르면 드롭다운 메뉴가 나옴.
    // 인자로는 icon, items, onChanged 가 있다.
    
	icon: Icon(Icons.more_vert, color: Theme.of(context).primaryIconTheme.color),
	items: [ 
		DropdownMenuItem(
			value: 'case_a',
			child: // widget
		),
        DropdownMenuItem(
			value: 'case_b',
			child: // widget
		),
	],
    onChanged: (val) { // items에 설정한 value가 들어온다.
        if(val == 'case_a'){
            // ... after case_a click
        } else {
            // ... case b click
        }
    }
)
```


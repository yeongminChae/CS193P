#  Lecture3

[MVVM]
스위프트에서는 앱의 로직과 데이터 부분을 UI에서 분리하는 것이 매우 중요합니다.
SwiftUI는 데이터와 로직, 앱이 수행하는 작업을 여기에 두고 사용자에게 이를 보여주는 UI를 갖게 될 것이라는 아이디어를 바탕으로 구축되었습니다. 
사용자와 별개의 것으로 상호작용합니다. 그래서 이것은 정말로 중요합니다.
지금까지 contentView에 작업한 내용들은 UI라고 부르며 때로는 모델에 대한 뷰라고 부르기도 합니다.
모델은 단일 구조체일 수 있고, SQL데이터베이스일 수도 있습니다. 혹은 머신러닝 코드일 수도 있고 어쩌면 REST API와 같을 수도 있습니다.
모델은 개념적입니다. 단순한 단일 구조체는 아닙니다.
우리 앱의 UI 부분은 실제로 모델이 제공하는 매개변수화 가능한 셀과 같습니다. UI에 대해 제가 들은 가장 좋은 표현 중 하나는 모델의 시각적 표현이라느 것입니다.
모든 논리는 모델에 있습니다. UI는 사용자에게 이를 표시하는 방법입니다. 
Swift가 수행하는 작업 중 매우 중요한 책임 중 하나는 모델의 모든 변경사항이 UI에 표시되는지 확인하는 것입니다. 
따라서 이를 수행할 수 있는 엄청난 양의 인프라가 있습니다. 이것이 당신이 이해해야 할 한가지 입니다. 모델에 있는 모든 것을 UI에 표시하는 것에 대해 실제로 책임을 지는 것은 아닙니다.
모델의 무엇이 UI에 영향을 미치는지에 대해 Swift에 몇 가지 힌트를 제공하면 됩니다.
1. 드물게 모델을 UI에 연결할 수 있는 한 가지 방법은 모델이 뷰에서 @State가 되도록 하는 것입니다. 즉 전체 모델, 앱의 모든 로직을 뷰의 @State에 넣으면 분명히 뷰가 이에 접근 할 수 있습니다.
2. 모델이 UI에 'Gate Keeper'를 통해 접근하게 하는 방법입니다. 이 게이트키퍼에 역할은 UI와 모델이 서로 안전하게 통신하도록 유지하고 조정하는 것입니다. 이것이 MVVM 입니다. 
3. 여기에는 앞에 나온 두 가지를 혼합한 3번이 입니다. 종종 UI가 모델을 보고 직접 소통하기도 합니다.
* 주로 2번을 사용하세요.

<Model> : 
    모델은 UI독립적이다.
    Data + Logic
    모든 것에 진실이다. 데이터를 알고 싶거나 일부 논리를 수행하려면 모델과 대화해야 합니다. 
    정보를 알고싶다면 모델에서 확인해야 합니다.
    모델이 아는것은 모델에게 항상 요청해야 합니다.

<View> : 
    뷰는 모델을 시각화한 것입니다. 뷰는 항상 모델의 모습과 같아야 합니다.
    모델에서 무슨일이 발생하더라도 UI에 나타나야 합니다.
    뷰는 State를 가지고 있지 않어야 합니다.
    뷰는 선언형이어야 합니다.
    뷰는 '반응형'입니다. 

<ViewModel> :
    뷰를 모델에 바인딩한 것입니다.
    이는 바인딩할 뿐만 아니라 해석도 하고 있습니다. 미치 SQL일 수도 있고, SQL 호출을 하지 않으므로 SQL을 호출하고 일반으로 바꿔야 합니다. 모델을 해석하는 것입니다.
    또한 뷰와 모델 사이의 게이트 키퍼역할을 하기도 합니다.
    두가지 사이의 흐름을 통제하는 역할입니다.
    
뷰모델이 변화를 인지하면 모델에서 변경된 사항을 뷰에게 알립니다. 그리고 뷰는 변경 사항을 반영하게 됩니다. 

질문 : 모델 -> 뷰 모델 -> 뷰 항상 이 방향으로만 진행된다라면, 뷰를 탭하거나 하는 상호작용은 어떻게 처리 되나요?
답 : Intent Function을 뷰모델에서 호출한 후, 모델을 수정하고 뷰 모델을 거쳐 다시 뷰를 수정합니다.


[타입]
<struct and class> :
    공통점 :
    - 두타입 모두 var isFaceUp: Bool 과 같은 저장할 수 있는 변수가 있습니다, 마찬가지로 computed 된 변수도 있습니다.
    - 또한 상수인 let도 가질 수 있습니다. 
    - 그리고 function 가지고 있습니다. 
    - 초기화 생성자인 initalizer또한 가지고 있습니다.
    
    차이점 :
    struct는 value(값) type이고 class는 참조 type입니다.
    - 참조 type은 클래스인 변수가 있을 때 실제로 해당 변수에 저장된 클래스가 없으며 이에 대한 포인터가 있음을 의미합니다. 
    이는 힙 어딘가에 있습니다.
    - 참조 type의 모두 동일한 클래스를 공유하는 20개의 서로 다른 코드 조각이 있을 수 있다는 것입니다. 그러므로 모든 것을 수정할 수 있고 이는 장단점이 있습니다.
    
    - 값 type은 변수가 실제로 포인터가 아니라 메모리상에 저장됨을 의미합니다.
    - 예를 들어 값 type을 함수에 전달하면 해당 값의 복사본을 얻게 됩니다. 실제로 하나의 변수를 다른 변수에 할당하더라도 다른 변수의 복사본을 만든 것입니다. 항목이 전달되거나 할당될 때마다 값은 복사됩니다. (포인터가 아닙니다.) 
    - 이는 전달된 값을 수정하면 원본 값 자체가 바뀌는 class와는 다르게 원본은 수정 되지 않습니다. 
    - 그래서 struct를 수정하려는 함수에 제공하고 한다면 이를 해당 함수에 제공해야 합니다. 따라서 수정이 되며 새로운 값을 반환할 것 입니다.
    
    * shuffle() vs shuffled() : shuffle()은 원본 변수를 제자리에서 섞고, shuffled()는 새로 섞인 배열을 반환합니다. 
    
    - class에 대한 모든 종류의 포인터를 나눠주는 경우 메모리를 정리하는 방법을 언제 알 수 있습니까? swift에서는 포인터가 몇 개 있는지 실시간으로 추적하고 해당 개수가 0이되면 자동으로 종료하는 자동 참조 카운팅이라는 기술이 적용 되어 있습니다.
    - sturct는 copy on write를 통해 효율적으로 작업을 수행합니다.
 
    - class : 객체지향 프로그래밍
        * 객체지향 프로그래밍 : 데이터 캡슐화라는 아이디어에서 나온것입니다. 실제 개념이나 사물의 데이터를 캡슐화한 다음 해당 데이터에 대한 기능을 사용하여 모든 기능을 하나의 구조로 캡슐화하여 모든 기능을 해당 데이터와 연결하기 위한 프로그래밍 기법입니다.
    - struct : 함수형 프로그래밍
        * 함수형 프로그래밍 : 함수형 프로그래밍은 모든 데이터를 캡슐화 하려는 것이 아니라 함수, 기능을 캡슐화 하고자 합니다. 따라서 우리가 실제로 할 일은 사물이 어떻게 작동하는지를 설명하는 것입니다. 함수형 프로그래밍에서 가장 원하는 것은 provability(증명가능성)입니다. 
        
    - struct, class 모두 초기화 생성자인 init을 가지고 있지만, 완전히 다르게 작동합니다.
    - class : class는 초기화를 직접 수행하지 않으면 아무것도 수행하지 않는 class를 얻게 됩니다. 그러나 여전히 모두 초기화 되어야 하므로 클래스에서 free-init를 사용할 수있는 유일한 방법은 본질적으로 모든 단일 변수에 대해 무언가를 입력하는 것입니다. 
    - struct : struct는 모든 변수를 초기화하게 됩니다. 물론 그 중 하나라도 기본값으로 설정되어 있다라면 거기에 넣을 필요는 없지만 얻을 수 있는 것은 그 뿐입니다. 직접 초기화 하지 않으면 모든 기능이 포함된 free-init을 받게 됩니다.
    
    - class : 객체지향 프로그래밍에서 객체는 항상 mutable(변경 가능)합니다. 당신은 포인터를 가지고 있고, 언제든지 해당 포인터를 통해 객체를 변경할 수 있습니다. 그러므로 누구나 객체를 변경할 수 있기 때문에 위험합니다.
    - struct mutablity는 명시적입니다. let에 있는 항목은 변경할 수 없지만 var에 있는 항목은 변경할 수 있습니다. 따라서 이는 명시적으로 관리됩니다.
    질문 : class에 let을 사용할 수 있습니까?
    답 : 사용할 수 있지만 여기서 가리키는 값은 포인터입니다. 그러므로 항상 변경 가능합니다.
    
<generics> : 
    때로는 구조체를 만들고 싶은데 그 구조체에 일부 데이터가 연결되어 있고, 그 유형이 무엇인지 신경쓰지 않는 경우가 있습니다. 우리는 그러한 해당 유형에 대해 type agnostic(유형 불가지론)이라고 부릅니다.
    스위프트는 정말 강한 타입언어 입니다. 
    Array 구조체를 작성한다고 가정해 보겠습니다, 우리는 (don't care)한 유형의 변수와 함수가 필요합니다. 
    예를 들어 Array를 수행하고 거기에 Int를 append 하려면 append 메소드의 인수는 Int 유형이어야 합니다. 
    우리가 자체 struct Array를 구축한다면 대략 이런 모습일 겁니다.
    
    struct Array<element> { // 이 요소는 모든 유형일 수 있습니다. 
        ...
        func append (_ element: Element) : { ... }
    } 
    
    var a = Array<Int>() // Array에 element를 Int로 선언이 됩니다.
    a.append(5)
    a.append(22)
    
    - 실제로는 작은 요소로 배열 유형을 매개변수화하기 때문에 이를 'Type Parameter'(유형 매개변수)라고 합니다. 
    
<protocol> (part one) :
    프로토콜은 코드에서 볼 때 구현이 없는 클래스나 구조체처럼 보입니다. 
    
    - protocol Movable {
        func move(by: Int)
        var hasMoved: Bool { get } 
        var distanceFromStart: Int { get set } // 프로토콜에서 var 뒤의 중괄호는 이것이 readonly var인지 가져오고                                       설정할 수 있는 var인지를 나타냅니다.
    }
    프로토콜은 구현이 없는 단지 설명일 뿐입니다. 단지 동작에 대해 설명만 하고 있기 때문입니다. Movable처럼 동작하는 것을 갖고 싶다는 기능을 제공하지는 않습니다.
    Movable처럼 동작하려면 Movable을 구현해야 합니다. (모든 요소들을 구현해야 함.) 
    
    - struct portableThing: Movable {
        // must implement move(by:), hasMoved, and distanceFromStart here.
    }
    
    프로토콜을 구현한다고 주장하거나 프로토콜처럼 작동한다고 주장할 때는 해당 프로토콜의 모든 항목을 구현해야 합니다.
    portableThing이 Movable을 'comforms to'(준수)한다고 말하는 것입니다.
    
    - protocol Vehicle: Moveable {
        var passangerCount: Int { get set }
    }
    
    - class Car: Vehicle {
        // must implement move(by:), hasMoved, and distanceFromStart and passangerCount here.
    }
    프로토콜은 상속도 가능합니다. 왜냐하면 Vehicle에는 자체 변수가 있지만 이러한 변수가 상속되기 때문입니다. 따라서 차량인 자동차를 갖고 싶다면 두가지를 상속 받았기 때문에 네 가지를 모두 구현해야 프로토콜 상속이 완전히 허용됩니다.
    
    - class Car: Vehicle, Impoundable, Leasable {
        // must implement move(by:), hasMoved, and distanceFromStart and passangerCount here.
        // and must implement any funcs/vars in Impoundable, Leasable too. 
    }
    위와같이 여러개의 프로토콜을 구현하는 것도 가능합니다.
    
    프로토콜을 무엇에 사용합니까?
        - 프로토콜은 type입니다. 그래서 프로토콜을 type으로 사용할 수 있습니다. 변수 또는 인수 유형으로 함수에 전달 할 수있습니다. (var body는 리턴 타입중 하나입니다.)
        - 매우 중요한 것은 구조체, 클래스 또는 열거형의 동작을 지정하는 것입니다. 이러한 것을 'constrains and gains'(제약과 이득) 이라고 부릅니다.
        - 제약과 이득을 위해 프로토콜을 사용하는 것입니다. 이 제약과 아이디어 이득은 프로토콜의 모든 사용에 해당됩니다. 프로토콜은 특정 사항을 구현하도록 하기 때문에 항상 제약을 가하지만, 많은 이점을 얻을 수 있는 일종의 프레임워크를 제공합니다. 
        - 다른 용도는 'where' 절을 참조하여 'don't care' 구문을 'care a lil bit'으로 바꾸는 것입니다. 
         
functions : 
    함수는 type입니다.
    함수에 변수나 매개변수를 선언하거나 함수의 반환 유형을 선언할 수 있습니다. type function에 대한 이 구문에는 해당 함수의 인수와 반환 유형이 포함됩니다.
    변수, 함수 반환 값, 매개변수는 모두 type function일 수 있습니다. 
    
    - var operation: (Double) -> Double 
        // This is a var called operation.
        // It's type is "function that takes a Double and returns a Double..."
    
        // Here's a simple function that takes a Double and returns a Double ...
    - func spare(operand: Double) -> Double {
            return operand * operand
        }
    
    - operation = spare // just assingning a value to the operation var, nothing more
    - let result1 = operation(4) // result1 would equal 16
        // Note that we don't use argument labels (e.g operand: ) when executing function types.
    - operation = sqrt // sqrt is a built-in function which happens to take and return a Double
    - let result2 = operation(4) // result2 would be 2
    
    Closure : 클로져는 인라인함수로써 그때 존재하는 변수의 환경을 캡처합니다. 
     

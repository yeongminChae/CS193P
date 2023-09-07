#  Lecture5

- @ObservedObject VS @StateObject   
  
이 둘의 차이에 대해 생각하는 가장 좋은 방법은 두 가지 측면(lifetime(수명), scope(범위))에서일 것입니다.

* 수명
    변수의 수명은 이러한 '@' 항목 중 어떤 항목을 사용하는지와 관련이 있습니다. 
    뷰에서 @StateObject 또는 @State 중 @State을 사용하면, 이 변수가 화면에 나타날 때 해당 변수가 존재하게 됩니다. 그런 다음 뷰가 더이상 body에 없으면 사라지게 됩니다.  
    따라서, 변수의 수명은 UI에에 뷰가 존재하는 수명과 연결됩니다.
    @StateObject를 앱에 넣으면 분명히 그 수명은 애플리케이션에 전체 수명이 됩니다.
    그렇기 때문에, 때때로 뷰에 @StateObject가 있는 경우가 있습니다. 뷰를 사용하면 뷰 모델이 사라지기를 원하지만 그에 대한 모든 것이 사라지기 때문입니다. 
    변수에서와 마찬가지로 @ObservedObject는 변경된 사항에 주의를 기울이는 것과 관련이 있습니다. 이것은 앱의 생에주기동안 작동될 일이 아닙니다. 
    이 변수는 누군가가 당신에게 전달할 것이라고 가정하는 것입니다. 그럼 그 생에주기는 그들이 가지고 있는 것이 무엇이든 간에 생에주기일 것입니다.
    @ObservedObject가 있다라면 life는 다른 곳에서 옵니다. 

    ''' 추가 설명 by chatGPT
    @StateObject는 SwiftUI에서 사용되는 속성(property) 래퍼(wrapper) 중 하나로, 데이터의 상태(state)를 관리하는 데 사용됩니다. SwiftUI 앱에서 @StateObject를 사용하면 해당 속성이 앱의 전체 수명 주기 동안 존재하게 됩니다. 이것은 해당 객체가 앱이 실행되는 동안 지속되며 앱의 다른 뷰에서 공유될 수 있음을 의미합니다.

    뷰(View)에 @StateObject를 사용하면 뷰 모델(View Model)이 뷰의 수명과 동일한 수명을 가지게 됩니다. 즉, 뷰가 나타날 때 생성되고, 뷰가 사라질 때 제거됩니다. 때문에 뷰가 다시 나타날 때마다 새로운 뷰 모델이 생성됩니다.

    그러나 이것은 때로는 문제가 될 수 있습니다. 예를 들어, 뷰 모델에는 앱의 전체 상태를 저장하는 중요한 데이터가 포함될 수 있으며, 이 데이터가 뷰가 사라질 때마다 재설정되면 안 되는 경우가 있습니다. 이런 경우에는 @StateObject 대신 @ObservedObject를 사용하여 뷰 모델을 뷰의 수명과 분리할 수 있습니다. @ObservedObject를 사용하면 뷰 모델이 뷰의 수명과 독립적으로 존재하며, 뷰가 다시 나타날 때 이전 상태를 유지할 수 있습니다.

    따라서 "뷰를 사용하면 뷰 모델이 사라지기를 원하지만 그에 대한 모든 것이 사라지기 때문"이라는 문장은 뷰 모델의 수명과 뷰의 수명이 일치하는 경우, 뷰 모델이 뷰와 함께 사라질 때 해당 뷰 모델에 저장된 데이터도 함께 사라진다는 의미입니다. 이것이 바람직하지 않은 경우에는 @ObservedObject 또는 다른 방법을 사용하여 이 문제를 해결할 수 있습니다.
    '''
    
* 범위
    이 시점에서 @StateObject를 실행시키면 any View 혹은 body에서 생성된 모든 View에서만 해당 항목을 사용할 수 있거나 다음에서 생성된 모든 보기로 계단식으로 내려갈 수 있다는 것입니다. 내 View에 @StateObject를 넣을 때 내 뷰 구성에만 사용할 수 있기 때문에 내 형제 view에는 절대 사용할 수 없습니다. 
    반면에 @ObservedObject는 사용자에게 전달되었습니다. 따라서 다른 사람에 의해 다른 형제 view들에도 전달 될 수 있습니다.   

- where : 

제네릭 타입 제약(Generic Type Constraints): where 키워드는 제네릭 함수나 타입에서 타입 제약을 정의하는 데 사용됩니다. 예를 들어, 특정 타입이 특정 프로토콜을 따르거나 특정 클래스로부터 상속되어야 하는 경우 where 키워드를 사용하여 제약을 추가할 수 있습니다.
* struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>

    struct Card: Equatable {
        var isFaceUp = false
        var isMatched = false
        let contents: CardContent
    }
}


* ForEach(viewModel.cards, id:\.self) { card in // 에러
                CardView(card) 
  } 
- Error : Generic struct 'ForEach' requires that 'MemoryGame<String>.Card' conform to 'Hashable'
- Hashable은 작은 해시 테이블, 즉 이들 각각과 이 뷰 사이에 작은 딕셔너리를 구축할 것이기 때문에 이를 해시할 수 있어야 하기 때문입니다. 그러나 이는 카드를 해시하면 이는 기존과 다른 카드가 됩니다. 그렇기에 카드를 영원히 고유하게 식별하는 일종의 것이 필요로 합니다. 
- Error Fix : id:\.self를 지운다.

* ForEach(viewModel.cards) { card in
                CardView(card) // 에러
  } 
- Error : Referencing initializer 'init(_:content:)' on 'ForEach' requires that 'MemoryGame<String>.Card' conform to 'Identifiable'
- Error Fix : Identifiable를 struct Card에 선언한다. 
        struct Card: Equatable, Identifiable {
        var isFaceUp = false
        var isMatched = false
        let contents: CardContent
        var id: String
  }

* func choose(_ card: Card) {
    card.isFaceUp.toggle() // 에러 
  }
- Error : Cannot use mutating member on immutable value: 'card' is a 'let' constant
- 이 에러는 값 타입과 참조 타입간의 차이가 발생하기 때문입니다. 여기서 isFaceUp을 토글한다고 하더라도, 실제 model에 있는 카드를 실제로 뒤집는 것이 아니라, 전달되어진 사본을 뒤집고 있는 것입니다. 값 타입을 전달할 때마다 모든 값 타입은 구조화가 되고 통과하면 복사본이 됩니다.
  여기서는 func choose(_ card: Card) 중 card가 전달 되어 지고 있는데 이는 사본일 뿐만 아니라 암시적인 허용이기도 합니다. 함수에 대한 인수는 허용됩니다. 그렇기 때문에 그들은 mutating 멤버를 사용합니다.  
- Error Fix : 기존 choose 함수를 변형.
 -> 
 mutating func choose(_ card: Card) {
    let chosenIndex = index(of: card)
    cards[chosenIndex].isFaceUp.toggle()
 }
 
 func index(of card: Card) -> Int {
    return 0
 }

* Enum
    - 데이터 유형이 있을 때마다 열거형을 사용합니다. 열거형은 여는 중괄호 측면에서 구조체 및 클래스와 매우 유사해 보이지만 여기에는 저장된 변수가 없습니다. 열거형의 값은 별개입니다.  
    enum FastFoodMenuItem {
        case hamburger
        case fries
        case drink
        case cookie
    } 
    - 열거형은 값 유형입니다. 마치 struct와 같습니다. 항상 복사하여 전달됩니다. 그러나 열거형은 데이터를 각 case와 연결할 수 있다는 것입니다.
    enum FastFoodMenuItem {
        case hamburger(numberOfPatties: Int)
        case fries(size: FryOrderSize)
        case drink(String, ounces: Int)
        case cookie
    } 
    enum FryOrderSize {
        case large
        case small
    }
    
    - 열거형 값 설정은 다음과 같습니다.
    let menuItem = FastFoodMenuItem.hamburger(patties: 2)
    var otherItem: FastFoodItem = .cookie 
    
    - 열거형에서도 var를 사용할 수 있으나 이는 computed 연산자여야 합니다. 
    - 열거형을 반복문에서 사용하고 싶다라면 CaseIterable이라는 프로토콜을 선언해 주어야 합니다, 그렇게 되면 allCases에 접근할 수 있게 됩니다.
    
* Switch
    - Switch문은 열거형을 보고 모든 사례를 확인하는 것입니다.
    var menuItem = FastFoodMenuItem.hamburger(patties: 2)
    Switch menuItem {
        case .hamburger: print("burger")
        case .fries: print("fries")
        case .drink: print("drink")
        case .cookie: print("cookie")
    } // 일반적으로 열거형을 Switch를 사용해 값이 무엇인지 확인하는 모습입니다.
    - Switch를 사용할 때에는 모든 열거형의 상황들을 다루어야 합니다. 그렇기에 default를 사용해야 합니다.
    
    
* Optionals
    enum Optional<T> {
        case none
        case some(T)
    }
    
    - optional을 선언하는 방법
    연결된 데이터가 원하는 유형 제네릭 혹은 '?'을 가짐으로써 Optional을 선언합니다. 이는 선택적 열거형입니다.
    그런 다음 값을 할당할 수 있습니다. (하단에 = nil과 같은)
    var hello: String?              var hello: Optional<String> = .none
    var hello: String? = "hello"    var hello: Optional<String> = .sone("hello")
    var hello: String? = nil        var hello: Optional<String> = .none
    
    - unwrapping
    optional 값을 unwrapping 할 때 권장되는 방법은 if let을 사용하는 것입니다.
    if let safeHello = hello {
        print(safeHello)
    } else {
        // do smth
    } 
    

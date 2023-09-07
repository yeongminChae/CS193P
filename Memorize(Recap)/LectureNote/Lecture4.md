#  Lecture4

ViewModel 역할 : 모델에 있는 항목들을 가져와서 보기에 아름다운 간단한 코드가 포함되도록 배열하는 것.

func choose(_ card: Card) {
    // (_ card: Card) 이 함수에 파라매터는(_) 내부 전용이고 외부 이름(external name)이 없음을 명시, 호출자 쪽에서 인수가 없게 하기 위함입니다.
    // ex) choose(card: card) -> choose(card)
}
* 언제 다음과 같은 (_ card: Card) 코드를 작성하나요?
    1. 이것이 문자열이나 정수형 또는 그것에 타이빙 무엇인지 명확하지 않은 경우에 사용됩니다.
    2. 외부 이름(external name)으로 인해 코드 읽기가 더 수월해질때 사용됩니다.
        - func move(offset)에서 사람들은 오프셋을 이동하는 건가요? 무엇을 이동하는 건가요? 라며 질문을 할수 있지만,
        - 만약 func move(by: offset)일 경우라면 무엇을 이동하는 것인지 알기 더 편해질 것 입니다. (오프셋으로 이동 중입니다.)

- Error : Class 'EmojiMemoryGame' has no initializers in EmojiMemoryGame(ViewModel)
- Error Fix : 클래스에는 free init 프로그램이 제공된다라고 말씀드렸습니다. 우리는 CardView에 사전 초기화 프로그램이 있고 콘텐츠와 isFaceUp이 있는 것처럼 구조체가 멋진 free init 프로그램을 얻는다는 것을 이미 알고 있습니다.
    CardView에 대한 free init 초기화 프로그램이 없었습니다. 클래스도 동일한 작업을 수행했지만 초기화 프로그램에는 인수가 없으므로 모든 변수에 기본값이 있고 값이 없는 변수인 모델이 바로 여기에 있는 경우에만 작동합니다. 
    그래서 '초기화 되지 않은 변수가 있어서 여기에서는 무료 초기화 프로그램을 제공할 수 없습니다.' 따라서 초기화 기능이 없습니다.
    그러므로 초기화를 제공할 수 있으며 여기 모델에서 잠시 후에 init을 보게 될 것입니다.

- init(numberOfFairsOfCards: Int, cardContentFactory: (Int) -> CardContent) 
  cardContentFactory: (Int) -> CardContent : 이것이 우리가 이것을 함수형 프로그래밍이라고 부르는 이유의 핵심입니다. 
  일을 수행하는 방법에 대한 지식을 소유한 코드의 다양한 부분이 함수 전달을 통해 자신의 지식을 전달할 수 있도록 허용하기 때문입니다.
  
  let emojis = ["💀","🎃","👻","😈","🍭","🍬","🕯️","🦇","🙀","😱"] // 에러 발생
- Error : Cannot use instance member 'emojis' within property initializer; property initializers run before 'self' is available in EmojiMemoryGame(ViewModel)
* property initializer's meaning :
  프로퍼티가 있을 때, swift에서는 이를 var, let 이라고 부르고 속성을 허용합니다.
  이는 모델이라는 속성이고 변수이며 여기서 초기화를 하여 초기값을 주겠습니다. 
  let 이모지들은 속성 초기화이기도 합니다. 왜냐면 이것은 단지 let일 뿐이지만, 여전히 속성이고 값을 제공하고 있기 때문입니다. 
  Swift에서 이해해야 할 중요한 점은 속성이 초기화되는 순서가 결정되지 않는다는 것입니다. 소스코드에 표시된 순서와는 다릅니다.
  컴파일러는 그것들을 모두 컴파일하고 임의의 순서로 배열할 수 있으므로 하나를 사용하여 다른 하나를 초기화할 수 없습니다. 
  왜냐하면 초기화할 때 이것이 아직 설정되었는지 알 수 없기 때문입니다. 
- Error Fix 1 : let emojis를 전역변수로 설정. 그러나 이는 let emojis가 전역 변수가 되어 전체 프로그램에서 접근 가능해집니다.
- Error Fix 2 : 'static'을 활용해 전역 변수로 만들되, 내 class 내에서 네임스페이스를 지정하는 것입니다.
  

- private var model = MemoryGame( numberOfFairsOfCards: 4) { pairIndex in
        return emojis[pairIndex]
  }
위에 코드에서 모델을 만들기 위해 함수형으로 변환하는 과정.
- private var model = createMemoryGame() // 에러1

- func createMemoryGame() {
    MemoryGame( numberOfFairsOfCards: 4) { pairIndex in
        return emojis[pairIndex] // 에러2
    }
}

* Error1 : Cannot use instance member 'createMemoryGame' within property initializer; property initializers run before 'self' is available
* Error2 : Static member 'emojis' cannot be used on instance of type 'EmojiMemoryGame'
- 이유 : 현재는 createMemoryGame() 함수를 초기화 하기도 전에 사용을하려고 하기에 발생합니다.
- Error Fix 1 & 2: createMemoryGame() 함수를 static으로 만들어 줍니다.

ObservableObject : 반응형 UI때문에 모델에서 변경사항이 UI에 적응되게 하기위해 사용됩니다.
@Published : ObservableObject가 선언된 class에서 변경되는 내용을 알려주기 위해 사용됩니다.
@ObservedObject : ObservableObject인 변수만 @ObservedObject로 표시할 수 있다. 
@StateObject : @State를 수행하는 것보다 나은 것은 아닙니다. @State는 이 뷰 내부에만 있기 때문입니다. 그러므로 이 viewmodel을 다른 뷰와 절대로 공유할 수는 없습니다. @StateObject가 있는 이상, 이것은 뷰 내부의 클래스에 객체이기 때문입니다.  

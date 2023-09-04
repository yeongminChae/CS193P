#  Lecture2

'Trailing Closure Syntax'

ZStack {
    if isFaceUp {
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(.white)
        RoundedRectangle(cornerRadius: 12)
            .strokeBorder(lineWidth:  2)
        Text("👻").font(.largeTitle)
    } else {
        RoundedRectangle(cornerRadius: 12)
    }
}
ZStack은 단순한 구조체이며 뷰처럼 작동하고 인수가 두 개 있습니다. 
생성 항목이나 함수에 대한 마지막 인수가 중괄호와 같은 함수 자체인 경우 레이블을 제거하는 곳에서 이 작업을 수행 할 수 있습니다. 
이 경우 일반적으로 사용하는 레이블이 있는 경우 해당 레이블을 닫고 함수가 본질적으로 끝에서 멈추게 합니다. 
이 함수를 클로저라고 부르기 때문에 이를 Trailing Closure Syntax(후행 클로저 구문)이라고 합니다. 
(이러한 인라인 함수를 우리는 클로저라고 부릅니다) 이것들에 대해 모두 이야기할 것이며, 거기에 머물 수 있도록 마지막에 후행이 있습니다.

"Locals in @ViewBuilder"
ZStack {
    var base: RoundedRectangle = RoundedRectangle(cornerRadius: 12) // Local Variable 
    if isFaceUp {
        base
            .foregroundColor(.white)
        base
            .strokeBorder(lineWidth:  2)
        Text("👻").font(.largeTitle)
    } else {
        base
    }
}
ViewBuilder는 ifs 목록과 변수 할당을 수행하는 방법만 알고 있으며 그게 할 수 있는 전부입니다. 
본질적으로 조건부 목록과 지역 변수가 할 수 있는 전부입니다.

let vs var : 우선 let으로 작성할 것. 컴파일러가 수정해야하는지 여부를 확인해줌.

@State : 만약 @State var isFaceUp = true 이런 state를 선언한다라면, isFaceUp라는 포인터가 생성된다.
@State는 실제로 isFaceUp을 유지하는 작은 메모리 조각에 대한 포인터를 생성합니다. 이제 포인터는 절대 변하지 않습니다.
포인터가 가르키는 값은 바뀔 수 있지만 포인터 그 자체는 절대 바뀌지 않는다.

ForEach또한 ViewBuilder이다. ForEach는 어느 것이 이러한 뷰와 함께 가는지 추적합니다. 따라서 배열이 재정렬되면 뷰가 이동하고,
이로 인해 HStack이 뷰를 이동하거나 그리드로 이동하게 됩니다. 

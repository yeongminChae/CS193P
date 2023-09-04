#  Lecture 1

struct : Struct는 스위프트의 키워드일 뿐이며, 이것이 구조체임을 의미합니다. C에서 구조체는 변수를 보유하는 작은 것을 의미합니다.
struct는 SwiftUI에서 수행하는 모든 작업의 '핵심'입니다. 구조체는 변수가 있을수 있지만 함수도 있을 수 있습니다.
이를 통해 struct를 객체지향에서에 class와 비슷하다고 생각할 수 있지만, 객체지향 프로그래밍이 아닙니다.
이것은 class가 아니고 변수와 함수가 포함된 구조체일 뿐입니다.    

struct ContentView: View { 에서 View가 오늘 보게 될 가장 중요한 것일 수 있습니다.
그리고 이것이 함수형 프로그래밍을 이해하는데 도움이 되는 내용입니다. (종종 프로토콜 프로그래밍이라는 말도 듣게 될 것입니다.)

'Behave like Smth...' : 함수형 프로그래밍의 기본.
struct ContentView: View { : 이 코드의 뜻은 struct ContentView가 : View 처럼 동작한다는 것을 의미합니다.
View는 프로토콜이고 View처럼 행동할 수 있는 것입니다.

객체지향 프로그래밍의 뿌리는 데이터 캡슐화 입니다. (Data Encapsulation)
그러나 함수형 프로그래밍에서는 자신이 수행하는 작업을 설명할 때 '데이터'라는 단어를 사용하지는 않습니다.
이것은 'Behavior Encapsulation' 동작 캡슐화와 비슷합니다. 즉 모두 '행동에' 관한 것입니다.

무언가 처럼 행동한다는 것은 동전의 양면을 갖고 있는 것이라고 할 수 있습니다.
한가지는 책임이 있다는 것입니다. 예를들어 뷰처럼 동작하려면 뷰가 수행하는 작업을 수행해야 합니다. 
이것을 만족시키기 위해 수행해야 할 작업들이 있을 것입니다. 
다른 한가지는 이 요구를 충족시키고 작업을 수행한다면 View가 수행하는 방법을 알고 있는 모든 작업을 얻을 수 있다는 것입니다.

'Computed property'

var body: some View {
    VStack {
        Image(systemName: "globe")
            .imageScale(.large)
            .foregroundColor(.accentColor)
        Text("Hello, world!")
    }
    .padding()
}
var body: some View 이 'var body' 와 같은 것들을 우리는 properties라고 부릅니다. 
가끔 var 키워드 때문에 var라고 부르는 것을 들을 수도 있지만 스위프트에서는 해당 변수가 연결된 이 구조체의 속성이기 때문에 property입니다.

{
    VStack {
        Image(systemName: "globe")
            .imageScale(.large)
            .foregroundColor(.accentColor)
        Text("Hello, world!")
    }
    .padding()
} 
이 부분을 우리는 'computed'라고 부릅니다. 이는 이 변수의 값이 어딘가에 저장되지 않는다는 의미입니다. 이것은 계산됩니다.
누군가 body값을 요청할 때 마다 이 코드가 실행됩니다. 이것은 여기에서만 계산되기 때문에 read-only 이지만 호출할 때마다 다른 것을 반환하게 만드는 변수가 여기에 있을 수도 있기에 여전히 var입니다.
(값만 계산할 수 있으므로 read-only 변수입니다.)

var body: some View { 에서 : some View에 뜻은 이 변수의 유형이 뷰처럼 작동하는 한 전 세계의 모든 구조체여야 함을 의미합니다.
some은 스위프트에게 이 코드릴 실행하고 반환되는 내용일 확인해 사용하라라고 알려주는 키워드입니다.
이것은 두 가지 일을 동시에 하고 있습니다. 
첫째로는 당신을 위해 이것을 알아내는 것입니다. 둘째는 반환되는 것이 some View인지 확인하는 것입니다.

view처럼 행동하고 싶으면 왜 var body: some View { 와 같은 것을 구현하는 것이 유일한 작업인지 이해하고 싶습니다.
기본적으로 view처럼 행동하고 싶으면 다른 view를 반환하는 변수가 필요하다는 뜻입니다.  

'createing instances of structs'
VStack {
    Image(systemName: "globe") // 이것은 이미지 구조체를 만드는 예입니다. 
        .imageScale(.large)
        .foregroundColor(.accentColor)
    Text("Hello, world!") // 이것은 텍스트 구조체를 만드는 예입니다.
}
.padding()

'paramater defaults'
vStack : 이것은 실제로 뷰처럼 동작하는 구조체입니다. 따라서 이는 다른 뷰들과 다르지 않습니다.
vStack의 유일한 장점은 다른 레고를 가져와서 서로 쌓는 것입니다.

VStack {
    Image(systemName: "globe") // 이것은 이미지 구조체를 만드는 예입니다. 
        .imageScale(.large)
        .foregroundColor(.accentColor)
    Text("Hello, world!") // 이것은 텍스트 구조체를 만드는 예입니다.
} 이 중괄호 안에 있는 것은 실제로 함수입니다. 이와 같은 임베디드 함수들은 swfitUI의 모든 곳에 있습니다.
함수형 프로그래밍에서 함수는 항상 다른 것에 인수로 전달됩니다.
이 구문에서는 Image와 Text가 리스트처럼 나열되어 있습니다. 이 목록들을 가져와 TubleView로 패키링하는 처리 단계가 진행 중입니다.
따라서 이것은 일제로 이리지와 텍스트라는 두 가지 항목이 포함된 TubleView를 반환하는 함수입니다.

'@ViewBuilder'
이 목록을 TubleView로 바꾸는 것을 ViewBuilder라고 합니다. 

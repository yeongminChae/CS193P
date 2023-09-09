#  Lecture7

* Shape
  Shape들은 기본적으로 foregroundColor로 자신을 채우지만 우리는 그 위에 획을 긋고 채우기도 합니다. 그들은 shapeModifier이지 ViewModifier가 아닙니다. 

  - func fill<S>(_ whatToFillWith: S) -> View where S: ShapeStyle : ShapeStyle은 Shape를 가져와서 뷰로 전환하기 위해 작업을 수행하는 방법을 아는 것입니다. 
  - ShapeStyle에 몇가지 예는 색상입니다. 
  
  제네릭이 구조체만을 위한 것이 아닙니다. 
  shape프로토콜은 var body를 구현합니다. shape를 구현할때 view처럼 동작하더라도 var body를 수행할 필요가 없습니다.     

 - Animation
    * ViewModifier는 SwiftUI에서 유일하게 Shape옆에 사용자 정의 에니메이션을 수행할 수 있는 유일한 방법입니다. 단순히 dissolve되거나 뷰가 이동하는 것이 아닌 모든 에니메이션은 ViewModifier 내부에서 수행됩니다. 에니메이션이 변화를 주기 때문에 의미가 있습니다. 
    
* ViewModifier
    - AspectRatio(2/3)는 실제론 .modifier라는 다른 ViewModifier입니다. AspectRatio(2/3)는 .modifier 즉 ViewModifier 프로토콜을 준수하는 struct인 aspect 수정자로 대체할 수 있다면 2/3을 인수로 사용합니다. 
    
    - ViewModifier 프로토콜에는 내부에 함수가 하나만 있습니다. 
    - protocol ViewModifier {
      func body(content: Content) -> some View {
            return // some View that almost certainly contains content
         }
      }
      
      우리가 뷰에서 .modifier를 호출할 때 func본문에 대한 이 content인수는 우리가 방금 호출한 뷰입니다. ViewModifier는 다른 뷰를 취하고, 그것을 수정할 것입니다.  
      func body(content: Content) 이 Content의 뜻은 분명히 구현해야 하는 'don't care'입니다.
      우리는 매우 고전적인 방식인 AspcetVGrid를 사용하여 이를 수행하는 것을 보았습니다. 그곳에 뷰를 전달하세요.
      이것을 코드에 넣는 또 다른 방법인 의사 코드 종류는 몇 가지 인수를 취할 수 있는 새로운 ViewModifier의 View.modifier입니다.
      이 라인의 코드를 실행하면, 내 ViewModifier인 ViewModifier에 콘텐츠로 전달됩니다. 
      그러므로 뷰를 전달받고 다음 작업을 수행합니다. func body안에는 전달되어진 content로 무언가를 할 것입니다. 
      

* Protocol
    - 프로토콜에게 가장 강력한 기능은 바로 '코드 공유' 입니다.
    - 프로토콜은 구현을 하지 않으며, 구현이 자유롭지만, extension을 사용하여 프로토콜에 구현을 추가할 수 있습니다.
    - extension은 새로운 기능을 추가할 수 있을 뿐만 아니라 함수의 기본 구현도(default) 추가할 수 있습니다. 이를 override로 생각하고 싶지만, 개체나 어떤 의미에서는 override하지 않는 경우에는 구현만 하면 됩니다. 
    - 그리고 default를 설정한 다음 직접 구현할 수 있는 이 기능은 데이터 표현에 대한 모든 제한이 동일하지 않으면서 개체나 프로그램에서 얻을 수 있는 것과 동일한 많은 기능을 제공합니다.
    - Swift에서는 프로토콜을 사용하여 구현을 구축하고 있습니다. 그리고 지금까지 프로토콜은 구현이 아닌 사물의 선언일 뿐이라고 설명했었지만 지금부터는 extension이 있으므로 프로토콜도 실제 구현의 양이 엄청나다는 것을 이해하실 것입니다.
    - filter는 배열, range, string, dictionary에서도 작동합니다. 그리고 이 든 코드는 동일합니다.
        filter(_ isIncluded: (Element) -> Bool) -> Array<Element>
        이 코드는 프로토콜 시퀀스에 있습니다. 시퀀스는 배열과 범위, 문자열과 사전이 모두 구현되는 프로토콜입니다. 
    - 시퀀스는 항목을 반복하는 방법을 알고 있습니다. 따라서 이러한 기본 사항을 갖춘 후 애는 각 항목을 통과하여 필터링하는 extension을 시퀀스에 추가할 수 있습니다.
    - protocol View {
        var body: some View  
      }  
      본문에 하나의 변수가 있는 데 이는 some View를 반환하는 Body입니다.
      extension View {
          func foregroundColor(_ color: Color) -> some View ( /* implemantation */)
          func font(_ font: Font?) -> some View ( /* implemantation */)
          func blur(radius: CGFloat, opaque: Bool) -> some View ( /* implemantation */)
          ...
      }  
      이 모든 기능들은 뷰의 extension에 포함되어 있습니다.
      
    - Generic + Protocols
        protocol Identifiable {
            var id: ID { get } // ID는 제네릭 타입입니다.
        }
        protocol Identifiable {
            associatedtype ID  // struct와 같은 형식으로 정이된 것을 알 수 있습니다. 
            var id: ID { get } // ID로 제공하는 것이 무엇이든 Hashabale해야 하기 때문에 제네릭 이어도, 신경을 써야 합니다.("I don't care" 이지만 사실은 "Care lil bit" 인 것입니다.)
                               // 그렇기 때문에 우리는 여기에 "where"를 추가해야 합니다.
        }
        protocol Identifiable {
            associatedtype ID where ID: Hashable   
            var id: ID { get }
        }
        protocol Identifiable {
            associatedtype ID Hashable (more simple)
            var id: ID { get }
        }

    - some and any
        * some : 프로토콜을 함수 안팎으로 심지어 var 안팎으로 불투명(opaqualy)하게 전달하는 데 사용됩니다.
                불투명(opaqualy) : 이것을 전달하면 그 프로토콜을 구현한다는 것을 알게 될 것이라는 뜻이지만 그것이 해당 프로토콜을 준수 한다는 것을 알고 있습니다.
          some을 return type으로 생각할 때, 중요한 점 중 하나는 함수가 항상 동일한 유형을 반환하여 some View에서 그것이 무엇인지 알아낼 수 있다는 것입니다. 아시다시피 return type 으로 some View가 있으면 여기에서 computed property를 조사하여 그것이 무엇인지 파악하게 되기 때문입니다. 
          some은 매개변수, 함수에 대한 인수일 때 사용됩니다.
          <실제 fill 함수>
          func fill<S>(_ whatToFillWith: S) -> View where S: ShapeStyle
          <이렇게도 표현 가능>
          func fill(_ whatToFillWith: some ShapeStyle)
          some이라는 인수를 전달하는 것은 해당 some type이 있는 곳에 generic을 갖는 것과 같습니다.
        
        * any : any는 heterogeneous(이질의) 배열이나 컨테이너를 갖는 방법입니다. 
          복잡한 프로토콜 특히 equatable 프로토콜과 같이 자기 참조적인 프로토콜이 있다면, 두 인수는 동일시하는 유형입니다. 따라서 해당 프로토콜은 자기 참조적입니다. (self-referential) 내부 함수의 인수 유형은 자신을 참조합니다.
          따라서 자체 참조 프로토콜이 있거나 거기에 제네릭이 포함된 프로토콜이 있다면 해당 배열이라고 할 수는 없습니다.
          이럴 경우에, any한 것들을 array에 담습니다.
          그러므로 any identifiable한 배열을 가질 수 있습니다. identifiable에는 제네릭이 있지만 any identifiable 이라고 말할 수 있습니다.  

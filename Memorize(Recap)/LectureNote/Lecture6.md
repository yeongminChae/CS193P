#  Lecture6

* Layout : 화면의 공간은 어떤가요? 거기에 나타나는 모든 보기에 할당되고 배분됩니다.
    - 1. 뷰에 약간의 공간이 제공됩니다. 앱 상단에 있는 ContentView가 전체 화면에 제공됩니다. 그러나 일단 HStack, VStack을 만들기 시작하면 아래로 내려갈수록 제공되는 공간이 점점 줄어들게 됩니다. 
        컨테이너 뷰(Hstack, VGrid...) 들이 제공하는 것은 일정량의 공간을 차지합니다.  
    - 2.(중요) 전체 시스템이 작동하게 만드는 것은 공간이 제공되었더라도 보기가 가능하다는 것입니다. TextView, 이미지 또는 원하는 크기를 선택하는 것은 View 자체입니다. View에 크기를 강제로 적용할 수 있는 방법은 없습니다. View는 사이즈를 자체 선택하고 제공된 공간을 기준으로 크기를 선택합니다. 그들이 사이즈를 선택한다는 이 불가침한 규칙은 시스템이 완전히 예측 가능하도록 만드는 많은 이유입니다. 
    - 3. 일단 View가 크기를 선택하면 컨테이너 뷰가 다시 들어오고 HStack 측면에 바로 배치됩니다. 여러분이 아는 모든 것이 균등하게 배치되거나 일부가 더 많이 붙여넣어지나요? 그것들을 배치하는 것은 HStack에 달려 있습니다. 따라서 위치 지정은 View자체에서 선택한 컨테이너 크기에 의해 수행되며 컨테이너에 의해 위치가 지정됩니다. 
    
    * HStack and VStack : '유연성'은 HStack 과 VStack의 작동 방식의 핵십입니다. 
        * 유연성? 가장 낮은 유연성을 지닌 View요소 = 이미지, 가장 높은 유연성을 지닌 View요소 = Text,RoundRectangle
        
        - 가장 낮은 첫 번째 View에 공간이 제공된 후 HStack은 해당 공간에서 할당할 공간을 제공한 후 나머지 공간을 가져오고 다음으로 가장 낮은 유연성을 지닌 보기로 이동합니다. 즉 가장 유연한 View요소들이 먼저 공간을 차지하고 공간이 남을 때까지 다음으로 최소한의 유연성을 지닌 보기들이 차례차례 공간을 차지합니다. 
        - 그럼 다음 HStack 또는 VStack이 크기를 지정한 후 크기에 맞게 자체적으로 공간을 조정합니다. 즉 모두 Inflexible Views인 경우 원래 제공되었던 공간보다 작을 수 있음을 의미합니다. 
        - layoutPriority를 사용하면 flexible한 정도를 자체적으로 override할 수 있다. 가장 우선순위가 높다면 HStack에서 공간을 확보할 수 있는 첫번째 기회를 얻을 수 있습니다.     
     
    * LazyHStack and LazyVStack : 'Lazy'의 뜻은 주로 화면에 없는 뷰를 실제로 레이아웃하지 않을 것임을 의미합니다. Lazy의 한가지 특징은 내부 공간을 모두 차지하지 않는 다는 것입니다. 비록 유연하더라도 내부의 이View는 VStack과 HStack과는 다릅니다. VStack과 HStack 유연성이 있는 경우 추가 공간을 사용하게 됩니다. 
        그렇지 않기 때문에 항상 ScrollView내부에 배치하게 됩니다. 내부 항목의 크기로 축소할 것이기 때문입니다.
        세로 비율과 같이 유연성을 제한하는 것이 있거나, 실제 크기가 되도록 만드는 다른 것이 없으면 일반적으로 거기에 유연한 것을 넣지 않습니다. 

    * LazyHGrid and LazyVGrid : 내부 항목에 맞게 크기가 조정된다는 점에서 비슷하므로 ScrollView내부에 배치하게 됩니다.
    
    * Grid : 그리드는 H, V가 없습니다. 따라서 그리드는 양방향으로 항목을 배치하는데 사용하는 보기입니다. 그리드는 스프레드시트 뷰 혹은 테이블 뷰로 생각하고 있습니다.
    
    * ScrollView : ScrollView는 항상 제공된 모든 공간을 차지합니다. 그런 다음 항목을 내부에 넣고 스크롤 할 수 있도록 합니다. 
    
    * ViewThatFits : ViewBuilder에는 일반적으로 2~3개의 View목록이 있습니다. 그리고 수행할 작업은 모든 뷰의 크기를 확인하는 것입니다. ViewThatFits에서 제공된 크기에서 적합한 것을 선택합니다. 가장 좋은 예는, ViewThatFits가 있고 그 ViewBuilder에 항목이 포함된 HStack과 항목이 포함된 VStack이 있다는 것입니다. 
    
    * Form, List, OutlineGroup, DisclosureGroup : 이는 selection과 같은 사항을 알고 있는 일종의 매우 스마트한 VStack입니다. VStack 또는 계층 구조에서 항목 선택, 아마도 클릭할 수 있는 데이터가 있을 수 있습니다. 
    
    * Layout Protocol : Layout Protocol을 사용하여 본인이 원하도록 커스텀하여 사용할 수 있습니다. 
    
    * ZStack : 사용자 방향을 알고 있으므로 장치에서 사용자 쪽으로 요소들을 쌓고 있습니다. ZStack에는 정렬이 있고 거기에 요소들을 넣을 것입니다. 
        - 알아야 할 중요한 것은 하위 항목들 중 하나라도 완전히 유연한 요소(ex : roundedRectangle())가 있다라면 전체 ZStack은 완전한 유연성을 갖게 됩니다. 왜냐하면 가능한 많은 공간을 제공하기를 원하기 때문입니다. ZStack이 이해해야 할 핵심 사항 중 하나는 무슨 일이 벌어지고 있는지입니다. 이 ZStack의 크기가 되고 맞아야 할 가장 큰 것이 될 것입니다.
    * .baackground() : baackground modifier는 단일 view대신 viewBuilder가 아닌 단일 뷰를 사용합니다. 이 단일 뷰를 가져와 수정 중인 뷰 '뒤'에 ZStack뷰를 배치합니다. 하지만 크기는 배경이 아닌 기본 뷰에 의해 결정됩니다. 
    
    * .overlay() : overlay modifier는 baackground와는 정반대입니다. '앞쪽에' 있는 것이 뒤쪽에 있는 모든 것에 속해집니다.
    
    * modifier : 
        - 여기 레이아웃에서 ViewModifier에 대해 이야기하는 이유는 실제로 많은 modifier가 본질적으로 작은 레이아웃 엔진과 같기 때문입니다. 그런 식으로 생각하고 싶다면 background 색상이나 글꼴과 같은 일부는 레이아웃이 아니라는 의미입니다. 그들은 어떤 크기가 제공되는 상관없이 아무것도 하지 않기 때문에 바로 수정하고 있는 뷰에 전달하기만 합니다. 
        - 하지만 padding과 같은 것들은 실제로 사용할 수 있는 공간을 변경합니다. 따라서 padding은 제공된 공간을 차지하는 작은 레이아웃으로 생각할 수 있습니다. 약간 축소한 다음 해당 공간을 내부 항목에 제공합니다. 
        - 다른 예시로는 aspectRatio라는 것이 있습니다. 이는 aspect비율에 의해 반환되는 뷰입니다. 제공된 공간을 사용합니다. 제공된 공간 내부의 가로세로 비율에 있는 크기를 선택합니다. 이것이 .fit입니다. 아니면 한쪽 가장자리가 가장 큰 크기이고 가능한 한 큰 크기를 선택합니다. 따라서 제공된 크기보다 더 커지게 됩니다. 이것이 .fill 옵션입니다. 이 작업이 완료되면 내부 항목에 해당 공간을 제공하게 됩니다. 그런 다음 해당 항목이 선택하는 것은 무엇이든 됩니다. 올바른 비율인 뷰의 중앙에 위치할 것입니다. 
        - 따라서 이 ViewModifier와 aspectRatio 및 padding은 HStack 과 VStack 같은 역할을 합니다. 
        
    * GeometryReader : GeometryReader는 제공되는 모든 공간을 차지하는 뷰입니다. 크기를 확인한 다음 이를 subVisw에 바로 전달합니다. 즉 contentView와 함께, 이 작은 프록시인 GeometryProxy는 크기를 알려줍니다.  
        - var body: View {
            GeometryReader { geometry in 
                ... // 발견한 것은 여기에 GeometryReader가 있습니다. 프록시가 여기에서 정보를 알려줍니다. 나에게 제공된 공간은 얼마나 큽니까? 이 프레임과 좌표계는 좌표 공간이 있는 직사각형이고 이 좌표 공간은 뷰의 로컬 좌표 공간일 수도 기기의 전역 좌표 공간일 수도 있습니다.  
            }
        }
        
        // geometry parameter는 GeometryProxy 입니다. 
        - struct GeometryProxy {
            var size: CGSize
            func frame(in: CoordinateSpace) -> CGRect
            var safeAreaInsets: EdgeInsets
        }
        - GeometryReader는 제공된 크기를 전달하는 wrapper뷰와 같습니다. 이해해야 하는 중요한 GeometryReader의 트릭만 제공됩니다. 제공된 모든 공간을 사용합니다. 그것이 제대로 작동할 수 있는 유일한 방법은 전체 아이디어가 사용자에게 얼마나 많은 공간이 제공되었는지 알려주는 것이기 때문입니다. 따라서 모든 공간을 사용해야 합니다.
        
    * @ViewBuilder : 조건이 있고 약간의 뷰 목록을 갖는 것이 바로 이 방법입니다. 뷰를 반환하는 함수를 사용하고 그런식으로 해석합니다. 이것이 필요한 이유는 뷰 묶음을 가지고 있는 경우가 많지만 뷰로 전달하고 싶기 때문입니다. 그러므로 ViewBuilder를 통해 여러 뷰를 결합하여 단일 뷰를 만들 수 있습니다. 
        우리가 배운 뷰는 TupleView인 경우가 많으므로 TupleView는 단지 여러 뷰를 포함할 수 있는 뷰일 뿐입니다. 
        - @ViewBuilder
        func front(of card: Card) -> some View {
            let shape = RoundedRectangle(cornerRadius: 20)
            shape.fill(.white)
            shape.stroke()
            Text(card.content)
        }
            

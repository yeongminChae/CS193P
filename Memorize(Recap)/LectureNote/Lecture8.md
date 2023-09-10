#  Lecture 8

* property observers : View에서 사용하는 "onChangeOf"와는 유사한 항목입니다. 우리는 이러한 모든 값 유형인 Swift가 상황이 변하는 시기를 감지할 수 있다는 것을 알고 있습니다.
    함수는 mutating으로 표시되므로 어떤 함수가 내용을 수정할 지 알 수 있습니다.
    변수를 지켜보다 그 변수의 값이 설정되면 이를 관찰할 수 있습니다. 그것이 property observing 이라는 단계입니다. 
    
    - var isFaceUp: Bool {
        willSet {
            if newValue {
                startUsingBonusTime() 
            } else {
                stopUsingBonusTime()
            }
         }
      }  
    이 isFaceUp 변수는 computed property와 매우 비슷해 보이지만 실은 전혀 상관이 없습니다. 
    이것은 그저 단순한 var입니다. 하지만 저는 이것이 언제 변하는지 관측하고 싶습니다. (willSet사용하는 이유)
    (didSet 이라는 변수도 있음 이는 isFaceUp이 변경된 직후에 호출됨. -> oldValue사용) 
    
    - onChange(of:) { }
        어떤 특성을 관찰하고 있다면 현재 하고 있는 일을 다시 그리는 것과 동기화하여 수행하고 싶을 것입니다.
        따라서 @State에서는 property observers를 사용하지 않습니다. 대신에 onChange(of:)를 사용합니다.
        이는 view modifier로써 어떤 뷰에도 넣을 수 있습니다. 
        
        @State private var taps = 0
        
        Text("\(taps) taps")
            .onChange(of: viewModel.cards) { newCards in
                taps += 1
             }
        즉 이 일련의 과정은 @State 및 @Published 변수의 변경 사항을 추적하려고 할 때 사용되는 것입니다.
        
* Animation : Animation은 일반적으로 시간이 지남에 따라 모델의 변화를 보여주는 것뿐입니다. 그리고 이 변경 사항은 viewModifier 인수를 통해 반영되며 분명히 모양이 변경될 수 있습니다.
    <Animation은 이미 발생한 변경사항을 보여주며 시간이 지남에 따라 보여줍니다. 비동기 프로그래밍이나 그와 유사한 작업을 수행해 본 적이 있는 사람들에게는 익숙해지는데 시간이 걸립니다. >
    viewModifier는 UI의 주요 변경 에이전트입니다. 
    viewModifier는 실제로 모든 일을 진행하게 만드는 요소이며 우리가 수행하는 데모에서 실제로 이를 확일할 수 있습니다. 
    viewModifier 인수 변경에 대해 이해해야 할 한가지는 View가 화면에 표시된 후에만 에니메이션이 적용된다는 것입니다.
    화면에 나타날 때 임의의 값에서 에니메이션이 적용되지는 않습니다. 화면에 나오면 그 값이 됩니다. 그리고 그것이 바뀌면 그때 Animation을 보게 될 것입니다.
    
    - Animation을 발생시키는 법
        1. 암시적(implicit) Animation : 우리가 셔플에서 본 에니메이션입니다. 여기서 아이디어는 Animation라는 viewModifier를 사용하여 영향을 미치는 모든 것, 즉 우리가 적용하는 뷰가 상황이 변할 때 에니메이션으로 표시되도록 만드는 것입니다. 그리고 이 에니메이션이 적용되려면 어떤 값과 어떤 사항을 변경해야 하는지 알려줍니다.
            * 암시적(implicit) Animation : 이것은 본질적으로 viewModifier입니다. 따라서 viewModifier가 추가되기 전에 해당 View에서 발생하는 모든 일이 View에 표시되도록 View를 표시합니다.
            
        2. 명시적(explicit) Animation : 이제 'withAnimation'으로 우리가 하고 있는 작업들을 여기에 래핑합니다. 그리고 우리가 내부에서 한 일로 인해 변화된 모든 것이 withAnimation화 됩니다. 
            이는 암시적인 방법이 아니라 실제로 Animation을 수행하는 기본 방법입니다.
            * 에니메이션이 다른 여러 뷰와 함께 사용된다면 이를 유발하는 변경 사항을 명시적 Animation으로 처리할 것입니다.
            * 명시적(explicit) Animation : 명시적 Animation은 본질적으로 함께 Animation화 될 코드 블록을 래핑하는 것입니다. 
            명시적 Animation은 거의 항상 viewModel에 intent함수를 래핑합니다.
            <암시적 Animation은 명시적 Animation보다 훨신 강력합니다. 명시적으로 무언가에 Animation을 적용하고 그 안에  .animation이 있으면 .animation에 코드가 적용될 것입니다.>   
            
        3. UI에서 뷰를 포함하거나 제외하는 방법 : UI에서 뷰를 제거하면 어떤 종류의 에니메이션이 발생하는지 설정할 수 있다고 말씀드렸기 때문입니다. 이를 UI에서 제거하거나 추가하면 에니메이션이 발생합니다.
        
    - Animation Curve : 에니메이션에 걸리는 시간을 분활하는 방법입니다. 
        (I.e : .easeInOut 천천히 시작되다 속도가 빨라지고 마지막에는 다소 느려지는 효과)
        
* Transition : Transition은 View가 들어오가 나가는 것과 관련이 있습니다. viewModifier가 바로 이것입니다. 
    * 'CTAOS' is Containers That Are Already On Screen.
    
    - 뷰에 대해 전환이 발생하도록 하려면 이미 화면에 있는 컨테이너에 있어야 합니다. Transition 내부에서는 실제로 한 쌍의 viewModifier에 지나지 않습니다. 화면에 표시되는 전환은 화면에 표시되기 전에 해당 viewModifier의 인수가 있는 하나의 viewModifier와 화면에 표시될 때 해당 viewModifier에 대한 인수가 있는 또 다른 viewModifier이며, 표시될 때 두 viewModifier 사이에서 에니메이션을 적용할 뿐입니다.
    
    - 그리고 화면을 벗어나기 위한 또 다른 쌍인 viewModifier, 화면이 사라지기 직전의 모습 그리고 화면이 꺼질 때 인수가 설정된 또 다른 viewModifier가 있을 수 있으며 이 둘 사이에서 에니메이션을 적용할 뿐입니다. 
    
    - AnyTransition : AnyTransition은 유형이 지워진 전환 구조체입니다. 이제 우리가 type erasing을 수행하는 이유에 대해 이야기 하지는 않겠습니다. 그러나 여러분의 관점에서는 전환을 수행하는 구조체를 AnyTransition으로 생각하세요. 
    
    - 어떻게 이 효과들을 적용하나요? 
            .transition이라는 viewModifier을 사용하면 됩니다. 
    
    - Transition은 Animation과는 다릅니다. transition은 전체 View에 적용됩니다. 
    
* Matched Geometry Effect : 때로는 한 위치에서 다른 위치로 이동하고 싶은 View가 있습니다. 때로는 shuffle과 같습니다. (동일한 컨테이너에 존재한다면.)
    - 만일 View가 동일한 컨테이너에 존재하지 않는다면 어떻게 될까요? .position만 변경할 수는 없으므로 이 방법은 작동하지 않습니다. .position viewModifier는 컨테이너 내에 있습니다. 다른 View는 컨테이너 외부 어딘가에 위치합니다. 이렇게 하기위해서는 실제로 두 개의 보기가 필요합니다. 전역 화면에 .position이 없습니다. 오직 컨테이너 내부에만 위치합니다. 
        이걸 위해서는 실제로 두 개의 뷰가 필요합니다. 하나의 컨테이너에 하나, 다른 컨테이넌에 하나 그리고 다른 하나를 나마지 것에 추가하는 동시에 하나를 제거해야 합니다. 그리고 당신은 그들의 gemoetry를 일치시킬 것입니다. 
        
* .onApear : View가 등장하자마자 에니메이션을 시작하고 싶을 때 사용하는 viewModifier. 해당 클로저는 View가 화면에 나타날 때마다 실행됩니다. 화면에 나타날때 당신은 정의상 이미 화면에 있는 컨테이너 안에 있는 것입니다. 이제 당신은 에니메이션을 적용할 수 있습니다. 
    .onApear내부에서는 일부 변수를 초기화하고 일부 데이터를 준비하는 등의 작업을 수행할 수 있습니다. 동시에 내부에서 withAnimation을 수행하여 에니메이션을 시작할 수도 있습니다. 

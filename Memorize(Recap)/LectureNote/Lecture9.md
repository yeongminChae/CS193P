#  Lecture9

* Tuple : 튜플은 괄호 안에 데이터 조각을 얼마든지 포함할 수 있습니다. 
    - 튜플을 사용할 때 우리는 Swift의 type inference를 많이 사용한다는 것입니다. 
    - @State private var lastScoreChange: (amount: Int, causedByCardId: Card.ID) = (amount: 0, causedByCardId: "")
    - amount와 같이 이름을 항상 갖고 있을 필요도 없습니다.
    - @State private var lastScoreChange (타입 추론 가능) = (0, causedByCardId: "")


# 🧮 iOS Gunculator

Gundy의 iOS RX-78 건담 테마 계산기 프로젝트입니다. 라이트 모드에서는 RX-78-2의 컬러를 테마로 하고, 다크 모드에서는 RX-78-3의 컬러를 테마로 합니다.

### 주요 기술 스택

**MVVM, Clean Architecture, Delegate, TDD, Unit Test**

## 📖 목차

1. [팀 소개](#-팀-소개)
2. [앱 분석](#-앱-분석)
3. [클래스 다이어그램](#-클래스-다이어그램)
4. [폴더 구조](#-폴더-구조)
5. [타임라인](#-타임라인)
6. [실행 화면](#-실행-화면)
7. [트러블 슈팅 및 고민한 부분](#-트러블-슈팅-및-고민한-부분)
8. [참고 자료](#-참고-자료)

## 🌱 팀 소개

|[Gundy](https://github.com/Gundy93)|
|:-:|
| <img width="180px" img style="border: 2px solid lightgray; border-radius: 90px;-moz-border-radius: 90px;-khtml-border-radius: 90px;-webkit-border-radius: 90px;" src= "https://avatars.githubusercontent.com/u/106914201?v=4">|
|커뮤니케이션 최고!|

## 📲 앱 분석

### 앱의 목표

**숫자**와 **연산자**를 통해 각종 **연산을 수행**한다.

### 레이어 구분

![](https://hackmd.io/_uploads/Sk3SJw4yT.png)

## 📊 클래스 다이어그램

![](https://hackmd.io/_uploads/SkZxdS-t2.png)

## 🗂 폴더 구조

```
Gunculator
├── Gunculator
│   ├── AppDelegate
│   ├── SceneDelegate
│   ├── Resource
│   │   ├── Assets
│   │   └── Info.plist
│   ├── Utility
│   │   └── Extension
│   │       ├── UIButton+
│   │       ├── UIColor+
│   │       ├── UILabel+
│   │       └── UIStackView+
│   ├── Domain
│   │   ├── Entity
│   │   │   └── Operator
│   │   └── UseCase
│   │       ├── Protocol
│   │       │   └── CalculatorUseCase
│   │       └── DefaultCalculatorUseCase
│   └── Presentaion
│       ├── ViewModel
│       │   ├── CalculatorViewModel
│       │   └── CalculatorViewModelDelegate
│       └── ViewController
│           └── CalculatorViewController
└── GunculatorTests
    ├── CalculatorUseCaseTests
    └── CalculatorViewModelTests
```

## 📆 타임라인

| 날짜 | 작업내용 |
|:--:|:--:|
| 9월 16일 | Entity, UseCaseTests, UseCase, ViewModelTests, ViewModel, ViewModelDelegate |
| 9월 17일 | 각종 extension(UIColor, UIStackView, UIButton, UILabel) 생성 및 ViewController 작업 진행 |

## 📱 실행 화면

| 모드별 화면 | 수식 자동 스크롤 | Clear |
|:--:|:--:|:--:|
| ![](https://hackmd.io/_uploads/BygxG94ya.gif) | ![](https://hackmd.io/_uploads/B1VBfqV16.gif) | ![](https://hackmd.io/_uploads/SyBOf54kT.gif) |

| Backspace | +/- | equals |
|:--:|:--:|:--:|
| ![](https://hackmd.io/_uploads/H1FjzqN1a.gif) | ![](https://hackmd.io/_uploads/BJ2bQcNJT.gif) | ![](https://hackmd.io/_uploads/B1dEQ5Eyp.gif) |

## 🎳 트러블 슈팅 및 고민한 부분

### Dark Mode

시스템 컬러를 사용하면 기본적으로 다크 모드와 라이트 모드에 모두 대응하게 UI를 구성할 수 있지만 같은 계열의 컬러로 변하기 때문에 전혀 다른 색상을 원할 때는 사용할 수 없었습니다.


이를 대응하기 위해 dot, numberPad, operator, upperPad 등 모드별로 다른 색상이 필요한 경우에 사용할 컬러 에셋을 추가해 커스텀 컬러를 만들었습니다. 이를 편히 사용하기 위해 UIColor를 extension하여 static let으로 지정해주었습니다. 라이트 모드에서 검은색, 다크 모드에서 흰색을 나타내야하는 경우 UIColor.Label을 사용하였고, 반대의 경우는 UIColor.systemBackground를 사용하였습니다.

| Color Asset | UIColor Extension |
|:--:|:--:|
| ![](https://hackmd.io/_uploads/S1YoBqEyp.png) | ![](https://hackmd.io/_uploads/B1u6BqN1a.png) |

### Data Binding

MVVM 아키텍처를 사용함에 있어서 가장 중요한 부분 중 하나가 데이터 바인딩이라고 생각합니다. 데이터 바인딩에 사용할 수 있는 방법은 여러가지가 있어 무슨 방법을 선택할 지 고민이 되었습니다.

이 프로젝트에는 뷰컨트롤러와 뷰모델이 하나씩 사용될 것이라고 생각해 델리게이트 패턴을 사용하기로 결정했습니다. 델리게이트를 사용하면 뷰모델이 아는 것은 오직 프로토콜이기 때문에 DIP를 지킬 수 있다고 생각했습니다.

![](https://hackmd.io/_uploads/HkePo541T.png)

### Test Driven Development

기존에는 설계-코드작성의 흐름으로 작업을 하였는데 TDD의 장점을 이해하고자 Unit Test를 작성하며 UseCase, ViewModel의 TDD를 진행하였습니다. 테스트를 작성한 시간을 제외하고 보면 확실히 개발 시간이 줄어드는 것을 체감하였습니다. 엣지 케이스에 대한 테스트가 이루어진다면 개발 단계에서 실수를 미리 막을 수 있겠다는 생각이 들었습니다.

![](https://hackmd.io/_uploads/HJJrB7rka.png)

## 📚 참고 자료

### Human Interface Guidelines

- [**Dark Mode**](https://developer.apple.com/design/human-interface-guidelines/dark-mode)
- [**Scroll views**](https://developer.apple.com/design/human-interface-guidelines/scroll-views)
- [**Labels**](https://developer.apple.com/design/human-interface-guidelines/labels)
- [**Buttons**](https://developer.apple.com/design/human-interface-guidelines/buttons)

### Apple Developer Documentation

- [**Supporting Dark Mode in Your Interface**](https://developer.apple.com/documentation/uikit/appearance_customization/supporting_dark_mode_in_your_interface)
- [**NumberFormatter**](https://developer.apple.com/documentation/foundation/numberformatter)

---

[⬆️ 맨 위로 이동하기](#-ios-gunculator)

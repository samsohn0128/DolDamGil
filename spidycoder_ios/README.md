![logo](https://user-images.githubusercontent.com/48209839/97431236-5134cd80-195d-11eb-96f9-40bb97680951.png)

돌담길은 임베디드, AI 및 모바일이 결합된 스포츠 클라이밍 관련 서비스입니다.

# iOS Application

기존에 iOS 개발 방법 중 가장 간편한 방법인 Interface Builder를 이용하여 스토리보드를 통해 뷰를 만들어 작업하는 방식을 이용하지 않고 모든 뷰를 코드를 이용하여 만들며 Auto Layout을 통하여 모든 기종에서 똑같은 레이아웃을 적용하였습니다.

아직 어느정도 버그가 존재합니다!

## 디렉토리 구성

- Doldamgil
  - Model (CoreData 모델 및 Codable 프로토콜을 채택한 구조체들을 보관하는 디렉토리)
  - VC
    - FirstVC.swift
    - Related Sign (로그인과 관련된 디렉토리)
    - First Sign In (첫 로그인 시 입력하는 내용에 관련된 디렉토리)
    - RootTabVC.swift (UITabBarController의 메인 ViewController)
    - Main Tab (가장 맨 처음에 나오는 화면으로 사용자의 기록과 알림을 확인하는 탭)
    - Dev Tab (엣지 디바이스에 연결하는 탭으로 문제에 관련된 기능에 관련된 탭)
    - Search Tab (센터 검색을 위한 탭)
    - My Tab (사용자의 정보를 확인하는 탭)
  - Shared (공통으로 사용하는 객체를 보관하는 디렉토리)
  - Custom (기존의 UIKit의 Extension 및 추가적으로 만든 파일을 보관하는 디렉토리)

## 기능

- QRCode를 통한 임베디드 기기와의 연결
  - 문제 출제를 후 서버에 저장
  - 문제 선택 후 네트워크를 통해 임베디드에 연결된 프로젝터를 통해 경로 투사
- 로그인 후 개인 정보 (신체정보 및 클라이밍 경험(등급)) 저장 

## 개발 시 사용한 라이브러리

AlamoFire: HTTP 통신을 위한 라이브러리

SwiftyJSON: Swift에서 JSON을 다루기 위한 라이브러리

FSCalendar: 메인 페이지에 달력을 출력하기 위한 오픈 소스 라이브러리

AVFoundation: QR코드 인식을 위하여 카메라에 관련된 내장 라이브러리




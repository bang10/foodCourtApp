## 학식, 푸드코트 예약 APP - 작성중
### 다른 환경
- [관리자]() - 생성전
- [서버](https://github.com/bang10/bookFoodCourtServer)
- [고객사]() - 생성전

## 개발기간
2024.10.11 ~ 

## 개발 환경
- xcode version: 16.0
- swift version: 6.0
- swiftUI
- Library
  1. Alamofire 5.9.1
 
## 개발 설명
학식, 구내식당 식품을 예약할 수 있는 APP입니다. 네이티브 앱으로 개발을 한 이유는 다양한 환경에서 개발을 해보고 싶어서입니다.
기능은 하기와 같습니다.
1. 로그인
2. 회원가입 
3. ID찾기 및 PW 초기화
4. 해당 학교 및 구내식당 구성원 인증 요청
5. 식품 장바구니에 넣기
6. 식품 결제하기
7. 상세 정보 보기

좀 더 편한 로그인을 위해 생체인증을 사용했습니다. 인증은 sms 인증을 추가하여 보안을 좀 더 강화했습니다.
 
## 부가 설명
cocoapods은 m3 pro 호환성 문제로 init부터 오류가 발생합니다. 아래의 순서로 진행을 했는데도 오류가 발생합니다. 주기적으로 계속 확인중입니다.
```
1. brew install cocoa pods
2. Move project root folder
3. pod init
4. sudo gem uninstall ffi && sudo gem install ffi -- --enable-libffi-alloc
6. sudo gem install drb -v 2.0.6
7. sudo gem install activesupport -v 6.1.7.8
8. sudo gem install cocoa pods
9. sudo arch -x86_64 gem install ffi
10. arch -x86_64 pod install
```

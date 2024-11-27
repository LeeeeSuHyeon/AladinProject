# 📚 AladinProject

### 📌 프로젝트 개요
AladinProject는 **알라딘 Open API**를 활용하여 Swift로 개발한 iOS 애플리케이션입니다.  
개인 학습용 프로젝트로, **클린 아키텍처**, **RxSwift**, **MVVM 디자인 패턴**, **카카오 로그인**, **Core Data** 기능 등을 학습하고 활용하기 위해 개발했습니다.

---
[알라딘 OpenAPI 메뉴얼](https://docs.google.com/document/d/1mX-WxuoGs8Hy-QalhHcvuV17n50uGI2Sg_GHofgiePE/edit?tab=t.0)

### 🚀 주요 기능

#### 1. 로그인
- **카카오 로그인을 사용한 인증 구현**
  - **Keychain**에 저장된 토큰이 있으며, 그 토큰이 유효하다면 바로 메인페이지로 이동.
  - 저장된 토큰이 없거나, 유효하지 않을 경우 카카오 로그인 로직 실행.
  - 로그인 성공 시, 발급받은 토큰을 **Keychain**에 저장.  
  - 로그인 후 메인 페이지로 이동.

#### 2. 홈 탭
- 검색 텍스트 필드 제공.
- **`UICollectionViewCompositionalLayout` 기반 3가지 섹션 구성**  
  1. **신간 도서**  (구현 완료)
  2. **카테고리**  (구현 중)
  3. **인기(베스트셀러)** (구현 완료, 페이지네이션 적용)  
- 도서 터치 시 **디테일 뷰**로 이동하여 상세 정보 확인 가능:  
  - 도서 제목, 저자, 가격, 내용 등.
  - '찜' 기능 제공 (CoreData를 이용하여 로컬 DB에 저장).

#### 3. 찜 탭
- **찜한 도서 목록 표시 (CoreData 기반)**  
  - 테이블뷰 형태로 최근 찜한 도서 순서대로 정렬.  
  - 도서 선택 시 디테일 뷰로 이동.  
  - 찜 해제 기능 제공 (하트 버튼 클릭 시, CoreData에서 관련 데이터 삭제).

#### 4. 내 정보 탭
- 카카오 로그인 정보 표시:
  - 프로필 사진, 이름.

#### 5. 검색
- **검색 텍스트 필드 선택 시 검색 뷰로 이동**
-  **`UICollectionViewCompositionalLayout` 기반 2가지 섹션 구성**  
   1. **최근 검색 기록** (CoreData 저장) 표시:  
    - 검색 기록별 삭제 가능.  
    - 전체 삭제 버튼 제공.  
   2. **알라딘 Open API 기반 도서 검색**:  
    - 검색 결과 페이지네이션 구현.  
    - 검색 결과 선택 시 디테일 뷰로 이동.

---

### 🛠 기술 스택

#### **언어 및 아키텍처**
- **Swift**
- **MVVM 디자인 패턴**
- **클린 아키텍처**

#### **라이브러리 및 프레임워크**
- `Alamofire` (네트워크 통신)
- `KakaoOpenSDK` (카카오 로그인)
- `Kingfisher` (이미지 처리)
- `RxSwift` & `RxCocoa` (반응형 프로그래밍)
- `SnapKit` (레이아웃)
- `Then` (코드 간결화)
- `CoreData` (데이터 저장)
- `Security` (Keychain 활용)
- `UIKit` (UI 구성)

---

### 🔒 보안
- **API Key 관리**:  
  모든 API Key는 **Configuration settings file**로 관리하여 보안을 강화했습니다.

---

### 📂 프로젝트 구조

```plaintext
📦AladinProject
 ┣ 📂App                    # 앱의 진입점 (AppDelegate, SceneDelegate)
 ┣ 📂Assets.xcassets        # 리소스 및 이미지 파일
 ┣ 📂Data                   # 데이터 레이어
 ┃ ┣ 📂CoreData             # CoreData 모델 관리
 ┃ ┣ 📂Network              # 네트워크 통신 및 세션 처리
 ┃ ┃ ┣ 📂Session            # 네트워크 세션 처리
 ┃ ┣ 📂Repository           # 데이터 저장소
 ┣ 📂Domain                 # 도메인 레이어 (Entity, Usecase, Protocol 등)
 ┃ ┣ 📂Entity               # 데이터, 에러 모델
 ┃ ┣ 📂RepositortyProtocol  # 의존성 역전 원칙에 따라 Repository 추상화
 ┃ ┣ 📂Usecase              # 핵심 비지니스 로직 
 ┣ 📂Presentation           # 프레젠테이션 레이어
 ┃ ┣ 📂Components           # 공통 UI 컴포넌트
 ┃ ┣ 📂View                 # UI 레이아웃 파일
 ┃ ┣ 📂ViewController       # ViewController 파일
 ┃ ┣ 📂ViewModel            # ViewModel 파일
 ┣ 📂Service                # 서비스 계층 (Keychain 관리 등)
 ┃ ┗ 📂Keychain             # Keychain 관리
 ┣ 📂Extension              # Extension 파일 관리
 ┗ 📜Info.plist             # 앱 설정 정보

```
### 📸 화면 구성
#### 1. 로그인 뷰
- 카카오 로그인 
<img width="200" height="435" alt="비교" src="https://github.com/user-attachments/assets/1d8920f3-4849-4ac1-bab7-4212ca428174">

#### 2. 홈 탭
- 신간 도서, 카테고리, 인기(베스트셀러) 섹션
<img width="200" height="435" alt="비교" src="https://github.com/user-attachments/assets/2d9c5110-1ae0-4665-861c-9f1eb98c3a99">

#### 3. 찜 탭
- 찜한 도서 목록 관리
<img width="200" height="435" alt="비교" src="https://github.com/user-attachments/assets/58f9c155-fd00-4bcf-8d27-4f52540450fa">

#### 4. 내 정보 탭
- 사용자 프로필 정보 표시
<img width="200" height="435" alt="비교" src="https://github.com/user-attachments/assets/0982340a-cb01-413a-a184-05115845a09a">

#### 5. 검색 뷰
- 최근 검색 기록과 도서 검색 결과 표시
<img width="200" height="435" alt="비교" src="https://github.com/user-attachments/assets/86921a0a-0988-4a10-b48f-b87cd4861c0d">

--- 
### 🤝 배우고 느낀 점
1. **클린 아키텍처 구조**로 설계하고 구현한 뒤, 기능 추가나 삭제 시 유지보수를 직접 진행해보면서 클린 아키텍처의 효율성과 중요성을 느끼고 배울 수 있었습니다.
2. **Keychain**과 **CoreData**를 통해 데이터 보안 및 로컬 데이터 관리 방법을 배우고 안전하고 효율적인 데이터 관리 방법을 배웠습니다.
3. **UICollectionViewCompositionalLayout**를 활용하여 복잡한 UI를 효과적으로 구현하는 방법을 배웠습니다.
4. Open API 활용하여 API 요청 파라미터, 응답(Response), API Key 관리를 경험해보면서 API를 분석하고 효과적으로 활용할 수 있었습니다.
5. **MVVM 패턴의 Input, Output 구조**과 **RxSwift**를 적용하여 반응형 프로그래밍을 경험해보면서 데이터 처리 흐름을 이해할 수 있었습니다.
6. **카카오 로그인**을 구현하며 Keychain을 이용한 토큰 관리와 카카오 계정 정보를 연동하는 과정을 경험할 수 있었습니다.

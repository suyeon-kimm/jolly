// Smile 객체 배열 선언
Smile[] smiles;
int numOfSmiles = 15;  // Smile 객체의 수를 늘림

void setup() {
  size(800, 600);  // 창 크기 설정
  smiles = new Smile[numOfSmiles];  // 객체 배열 초기화
  
  // 각 Smile 객체 초기화
  for (int i = 0; i < numOfSmiles; i++) {
    smiles[i] = new Smile(random(width), random(height), random(30, 60), random(-3, 3), random(-3, 3));
  }
}

void draw() {
  background(220);  // 배경색 설정
  
  // 모든 Smile 객체를 업데이트하고 화면에 표시
  for (int i = 0; i < numOfSmiles; i++) {
    smiles[i].update(smiles, i);  // 객체 배열과 인덱스를 전달하여 충돌 체크 포함
    smiles[i].show();  // 객체를 화면에 표시
  }
}

// Smile 클래스 정의
class Smile {
  float x, y, d;  // 객체의 위치(x, y)와 지름(d)
  float speedX, speedY;  // 객체의 속도
  color c;  // 객체의 색상
  
  // 생성자: 객체의 초기 위치, 크기, 속도를 설정
  Smile(float initX, float initY, float initD, float initSpeedX, float initSpeedY) {
    x = initX;
    y = initY;
    d = initD;
    speedX = initSpeedX;
    speedY = initSpeedY;
    c = color(255, 204, 0);  // 초기 색상(노란색)
  }
  
  // 객체의 위치를 업데이트하고 충돌을 체크하는 메서드
  void update(Smile[] others, int currentIndex) {
    // 객체의 위치 업데이트
    x += speedX;
    y += speedY;

    // 화면 경계에 부딪히면 반사
    if (x - d/2 < 0 || x + d/2 > width) speedX *= -1;  // 좌우 경계에서 반사
    if (y - d/2 < 0 || y + d/2 > height) speedY *= -1;  // 상하 경계에서 반사
    
    // 다른 객체와 충돌 체크
    for (int i = 0; i < others.length; i++) {
      if (i != currentIndex && isColliding(others[i])) {  // 현재 객체와 다른 객체만 비교
        bounce();  // 충돌 시 속도 변경
        changeColor();  // 충돌 시 색상 변경
      }
    }
  }
  
  // 객체를 화면에 그리는 메서드
  void show() {
    fill(c);  // 설정된 색상으로 채우기
    noStroke();  // 외곽선 없음
    ellipse(x, y, d, d);  // 얼굴 그리기
    
    // 눈 그리기
    fill(0);  // 검은색 눈
    ellipse(x - d*0.2, y - d*0.2, d*0.1, d*0.1);  // 왼쪽 눈
    ellipse(x + d*0.2, y - d*0.2, d*0.1, d*0.1);  // 오른쪽 눈
    
    // 입 그리기
    arc(x, y + d*0.1, d*0.6, d*0.3, 0, PI);  // 아치형 입
  }
  
  // 객체 간 충돌 여부를 확인하는 메서드
  boolean isColliding(Smile other) {
    float distance = dist(x, y, other.x, other.y);  // 두 객체의 거리 계산
    return distance < (d / 2 + other.d / 2);  // 거리 비교: 충돌 여부 판단
  }
  
  // 충돌 시 속도 변경
  void bounce() {
    speedX = random(-3, 3);  // 속도를 무작위로 변경
    speedY = random(-3, 3);  // 속도를 무작위로 변경
  }
  
  // 충돌 시 색상 변경
  void changeColor() {
    c = color(random(255), random(255), random(255));  // 무작위 색상 생성
  }
}

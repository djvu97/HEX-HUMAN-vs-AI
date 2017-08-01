int numBaseSides = 6;
int sideSize = 100;
float s = 0;
float totalScale = 1.0;
float timeScale = 0.8;
float diff = 0.05f;

float triangleHeight = sqrt( pow(sideSize, 2)- pow((sideSize/2.0), 2)); 
void dothis() {
  fill(0);
  background(255);
  textFont(mono);
  textSize(50);
  textAlign(CENTER);
  fill(0);
  text("HEx", 350, 100);
  textAlign(CENTER);
  textSize(20);
  text("A New Approach*", 350, 120);
  textSize(30);
  text("Click mouse to Continue", 350, 500);

  //textFont(mono1);
  //textSize(14);
  //text("*Its the same old Approach just branded as new", 500, 550);
  translate(width/2, height/2);

  scale(totalScale);

  rotate(PI/2);
  drawBase();
  drawExternalTriangles();
  totalScale -= 0.004f * timeScale;
  s += 0.02f * timeScale;

  if (totalScale <= 0.5) {
    totalScale = 1;
    s = 0;
  }
}
void drawExternalTriangles() {
  int triIndex = 0;

  for (float i = 0; i < 6; i++) {
    pushMatrix();

    rotate(i * TWO_PI/6.0);
    translate(0, -triangleHeight*1.5);

    // left
    pushMatrix();
    translate(-sideSize/2, 0);
    float s1 = min(1, max(s - (triIndex * diff), 0));
    scale(s1);
    rotate(PI);
    triangle(sideSize/2, triangleHeight/2.0, -sideSize/2, triangleHeight/2.0, 0, -triangleHeight/2.0);
    popMatrix();
    triIndex++;

    // center
    pushMatrix();
    float s2 = min(1, max(s - (triIndex * diff), 0));
    scale(s2);
    triangle(sideSize/2, triangleHeight/2.0, -sideSize/2, triangleHeight/2.0, 0, -triangleHeight/2.0);
    popMatrix();
    triIndex++;

    // right
    pushMatrix();
    translate(sideSize/2, 0);
    float s3 = min(1, max(s - (triIndex * diff), 0));
    scale(s3);
    rotate(PI);
    triangle(sideSize/2, triangleHeight/2.0, -sideSize/2, triangleHeight/2.0, 0, -triangleHeight/2.0);
    popMatrix();
    triIndex++;

    popMatrix();
  }
}

void drawBase() {
  for (float i = 0; i <= numBaseSides; i++) {
    pushMatrix();
    rotate(i * (TWO_PI/numBaseSides));
    fill(0);
    triangle(sideSize/2, triangleHeight, -sideSize/2, triangleHeight, 0, 0);
    popMatrix();
  }
}
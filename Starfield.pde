//Particle[] particles;
ArrayList<Particle> particles;
int num = 350;
boolean hyperSpace;
void addParticle() {
  float randX = (float)(Math.random()*20)-10.0;
  float randY = (float)(Math.random()*20)-10.0;
  int randSize = (int)(Math.random()*6)+4;
  int randLen = (int)(Math.random()*50)+25;
  particles.add(new StarParticle(250.0,250.0, 250.0, 250.0, randSize, randLen));
  // particles.get(particles.size()-1).setSpd();
  // particles.add(new JumboStar(250.0, 250.0, 50);
}
void addJumboStar() {
  particles.add(new JumboStar(250.0, 250.0, 50));
}
int count = 0;
void setup() {
  size(500, 500);
  background(0);
  //particles = new Particle[num];
  particles = new ArrayList<Particle>();
  for(int i=0;i<num;i++) {
    addParticle();
    particles.get(i).setSpd();
    particles.get(i).show();
  }
  hyperSpace = false;
}
void draw() {
  background(0);
  for(int i=0;i<particles.size();i++) {
    if(particles.get(i).getCurrentX() > 500 || particles.get(i).getCurrentY() < 0 || particles.get(i).getCurrentX() > 500 || particles.get(i).getCurrentY() < 0) {
        particles.remove(i);
        continue;
    }
    particles.get(i).move();
    particles.get(i).show();
  }
  addParticle();
  if(count >= 5 && !hyperSpace) {
    addJumboStar();
    count = 0;
  } else if(!hyperSpace) {
    count += 1;
  }
}

class StarParticle implements Particle {
  int strokeSize;
  float originX,originY;
  float currentX,currentY;
  float spdX,spdY;
  float newX,newY;
  int len;
  float direction;
  StarParticle(float originX, float originY, float x, float y, int strokeSize, int len) {
    this.strokeSize = strokeSize;
    this.currentX = x;
    this.currentY = y;
    this.originX = originX;
    this.originY = originY;
    this.len = len;
    this.direction = (float)(Math.random()*2*Math.PI);
    setSpd();
  }
  public void move() {
    newX += spdX;
    newY += spdY;
    if(!hyperSpace) {
      currentX += spdX;
      currentY += spdY;
      return;
    }
    // makes a star strech
    if(len <= 0) {
      currentX += spdX;
      currentY += spdY;
    }
    len--;
  }
  public void show() {
    stroke(0, 0, (int)(Math.random()*150)+50);
    strokeWeight(strokeSize);
    line(currentX, currentY, newX, newY);
  }
  public float getCurrentX() {
    return currentX;
  }
  public float getCurrentY() {
    return currentY;
  }
  public void setSpd() {
    int maxSpd = 5.25;
    spdX = (float)(Math.cos(direction) * maxSpd);
    spdY = (float)(Math.sin(direction) * maxSpd);
    newX = currentX;
    newY = currentY;
  }
}

class JumboStar implements Particle {
  float starX, starY;
  int starSize;
  float spdX;
  float spdY;
  float direction;
  JumboStar(int x, int y, int size) {
    starX = x;
    starY = y;
    starSize = size;
    direction = (float)(Math.random()*2*Math.PI);
    setSpd();
  }
  float getCurrentX() {
    return starX;
  }
  float getCurrentY() {
    return starY;
  }
  void move() {
    if(hyperSpace) {
      starX += spdX*5;
      starY += spdY*5;
    } else {
      starX += spdX;
      starY += spdY;
    }
  }
  void setSpd() {
    int maxSpd = 2.25;
    spdX = (float)(Math.cos(direction) * maxSpd);
    spdY = (float)(Math.sin(direction) * maxSpd);
  }
  void show() {
    stroke((int)(Math.random()*100));
    fill((int)(Math.random()*150)+50);
    ellipse(starX, starY, starSize, starSize);
  }
}

class OddStar implements Particle {
  float starX, starY;
  int starSize;
  OddStar() {
    starX = x;
    starY = y;
    starSize = size;
  }
  float getCurrentX() {
    return starX;
  }
  float getCurrentY() {
    return starY;
  }
  void move() {

  }
  void setSpd() {

  }
  void show() {

  }

}

class OddBall implements Particle {
  JumboStar() {

  }
  float getCurrentX() {
    return 0;
  }
  float getCurrentY() {
    return 0;
  }
  void stretch() {

  }
  void setSpd() {

  }
  void show() {

  }
}
interface Particle {
  public void move();
  public void show();
  public void setSpd();
  public float getCurrentX();
  public float getCurrentY();
}
void mousePressed() {
  hyperSpace = !hyperSpace;
}

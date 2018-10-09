//Particle[] particles;
ArrayList<Particle> particles;
int num = 350;
boolean hyperSpace;
void addParticle() {
  float rand = (float)(Math.random()*10)-5.0;
  int randSize = int(random(4, 10));
  int randLen = int(random(25,50));
  particles.add(new StarParticle(250.0,250.0, 250.0+rand, 250.0+rand, randSize, randLen));
  particles.get(particles.size()-1).setSpd();
}
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
    particles.get(i).stretch();
    particles.get(i).show();
  }
  for(int i=0;i<1;i++) {
    addParticle();
  }
}

class StarParticle implements Particle {
  int strokeSize;
  float originX;
  float originY;
  float currentX;
  float currentY;
  float spdX;
  float spdY;
  float newX;
  float newY;
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
  }
  public void stretch() {
    newX += spdX;
    newY += spdY;
    if(!hyperSpace) {
      currentX += spdX;
      currentY += spdY;
      return;
    }
    if(len <= 0) {
      currentX += spdX;
      currentY += spdY;
    }
    len--;
  }
  public void show() {
    stroke(0, 0, random(50,200));
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
    spdX = (float)(Math.cos(direction) * 1.25);
    spdY = (float)(Math.sin(direction) * 1.25);
    // spdX = currentX - originX;
    // spdY = currentY - originY;
    int maxSpd = 25;
    // spdX /= 10;
    // spdY /= 10;
    if(spdX <= 0 && spdY <= 0) {
      // while(Math.abs(spdX) >= maxSpd || Math.abs(spdY) >= maxSpd) {
      //   spdX /= 10;
      //   spdY /= 10;
      // }
    } else {
      // while(spdX >= maxSpd || spdY >= maxSpd) {
      //    This is causing too fast stretch 
      //   spdX /= 10;
      //   spdY /= 10;
      // }
    }
    newX = currentX;
    newY = currentY;
  }
}

class JumboStar implements Particle {
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
  public void stretch();
  public void show();
  public void setSpd();
  public float getCurrentX();
  public float getCurrentY();
}
void mousePressed() {
  hyperSpace = !hyperSpace;
}
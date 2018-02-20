/*****************************************
  Developer: Penubo Kim
  file: firework_graphic processing
  Description: 
    1. make seeds randomly by 10% in each frameRate
    2. draw and update seeds
      1. if seed reaches maximum height ( which means Y velocity of seed is positive )
        1. throw seed into bin ( remove later )
        2. make fragments at position of the seed
    3. draw and update fragments
      1. if life of fragments < 0 ( which means dead )
       1. throw into bin ( remove later )
    4. remove objects which is mamber seeds or fragments in bin 
    5. claer bin 
*****************************************/



ArrayList<Particle> seeds = new ArrayList<Particle>();
ArrayList<Particle> fragments = new ArrayList<Particle>();
ArrayList<Particle> bin = new ArrayList<Particle>();
PVector gravity = new PVector(0, 1);

void setup() {
  size(800, 600);
  colorMode(HSB, 360, 100, 100); // H : 0..360, S : 0..100, B : 0..100
}

void draw() {  
  // trail effect
  fill(0, 25);
  rect(0, 0, width, height);
  
  
  // 1. make seeds randomly by 10% in each frameRate
  if(random(1) > 0.9) {
    // fire seed on 10% chance
    PVector position = new PVector(random(0, width), height);
    PVector velocity = new PVector(0, random(-12, -15));
    float mass = random(2, 6);
    Particle newSeed = new Particle(position, velocity, mass);
    newSeed.addForce(gravity);                         // add gravity
    newSeed.addColor(color(random(0, 360), 100, 100)); // add color first value is hueValue
    seeds.add(newSeed);
  }
  
  // 2. draw and update seeds
  for(Particle seed : seeds) {
    // update seeds
    seed.update();
    seed.display();
    
    if (seed.getVelocity().y > 0) {
      // when seed stops midst in the air
      bin.add(seed); // throw seed into bin to remove later
      for(int i = 0; i < 100*seed.mass; i++) {
        // explode into fragment
        Particle newFragment = new Particle(seed.position, seed.mass);
        newFragment.addColor(seed.particleColor);
        fragments.add(newFragment);
      }
    }
  }
  
  // 3. draw and update fragments
  for(Particle fragment : fragments) {
    // update fragments
    fragment.update();
    fragment.display();
    if (fragment.getLife() < 0) {
      bin.add(fragment);
    }
  }
  
  // 4. remove objects which is mamber seeds or fragments in bin 
  for(Particle trash : bin) {
    // delete objects in ArrayList
    if(seeds.contains(trash)){
      seeds.remove(trash);
    } else if(fragments.contains(trash)) {
      fragments.remove(trash);
    }
  }
  // 5. claer bin 
  bin.clear(); // clear bin
}

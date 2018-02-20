class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration = new PVector(0, 0);;
  ArrayList<PVector> forces = new ArrayList<PVector>();
  float mass;
  float life;
  color particleColor = color(0, 0, 100);
  
  Particle(PVector pos, float lifeRange) {
    // constructor for fragment
    position = pos.get();  // don't forget copy Vector object otherwise you'll see chaos
    velocity = PVector.random2D();
    velocity.mult(random(0, 2));
    mass = 1;
    life = lifeRange;
  }
  
  Particle(PVector pos, PVector vel, float m) {
    // constructor for seed
    position = pos.get();
    velocity = vel.get();
    mass = m;
  }
  
  void addColor(color c) {
    particleColor = c;
  }
  
  void addForce(PVector force) {
    // add force to forces array
    forces.add(force);
  }
 
  PVector applyForce(PVector force) {
    // return force divided by mass
    PVector f = force.get();
    f.div(mass);
    return f;
  }
  
  void update() {
    for(PVector force : forces) {
      // apply all exist forces
      acceleration.add(applyForce(force));
    }
    
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    
    if(life > 0) {
      // if life exist update life ( for fragment )
      life -= 0.1;
    }
  }
  
  void display() {
    stroke(particleColor);
    strokeWeight(mass); 
    point(position.x, position.y);
  }
  
  PVector getVelocity() {
    return velocity;
  }

  float getLife() {
    return life;
  }
}
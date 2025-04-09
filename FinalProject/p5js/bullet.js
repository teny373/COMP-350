class Bullet {
	constructor(position, direction, speed, damage) {
	  this.position = position;  
	  this.direction = direction;  
	  this.speed = speed;  
	  this.damage = damage;  
	  this.lifetime = 0;  
	  this.maxLifetime = 5000;  
	}
  
	update() {

	  this.position.add(this.direction.copy().mult(this.speed));
  

	  this.lifetime += deltaTime;
  
	  if (this.lifetime > this.maxLifetime) {
		this.destroy();
	  }
	}
  
	destroy() {
	
	  let index = bullets.indexOf(this);
	  if (index !== -1) {
		bullets.splice(index, 1);
	  }
	}
  
	display() {
	  push();
	  translate(this.position.x, this.position.y, this.position.z);
	  sphere(5);  
	  pop();
	}
  }
  
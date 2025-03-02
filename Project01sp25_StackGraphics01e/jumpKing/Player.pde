
public class Person {
	
	float xpos, ypos;
	float hitboxWidth, hitboxHeight;
	
	public Person(float x, float y, float w, float h) {
		xpos = x;
		ypos = y;
		hitboxWidth = w;
		hitboxHeight = h;	
	}
}

public class Player extends Person {
	
	public Player(float x, float y, float w, float h) {	
		super(x, y, w, h);	
	}

	public void keyEvent() {}
	
}

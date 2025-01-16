/////////////////////////////////////////////////
// Course:
// Last Name:
// First Name:
// Student ID:
//
// File: HelloAvengers.java
// Summary: This class is to test Avengers class.
/////////////////////////////////////////////////

public class HelloAvengers
{
	public static void main (String args[ ])
	{
		Avengers ironman = new Avengers("Tony Stark") ;
		Avengers hulk = new Avengers("Bruce Banner") ;
		System.out.println(ironman);
		System.out.println(hulk);
		
		System.out.println( ironman.sayTrueIdentity());
		
		String hulk_realName = hulk.sayTrueIdentity();
		System.out.println( hulk_realName);

		
	}
}

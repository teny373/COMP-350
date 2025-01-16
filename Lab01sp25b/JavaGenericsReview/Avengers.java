/////////////////////////////////////////////////
// 
// Last Name: Chen  
// First Name: Hsi (Danny)
// Student ID: 100328828
// 
// File: Avengers.java
// Summary: A class for showing real name.
/////////////////////////////////////////////////

public class Avengers
{
   private String trueIdentity;
	
   public Avengers(String name)
   {
      trueIdentity = name;
    }    
   
   public String getName()
   {
	   return trueIdentity;
   }
   
   public String sayTrueIdentity()
   {
       return "Hello, I'm " + trueIdentity + "!";
   }
}

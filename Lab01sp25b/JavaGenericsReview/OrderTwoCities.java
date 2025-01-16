//package chapter4;

import java.util.Scanner;

public class OrderTwoCities {
  public static void main(String[] args) {
    Scanner input = new Scanner(System.in);
    
    // Prompt the user to enter two cities
    System.out.print("Enter the first city: ");
    String city1 = input.nextLine();
    System.out.print("Enter the second city: ");
    String city2 = input.nextLine();
    System.out.println("city1.compareTo(city2)"+ ": " + city1.compareTo(city2) );
    if (city1.compareTo(city2) < 0)
      System.out.println("The cities in alphabetical order are " +
         city1 + " " + city2);
    else
      System.out.println("The cities in alphabetical order are " +
          city2 + " " + city1);
  
    System.out.println("\nComare numbers:");
	Integer x = new Integer(5);
	System.out.println("x is " + x.intValue());
	System.out.print("Enter an integer number to compare: ");
	Integer y = input.nextInt();
	System.out.println(x + " compareTo("+ y + "): " + x.compareTo(y));
	System.out.println(x.compareTo(new Integer(7)));
  
}
  
}

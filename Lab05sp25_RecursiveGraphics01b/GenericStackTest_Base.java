//import java.util.ArrayList;

public class GenericStackTest_Base {
	public static void main(String args[]) {
		GenericStack<String> stack1 = new GenericStack<>();
		stack1.push("London");
		stack1.push("Paris");
		stack1.push("Berlin");
		
	    while (!stack1.isEmpty()){
	        System.out.print(stack1.pop() + " ");  
	    }	    
	}	
	
}

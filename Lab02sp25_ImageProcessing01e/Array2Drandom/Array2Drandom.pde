int cols = 5;
int rows = 4;
int[][] arrayD = new int[rows][cols];
int i, j, elements=0;

println("Counting a number of elements in nested for loops ");
for ( i = 0; i < rows; i++) {
  for ( j = 0; j < cols; j++) {
    elements++;
    print(elements + " ");
    arrayD[i][j] = int(random(1,10));
  }
  println(" ");
}
println();

println("values of i and j ");
for ( i = 0; i < rows; i++) {
  for ( j = 0; j < cols; j++) {
    print("D[" +i +"]"+ "["+ j +"] = " + arrayD[i][j] + ", " );
  }
  println(" ");
}

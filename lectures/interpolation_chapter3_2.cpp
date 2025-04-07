/*------------------------------------------------------*/
/* Program chapter2_4 */
/* */
/* This program uses linear interpolation to */
/* compute the freezing temperature of seawater. */
#include<iostream> //Required for cin, cout, endl.
#include<iomanip> //Required for fixed, setprecision()
using namespace std;
int main()
{
// Declare objects.
double a, f_a, b, f_b, c, f_c;
// Prompt and get user input from the keyboard.
cout << "Use ppt for salinity values." << endl
<< "Use degrees F for temperatures." << endl
<< "Enter first salinity and freezing temperature: \n";
cin >> a >> f_a;
cout << "Enter second salinity and freezing temperature: \n";
cin >> c >> f_c;
cout << "Enter new salinity: \n";
cin >> b;
if( !(a < b && b < c) )
{
  cout << "Invald data: " << a << "," << b << "," << c << endl;
}
else
{
  // Use linear interpolaltion to compute
  // new freezing temperature.
  f_b = f_a + (b-a)/(c-a)*(f_c - f_a);
  // Print new freezing temperature to the screen.
  cout << " New freezing temperature in degrees F; "
       << fixed << setprecision(1) << f_b << endl;
}//end else
// Exit program.
return 0;
}

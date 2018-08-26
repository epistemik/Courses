// File ex1.cpp

#include <iostream.h>

bool is_correct(int); // A FUNCTION PROTOTYPE

int main()
{
   bool correct = false; 	// A VARIABLE LOCAL TO main()
   int year;  	// INTEGER VARIABLE

   while(!correct)
	{ // ! STANDS FOR "NOT"
	cout << "Enter the year you were born> ";
	cout.flush();
	cin >> year;
	if (!cin)
		{
		cout << "Invalid input!" << endl;
		return 1;
		}
	correct = is_correct(year);
	if (correct) break;
	cout << "You could not be born in " << year << '!' << endl;
	} // while

   cout << "You are " << (1999 - year) << " years old." << endl;
  
   return 0;
}

bool is_correct(int year) { // IMPLEMENTATION 
   return year >= 1899 && year <= 1985;
}

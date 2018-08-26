// File ex3f1.cpp

#include "ex2.h"
#include "ex3.h"
#include <iostream.h>

game::game():d1(12),score1(0),score2(0) {
}

void game::play() {
   d1.roll();
   d2.roll();
   int v1 = d1.get_value(),v2 = d2.get_value();

   cout << "Computer rolls " << v1 << '+' << v2 << '=' << (v1+v2) << endl;
   
   score1 += (v1+v2);

   cout << "Press [RET] to roll dice 1 ...";
   cout.flush();
   cin.get();
   d1.roll();
   cout << "... " << (v1 = d1.get_value()) << endl;

   cout << "Press [RET] to roll dice 2 ...";
   cout.flush();
   cin.get();
   d2.roll();
   cout << "... " << (v2 = d2.get_value()) << endl;

   cout << "You scored " << v1 << '+' << v2 << '=' << (v1+v2) << endl;
   
   score2 += (v1+v2);
}

void game::match() {

   bool had_enough = false;
   score1 = score2 = 0; // RESET SCORES
 
   while(!had_enough) {
      play();
      cout << "Current scores: Computer = " << score1
           << " You = " << score2 << endl;
      cout << "Did you have enough? [y/n]" << endl;
      char c;
      c = (char)cin.get();
      switch(c) {
         case 'y':
         case 'Y':
            cout << "I am sorry to hear that!" << endl;
            had_enough = true;
            break;
         case 'n':
         case 'N':
            cin.get();
            break;
         default:
            cout << "Eh?" << endl;
            continue;
      } // switch
   } // while
}
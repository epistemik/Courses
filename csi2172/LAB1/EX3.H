#if !defined(_EX3_H_)
#define _EX3_H_

#include "ex2.h"

class game {
   private:
     dice d1; // A 12 SIDED DICE
     dice d2;
     
     int score1; // PLAYER 1, COMPUTER
     int score2; // PLAYER 2

   public:
    
     game();
     void play();
     void match();
};

#endif


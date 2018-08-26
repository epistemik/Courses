// File ex2.h

#if !defined(_EX2_H_)
#define _EX2_H_

class dice {
   private:
      int sides;
      int value;
   public:
      dice(int = 6);
      void roll();
      int get_value();
};

#endif

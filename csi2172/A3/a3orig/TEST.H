// test.h

#if !defined(_TEST_H_)
#define _TEST_H_

#include <iostream.h> 

class test_class 
{
  private:
      static int last_id;
      int id;
      double value;

  public:
      test_class(const double&);
      double& operator*(); 

  friend ostream& operator<<(ostream&, const test_class&);
};

ostream& operator<<(ostream&, const test_class&);

#endif

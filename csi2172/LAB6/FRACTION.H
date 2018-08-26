#ifndef _FRACTION_H_
#define _FRACTION_H_

#include <iostream.h>

class fraction {
  private:
    bool invalid; // not a number

    long numerator;
    long denominator;

    static long gcd(long,long);
    static long lcm(long,long);

  public:
    fraction(long=0,long=1);

    fraction& operator+=(const fraction&);
    fraction& operator-=(const fraction&);
    fraction& operator*=(const fraction&);
    fraction& operator/=(const fraction&);

    fraction operator-() const; // unary -
    fraction operator+() const; // unary +

    friend fraction operator+(const fraction&,const fraction&);
    friend fraction operator/(const fraction&,const fraction&);
    friend fraction operator*(const fraction&,const fraction&);
    friend fraction operator-(const fraction&,const fraction&);

    friend bool operator==(const fraction&,const fraction&);
    friend bool operator<=(const fraction&,const fraction&);
    friend bool operator>=(const fraction&,const fraction&);
    friend bool operator<(const fraction&,const fraction&);
    friend bool operator>(const fraction&,const fraction&);
    friend bool operator!=(const fraction&,const fraction&);
    
    friend ostream& operator<<(ostream&,const fraction&);
};

extern const fraction NaN;

#endif



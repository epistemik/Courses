#include "fraction.h"

const fraction NaN(0,0); // Not a Number

long fraction::gcd(long a, long b) {
  if(a==0 && b==0) return 1;
  if(b==0) return a;
  
  return gcd(b,a % b);
}

long fraction::lcm(long a, long b) {
   long GCD = gcd(a,b);
   
   return (a>b? (a/GCD)*b : (b/GCD)*a);
}

fraction::fraction(long n, long d):invalid(false),numerator(n),denominator(d) {

  if (denominator==0) { // this should trhow an exception
                        // but we have not seen them (yet)
      invalid = 1;
      return;
  }

  if (numerator == 0 ) {
     numerator = 0;
     denominator = 1;
     return;
  }


  long GCD = gcd(numerator,denominator);

  numerator   /= GCD;
  denominator /= GCD;

  if (denominator<0) {
     // in case sign is reversed
     numerator *= -1;
     denominator *= -1;
  }
}


fraction fraction::operator+() const{
   return *this;
}

fraction fraction::operator-() const{
   return fraction(-numerator,denominator);
}

fraction& fraction::operator+=(const fraction& f) {
   return (*this = *this + f);
}

fraction& fraction::operator-=(const fraction& f) {
   return (*this = *this - f);
}

fraction& fraction::operator*=(const fraction& f) {
   return (*this = *this * f);
}

fraction& fraction::operator/=(const fraction& f) {
   return (*this = *this / f);
}

fraction operator+(const fraction& f1,const fraction& f2) {
   if (f1.invalid || f2.invalid) return NaN;

   long LCM = fraction::lcm(f1.denominator,f2.denominator);

   return fraction((LCM/f1.denominator)*f1.numerator +
                   (LCM/f2.denominator)*f2.numerator,
                   LCM);
}

fraction operator-(const fraction& f1,const fraction& f2) {
   return f1 + -f2;
}

fraction operator*(const fraction& f1,const fraction& f2) {
   if (f1.invalid || f2.invalid) return NaN;

   long GCD_1 = fraction::gcd(f1.numerator,f2.denominator),
        GCD_2 = fraction::gcd(f2.numerator,f1.denominator);

   return fraction((f1.numerator/GCD_1)*(f2.numerator/GCD_2),
                   (f1.denominator/GCD_2)*(f2.denominator/GCD_1));
}

fraction operator/(const fraction& f1,const fraction& f2) {
   return f1*(f2.denominator!=0?fraction(f2.denominator,f2.numerator):NaN);
}

bool operator<(const fraction& f1,const fraction& f2) {
   if (f1.invalid || f2.invalid) return 0;

   long LCM = fraction::lcm(f1.denominator,f2.denominator);

   return (LCM/f1.denominator)*f1.numerator <
          (LCM/f2.denominator)*f2.numerator;
}

bool operator>=(const fraction& f1,const fraction& f2) {
   return  !(f1 < f2);
}

bool operator==(const fraction& f1,const fraction& f2) {
   return !(f1 < f2) && !(f2 < f1);
}

bool operator<=(const fraction& f1,const fraction& f2) {
   return  !(f2 < f1);
}

bool operator>(const fraction& f1,const fraction& f2) {
   return !(f1 < f2) && (f2 < f1);
}
 
bool operator!=(const fraction& f1,const fraction& f2) {
   return (f1<f2) || (f2 < f1);
}


ostream& operator<<(ostream& os,const fraction& f) {

  if (f.invalid) os << "NaN";
  else {
    os << f.numerator;
    if (f.denominator!=1) os << '/' << f.denominator;
  }

  return os;
}

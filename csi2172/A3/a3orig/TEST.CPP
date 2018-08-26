// test.cpp

#include "test.h"

int test_class::last_id = 0 ;

test_class::test_class(const double& v):id(last_id++),value(v) 
	{	}

double& test_class::operator*() 
	{
	 return value;	
	 }

ostream& operator<<(ostream& os, const test_class& c) 
	{
	 return os << c.value << '(' << c.id << ')' ;
	}

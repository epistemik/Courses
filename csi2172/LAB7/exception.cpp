#include <iostream.h>


class Employee {
   protected:
     double _salary;
     char* _name;

     void copy(double d, char* n) {
        if (_name != NULL) delete [] _name;
        if (n!=NULL) { 
          _name = new char[strlen(n)+1];
          strcpy(_name,n);
        }
        _salary =  d;
     }
   public:

     static double  MINIMUM_SALARY;
     static double  MAXIMUM_SALARY;

     Employee(char* n=NULL):_name(NULL) {
        copy(-1,n);
     }

     Employee(const Employee& e):_name(NULL) {
        copy(e._salary,e._name);
     }

     Employee& operator=(const Employee& e) {
        copy(e._salary,e._name);
        return *this;
     }
     
     virtual ~Employee() {
        delete [] _name;
        _name = NULL;
     } 

     void assignSalary(double);

     double salary() {
        return _salary;
     }

     char* name() {
        return _name;
     }
};

class EmployeeSalaryException {
};

class TooLowSalary : public EmployeeSalaryException {
};

class TooHighSalary : public EmployeeSalaryException {
};
         
void Employee::assignSalary(double d) {
    _salary = d;
    if (d<MINIMUM_SALARY) throw TooLowSalary();
    if (d>MAXIMUM_SALARY) throw TooHighSalary();
}

double Employee::MINIMUM_SALARY =  5000;
double Employee::MAXIMUM_SALARY = 50000;

int main(void) {

    Employee staff[3]; 
    Employee susan("suzan"),jerry("jerry"),vera("vera");

    staff[0] = susan;
    staff[1] = jerry;
    staff[2] = vera;

    for(int i = 0;i<3;i++) {
      try {
        staff[i].assignSalary(4000+(30000*i)); 
      } catch(TooHighSalary& e) {
        cout << "Too high salary: " << staff[i].salary() << endl;
        staff[i].assignSalary(Employee::MAXIMUM_SALARY);
      } catch (TooLowSalary& e) {
        cout << "Too low salary: " << staff[i].salary() << endl;
        staff[i].assignSalary(Employee::MINIMUM_SALARY);
      } 
    }
 
    for(int i=0;i<3;i++) {
      cout << staff[i].name() << " earns: $" << staff[i].salary() << endl;
    }

    return 0;
}

      

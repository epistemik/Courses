#include <iostream.h>
#include <stdlib.h>

class Flower {

  protected:
    int nectar;

  public:
    Flower(int i=5):nectar(i) {
    }

    int give_nectar() {
       if (nectar>0)  {
         nectar--;
         return 1;
       }
       return 0;
    }

    int empty() {
       return nectar == 0;
    }

    void assess_capacity(char* name) {
      cout << name << " has " << nectar << " amount of "
           << "nectar left" << endl;
    } 
    
};   
 
class Bee {

   protected:
     static Flower* F;
     int bucket;
     int capacity;

   public:
     Bee(int i=5):bucket(0),capacity(i) {
     }

     void collect() { 
        if ( bucket < capacity) {
          bucket += F->give_nectar();
        }
     }

     int full() {
       return bucket == capacity;
     }


     static void Send_to_flower(Flower *f) {
       F = f;
     }

     void assess_performance(const char * name) {
        cout << name << " collected " << bucket << " amount of nectar "
             << "and his bucket is " << (full()?"full":"not full") << endl;
     } 
};

Flower* Bee::F = NULL;

int main(void) {

   
   Flower daisy(3);
   Flower ewelina(4);
   Flower magenta;
 
   Flower *field[] = { &daisy, &ewelina, &magenta };
   char* flower_name[] = { "daisy","ewelina","magenta" };

   Bee billy(4), attila(6), eugene;

   int flower_index = 0;

   Bee::Send_to_flower(field[flower_index]);  // setting the static variable
 
   while ( (!billy.full() || !attila.full() || !eugene.full() )
                          && 
           (!daisy.empty() || !ewelina.empty() || !magenta.empty())) {

     if (field[flower_index]->empty()  && flower_index < 2) {
        flower_index++;
        Bee::Send_to_flower(field[flower_index]);
     }

     #if defined(__WIN32__)
     switch(random(3)) {
     #else
     switch(random()%3)  {
     #endif
       case 0: billy.collect();
               cout << "billy <- "; 
               break; 
       case 1: attila.collect();
               cout << "attila <- ";
               break;
       case 2: eugene.collect();
               cout << "eugene <- ";
               break;
     }
   
    cout << flower_name[flower_index] << endl;
   }

   billy.assess_performance("billy");
   attila.assess_performance("attila");
   eugene.assess_performance("eugene");

   daisy.assess_capacity("daisy");
   ewelina.assess_capacity("ewelina");
   magenta.assess_capacity("magenta");
 
   return 0;
} 

   

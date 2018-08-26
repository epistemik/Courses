#if !defined(_SHAPES_H_)
#define _SHAPES_H_

class shape {
   private:
      char* name;
 
   public:
      shape(const char*);
      shape(const shape&);
      shape& operator=(const shape&);
      virtual ~shape();

      // pure virtual function
      virtual double area() const = 0;
      const char* get_name() const;
};

class rectangle: public shape {
   private:
      double a,b;
   
   public:
      rectangle(double,double);
      rectangle(const rectangle&);
      rectangle& operator=(const rectangle&);
      virtual ~rectangle();

      virtual double area() const;
};


class circle: public shape {
   private:
      double r;
   
   public:
      circle(double);
      circle(const circle&);
      circle& operator=(const circle&);
      ~circle();
  
      double area() const;
};

#endif  
     

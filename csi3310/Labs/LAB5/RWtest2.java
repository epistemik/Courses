
class RWtest2
 {
   public static void main(String[] args)
   {
    Semafor2 signal = new Semafor2() ;

    Reader2 read1 = new Reader2(signal, "John");
    Reader2 read2 = new Reader2(signal, "Paul");
    Reader2 read3 = new Reader2(signal, "George");
    Reader2 read4 = new Reader2(signal, "Ringo");

    Writer2 write1 = new Writer2(signal, "Alanis");
    Writer2 write2 = new Writer2(signal, "Celine");

    read1.start() ;
    read2.start() ;
    read3.start() ;
    read4.start() ;

    write1.start() ;
    write2.start() ;

   }// main()

 }// class RWtest2


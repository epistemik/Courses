
class RWtest
 {
   public static void main(String[] args)
   {
    Semafor signal = new Semafor() ;

    Reader read1 = new Reader(signal, "John");
    Reader read2 = new Reader(signal, "Paul");
    Reader read3 = new Reader(signal, "George");
    Reader read4 = new Reader(signal, "Ringo");

    Writer write1 = new Writer(signal, "Alanis");
    Writer write2 = new Writer(signal, "Celine");

    read1.start() ;
    read2.start() ;
    read3.start() ;
    read4.start() ;

    write1.start() ;
    write2.start() ;

   }// main()

 }// class RWtest


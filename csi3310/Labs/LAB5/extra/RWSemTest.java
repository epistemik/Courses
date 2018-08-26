
class RWSemTest
 {
   public static void main(String[] args)
   {
    Semafore readSem = new Semafore() ;
    Semafore writeSem = new Semafore() ;

    ReaderG read1 = new ReaderG(readSem, writeSem, "John");
    ReaderG read2 = new ReaderG(readSem, writeSem, "Paul");
    ReaderG read3 = new ReaderG(readSem, writeSem, "George");
    ReaderG read4 = new ReaderG(readSem, writeSem, "Ringo");

    WriterG write1 = new WriterG(writeSem, readSem, "Alanis");
    WriterG write2 = new WriterG(writeSem, readSem, "Celine");

    read1.start() ;
    read2.start() ;
    read3.start() ;
    read4.start() ;

    write1.start() ;
    write2.start() ;

   }// main()

 }// class RWSemTest


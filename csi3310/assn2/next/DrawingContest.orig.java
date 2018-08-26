/*
File: DrawingContest.java
Mark Sattolo  428500
CSI 3310  Assn#2  */

class DrawingContest
 {
  private final static int NUM_DRAWINGS = 100 ;
  private final static int NUM_PENCILS = 3 ;

  public static void main(String[] args)
   {
    ColorSemaphore signal = new ColorSemaphore(NUM_PENCILS) ;
    Drawings draw = new Drawings(NUM_DRAWINGS) ;
    Paper papers = new Paper(NUM_DRAWINGS) ;

    Artist art1 = new Artist(signal, papers, draw, "Betty") ;
    Artist art2 = new Artist(signal, papers, draw, "Edith") ;
    Artist art3 = new Artist(signal, papers, draw, "Margot") ;
    Artist art4 = new Artist(signal, papers, draw, "Ruth") ;
    Artist art5 = new Artist(signal, papers, draw, "Victoria") ;

    Jury juror = new Jury(papers, draw, NUM_DRAWINGS) ;

    art1.start() ;
    art2.start() ;
    art3.start() ;
    art4.start() ;
    art5.start() ;

    juror.start() ;

   }// main()

 }// class DrawingContest


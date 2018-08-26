# CALCULATE THE TOTAL MARKS AND LIST THEM BY STUDENT NUMBER

#open files
open(MARKS, "3105marks.in") or die "Can't open 3105marks.in: $!\n" ;
open(FINAL, "3105final.in") or die "Can't open 3105final.in: $!\n" ;

#for each line in MARKS
while (<MARKS>) {
  #split the line into the stud#, assignment marks, and midterm
  ($studnum, $a1, $a2, $a3, $mid) = split ;
  # create hash %assns with student numbers as the keys
  # concatenate the assignment marks into a string as the value for each key
  $assns{$studnum} = $a1 . " " . $a2 . " " . $a3 ;
  #put the midterm mark into hash %exams
  $exams{$studnum} = $mid ;
  }

#for each line in FINAL
while (<FINAL>) {
  #split the line into the stud#, final grade, final exam and assignment 4 mark
  ($studnum, $grade, $final, $a4) = split ;
  #concatenate assn 4 to the string value in hash %assns
  $assns{$studnum} .= " " . $a4 ;
  #concatenate the final exam mark (worth 2x midterm) into a string value in hash %exams
  $exams{$studnum} .= " " . (2 * $final) ;
  #put the grade in a separate hash (%grades)
  $grades{$studnum} = $grade ;
  }

#use default variable $_ to loop through %assns
foreach (sort keys %assns) {
  $assntotal = 0 ;
  $examtotal = 0 ;
  #split out the assn marks and add them up
  @assn = split / /, $assns{$_} ;
  foreach $mark (@assn)
    { $assntotal += $mark ; }
  #change the total to a value out of 25
  $assntotal *= 25/240 ;
  #split out the exam marks and add them up
  @exam = split / /, $exams{$_} ;
  foreach $mark (@exam)
    { $examtotal += $mark ; }
  #change exam total to a value out of 75
  $examtotal /= 4 ;
  #get the overall total
  $overall = $assntotal + $examtotal ;
  #create hash %totals with studnum as the key and total marks as the value of each entry
  $totals{$_} = $overall ;
  }

$count = 1 ;
$sum = 0;
# print out the rank, studnum, total, and grade from lowest stud num to highest
# have to specify an explicit numeric sort
foreach (sort { $a <=> $b } keys %totals) {
  printf "%d/%d:\t\t%5.2f\t\t%s\n", $count, $_, $totals{$_}, $grades{$_} ;
  $count++ ;
  $sum += $totals{$_} ;
  }
$ave = $sum/$count ;
#print out the average mark
printf "\n Average:\t%6.3f\n", $ave ;

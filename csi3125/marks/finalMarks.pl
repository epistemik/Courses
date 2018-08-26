# CALCULATE THE FINAL MARKS AND PRINT THEM OUT FROM HIGHEST TO LOWEST
# Bookmarks: 1,4 1,7 1,17 1,29
#open file ("finalMarks.in" or the updated "finalMarksRev.in")
open(MARKS, "finalMarks.in") or die "Can't open finalMarks.in: $!\n" ;

#for each line
while ($line = <MARKS>) {
  #split the line into the stud#, assignment marks, midterm, final, and grade
  ($studnum, $a1, $a2, $a3, $a4, $mid, $final, $grade) = split / /, $line ;
  #concatenate the marks into one string and set this string as the value of key studnum in hash %marks
  $marks{$studnum} = $a1 . " " . $a2 . " " . $a3 . " " . $a4 . " " . $mid . " " . $final ;
  #put grade in a separate hash (%grades)
  $grades{$studnum} = $grade ;
  }

#use default variable $_ for the outer loop
foreach (sort keys %marks) {
  $total = 0 ;
  #split out the marks and add them up
  @marks = split / /, $marks{$_} ;
  foreach $mark (@marks) {
    $total += $mark ;
    }
  #create hash %totals with total as the key and studnum as the value of each entry
  # >> WILL GET A PROBLEM HERE IF TWO (OR MORE) DIFFERENT STUDENTS HAVE THE SAME TOTAL MARKS !!
  $totals{$total} = $_ ;
  }

$count = 1 ;
$sum = 0;
#print out the rank, total, studnum, and grade from highest total to lowest
foreach (reverse sort keys %totals) {
  print "$count/$_:\t$totals{$_}\t$grades{$totals{$_}}\n" ;
  $count++ ;
  $sum += $_ ;
  }
$ave = $sum/$count ;
#print out the average mark
print "\n Average:\t$ave\n" ;


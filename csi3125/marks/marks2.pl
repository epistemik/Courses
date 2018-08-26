#open file
open(MARKS, "marks.in") or die "Can't open marks.in: $!\n" ;
#for each line
while ($line = <MARKS>) {
  #split the line into the stud#, assignment marks, and midterm
  ($studnum, $a1, $a2, $a3, $a4, $mid) = split / /, $line ;
  #concatenate the marks into one string and set this string as the value of key studnum
  $marks{$studnum} = $a1 . " " . $a2 . " " . $a3 . " " . $a4 . " " . $mid . " " ;
  }
foreach $studnum (sort keys %marks) {
  $total = 0 ;
  #split out the marks and add them up
  @marks = split / /, $marks{$studnum} ;
  foreach $mark (@marks) {
    $total += $mark ;
    }
  #create a new hash with total as the key and studnum as the value of each entry
  $totals{$total} = $studnum ;
  }
$count = 1 ;
#print out the rank, total, and studnum from highest total to lowest
foreach $total (reverse sort keys %totals) {
  print "$count/$total:\t$totals{$total}\n" ;
  $count++ ;
  }

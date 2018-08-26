#revised from grades.pl
open(MARKS, "marks.in") or die "Can't open marks.in: $!\n" ;
while ($line = <MARKS>) {
  ($studnum, $a1, $a2, $a3, $a4, $mid) = split(" ", $line) ;
  $marks{$studnum} = $a1 . " " . $a2 . " " . $a3 . " " . $a4 . " " . $mid . " " ;
}
foreach $studnum (sort keys %marks) {
  $total = 0 ;
  @marks = split(" ", $marks{$studnum}) ;
  foreach $mark (@marks) {
    $total += $mark ;
  }
  print "$studnum: $marks{$studnum}\t\tTotal: $total\n" ;
}

var mydate=new Date()
var year=mydate.getYear()
year="2000"
var day=mydate.getDay()
var month=mydate.getMonth()
var daym=mydate.getDate()
if (daym<10)
daym="0"+daym
var dayarray=new Array("Sun","Mon","Tue","Wed","Thu","Fri","Sat")
var montharray=new Array("Jan.","Feb.","Mar.","Apr.","May","June","July","Aug.","Sep.","Oct.","Nov.","Dec.")
document.write("<small><font color='#633300' face='Times' Align='Right' Size=-1>"+dayarray[day]+", "+montharray[month]+" "+daym+", "+year+"</font></small>")

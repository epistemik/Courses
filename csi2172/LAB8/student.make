CC = g++

CFLAGS = -g -Wall -ansi -fhandle-exceptions

.SUFFIXES: .SUFFIXES .cpp

.cpp.o:
	${CC} -c $< ${CFLAGS}

student: student.o main.o
	${CC} -o student student.o main.o


student.o: student.h
main.o: student.h

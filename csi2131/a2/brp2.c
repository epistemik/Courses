
// brp2.c

 #include <stdio.h>
 #include <stdlib.h>

 main(int argc, char *argv[])
 {
  int i,						// loop index
  		time,             // used in policy search
  		next_buffer = 0,	// # of free buffers
  		old_cluster,		// cluster that is replaced
  		new_buffer,				// buffer # for load functions
  		clus_num,			// cluster requested by the user
  		repl_num = 0,     // total number of replacements
      time_count = 0 ;  // time counter for 'when_loaded'

  typedef struct {
  		int cluster_number ;	/* the number of the cluster in this buffer */
  		int when_loaded ;		/* when the cluster was loaded          */
  		int last_access ;		/* when the cluster was last requested  */
  		int num_accesses ;	/* # of accesses since the cluster was loaded */
  		char buffer[128] ;	/* the buffer itself  */
		} buffer_rec ;

  buffer_rec buff_index[4] ;

  FILE *readfile ;

  if ( argc == 3 && ( atoi(argv[1]) >= 1 && atoi(argv[1]) <= 3 ) )
  		{/* 3 cmdline args: 'brp', clus_num, readfile */
      if ( !(readfile = fopen(argv[2], "rb")) )     /* if open fails   */
         {
          fprintf(stderr, "Unable to open %s \n\n", argv[2] ) ;
          exit(1) ;
         }
      }
  else     /* bad command line syntax */
     {
      fprintf( stderr, "Usage: brp  <#>(1, 2 or 3)  <inputfile> \n\n" ) ;
      exit(1);
     }

 // printf( "%sxxx \n", argv[1] ) ;

  if ( atoi(argv[1]) == 1 ) puts( "FIFO:" ) ;
  	else if ( atoi(argv[1]) == 2 ) puts( "LRU:" ) ;
   	else puts( "LFU:" ) ;

  printf( "Cluster to load: " ) ;

  while ( scanf( "%d", &clus_num ) != EOF ) // as long as we're not at EOF
     {
      new_buffer = -1 ;
 		time_count++ ;
  		for (i = 0 ; i <= 3 ; i++)
   		if ( buff_index[i].cluster_number == clus_num ) new_buffer = i ;
      if ( new_buffer > -1 )  // cluster already loaded
      	{
         printf( "Cluster %d already in buffer %d \n", clus_num, new_buffer+1 ) ;
         buff_index[new_buffer].last_access = time_count ;
         buff_index[new_buffer].num_accesses++ ;
         }
      else  // requested cluster not yet loaded
      	{
         if ( next_buffer < 4 )  // there are still open buffers
         	{
            if ( fseek(readfile, (clus_num*128), SEEK_SET) != 0 )
   				{
      			fprintf(stderr, "Unable to seek in %s \n\n", argv[2] ) ;
      			exit(1) ;
      			}
   			else if ( !fread(buff_index[next_buffer].buffer, 128, 1, readfile) )
      				{
         			fprintf(stderr, "Unable to read file %s \n\n", argv[2] ) ;
	      			exit(1) ;
                  }
               	else
               		{
                  	printf( "Loading cluster %d into buffer %d \n", clus_num, next_buffer+1 ) ;
					  		buff_index[next_buffer].cluster_number = clus_num ;
					   	buff_index[next_buffer].when_loaded = time_count ;
					   	buff_index[next_buffer].last_access = time_count ;
					   	buff_index[next_buffer].num_accesses = 1 ;
               		next_buffer++ ;
               		}
           	}
         else  // all buffers are full -- implement replacement policy
         	{
            new_buffer = 0 ;
            old_cluster = buff_index[0].cluster_number ;
            if ( atoi(argv[1]) == 1 ) // fifo
            	{
       			time = buff_index[0].when_loaded ;
   				for (i = 1 ; i <= 3 ; i++)
   					if ( buff_index[i].when_loaded < time )
      					{
      					time = buff_index[i].when_loaded ;
         				new_buffer = i ;
         				old_cluster = buff_index[i].cluster_number ;
         				}
   				} // fifo
				if ( atoi(argv[1]) == 2 ) // lru
            	{
       			time = buff_index[0].last_access ;
   				for (i = 1 ; i <= 3 ; i++)
   					if ( buff_index[i].last_access < time )
      					{
      					time = buff_index[i].last_access ;
         				new_buffer = i ;
         				old_cluster = buff_index[i].cluster_number ;
         				}
   				} // lru
            if ( atoi(argv[1]) == 3 ) // lfu
               {
       			time = buff_index[0].num_accesses ;
   				for (i = 1 ; i <= 3 ; i++)
   					if ( buff_index[i].num_accesses < time )
      					{
      					time = buff_index[i].num_accesses ;
         				new_buffer = i ;
         				old_cluster = buff_index[i].cluster_number ;
         				}
               }// lfu

            if ( fseek(readfile, (clus_num*128), SEEK_SET) != 0 )
   				{
      			fprintf(stderr, "Unable to seek in %s \n\n", argv[2] ) ;
      			exit(1) ;
      			}
   			else if ( !fread(buff_index[new_buffer].buffer, 128, 1, readfile) )
      				{
         			fprintf(stderr, "Unable to read file %s \n\n", argv[2] ) ;
	      			exit(1) ;
                  }
               	else
               		{
	               	printf( "Replacing cluster %d; loading cluster %d into buffer %d \n", old_cluster, clus_num, new_buffer+1 ) ;
					   	buff_index[new_buffer].cluster_number = clus_num ;
					   	buff_index[new_buffer].when_loaded = time_count ;
					   	buff_index[new_buffer].last_access = time_count ;
					   	buff_index[new_buffer].num_accesses = 1 ;
               		repl_num++ ;
               		}
            }
         }
      printf( "Cluster to load: " ) ;
      } // 1 while

 puts( "while loop ended." ) ;

 if ( atoi(argv[1]) == 1 ) printf( "\n\nFIFO: total buffer replacements %d \n\n", repl_num ) ;
  	else if ( atoi(argv[1]) == 2 ) printf( "\n\nLRU: total buffer replacements %d \n\n", repl_num ) ;
   	else printf( "\n\nLFU: total buffer replacements %d \n\n", repl_num ) ;

 //puts( "-- should have printed replacement info." ) ;

 return 0 ;
 } // main


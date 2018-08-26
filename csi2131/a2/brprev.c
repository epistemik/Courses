
/* brp.c

 Mark Sattolo  428500
 CSI-2131B
 Professor: Ken Barker
 Tutorial Group: Z
 T.A.: William Elazmeh

 Assignment 2
*/

 #include <stdio.h>
 #include <stdlib.h>

 typedef struct {
  		int cluster_number ;	/* the number of the cluster in this buffer */
  		int when_loaded ;		/* when the cluster was loaded          */
  		int last_access ;		/* when the cluster was last requested  */
  		int num_accesses ;	/* # of accesses since the cluster was loaded */
  		char buffer[128] ;	/* the buffer itself  */
		} buffer_rec ;

  /* function prototypes */
  int loaded(buffer_rec*, int) ;
  void load(int, int, FILE*, buffer_rec*, char*) ;
  void update(buffer_rec*, int, int, int) ;
  int fifo(buffer_rec*, int*) ;
  int lru(buffer_rec*, int*) ;
  int lfu(buffer_rec*, int*) ;

 int main(int argc, char *argv[])
 {
  int mode,					/* type of buffer replacement policy 	*/
  		free_buffer = 0,	/* the next free buffer						*/
  		old_cluster,		/* cluster that is replaced        		*/
  		buffer_space,		/* buffer # info for load functions    */
  		clus_num = 0,     /* cluster requested by the user   		*/
  		repl_num = 0,     /* total number of replacements    		*/
      time_count = 0 ;  /* counter for the main loop       		*/

  buffer_rec buff_index[4] ;   /* array of 4 buffer_recs  */
  FILE *readfile ;           /*  file pointer  */

  /* 3 command line args: 'brp', mode, file to read */
  /* check that the value for mode is 1, 2, or 3 */
  if ( argc == 3 && ( atoi(argv[1]) >= 1 && atoi(argv[1]) <= 3 ) )
  		{
      if ( !(readfile = fopen(argv[2], "rb")) )
         {
          fprintf(stderr, "Error: unable to open file '%s' \n\n", argv[2] ) ;
          exit(1) ;     /* if open fails   */
         }
      }
  else     /* bad command line syntax */
     {
      fprintf(stderr, "Command line should have:  brp  <#>(1, 2 or 3)  <inputfile> \n\n" ) ;
      exit(2);
     }

  mode = atoi(argv[1]) ;
  if ( mode == 1 ) puts( "FIFO:" ) ;
  	 else if ( mode == 2 ) puts( "LRU:" ) ;
   	else puts( "LFU:" ) ;  /* mode can only be 1, 2, or 3  */

  printf( "Cluster to load: " ) ;

  while ( scanf( "%d", &clus_num ) > 0 )
  /* as long as we have a valid integer and are not at EOF */
     {
 		time_count++ ;  /* increment counter*/

      buffer_space = loaded(buff_index, clus_num) ; /* check this cluster */

      if ( buffer_space >= 0 )  /* requested cluster already loaded  */
      	{
         printf( "Cluster %d already in buffer %d \n", clus_num, buffer_space+1 ) ;
         /* increment last_access and number of accesses */
         buff_index[buffer_space].last_access = time_count ;
         buff_index[buffer_space].num_accesses++ ;
         }
      else  /* requested cluster not yet loaded   */
      	{
         if ( free_buffer < 4 )  /* there are still available buffers  */
         	{
            /* put requested cluster into the next available buffer */
            load(free_buffer, clus_num, readfile, buff_index, argv[2]) ;
            printf( "Loading cluster %d into buffer %d \n", clus_num, free_buffer+1 ) ;
            /* update the buffer attributes */
            update(buff_index, free_buffer, clus_num, time_count) ;
            free_buffer++ ;   /* next buffer # is now the free buffer */
            }
         else  /* all buffers are taken -- implement replacement policy   */
         	{
            /* use the requested brp to determine which cluster to replace */
            /* and find the buffer it currently occupies */
            if ( mode == 1 ) old_cluster = fifo( buff_index, &buffer_space ) ;
  					else if ( mode == 2 ) old_cluster = lru( buff_index, &buffer_space ) ;
   					else old_cluster = lfu( buff_index, &buffer_space ) ;

            /* load the new cluster into the proper buffer */
            load(buffer_space, clus_num, readfile, buff_index, argv[2]) ;
            printf( "Replacing cluster %d; loading cluster %d into buffer %d \n", old_cluster, clus_num, buffer_space+1 ) ;
            /* update buffer attributes */
            update(buff_index, buffer_space, clus_num, time_count) ;
            repl_num++ ;  /* increment the number of replacements */
            }
         }
      printf( "Cluster to load: " ) ;
      }  /*  end while  */

 puts( "\t\t\t\n" ) ;   /* I had to put this line here to flush the ^Z,  */
 								/* otherwise, the next line would not print properly */

 if ( mode == 1 ) printf( "\nFIFO: total buffer replacements: %d \n\n", repl_num ) ;
  	else if ( mode == 2 ) printf( "\nLRU: total buffer replacements: %d \n\n", repl_num ) ;
   	else printf( "\nLFU: total buffer replacements: %d \n\n", repl_num ) ;

 fclose(readfile) ;
 return 0 ;
 } /* main() */


 /* FUNCTION DEFINITIONS */

 /* check if the requested cluster is already loaded */
 int loaded(buffer_rec* index, int cnum)
	{
   int i ;
   /* loop to check if the requested cluster is already in a buffer */
   for (i = 0 ; i <= 3 ; i++)
   	if ( index[i].cluster_number == cnum )
      	return i ;
   return -1 ;
   } /* loaded()  */

 /* load the requested buffer -- file I/O error handling is done here */
 void load(int next, int clust, FILE* rfile, buffer_rec* index, char* name)
	{
   /* move the file position pointer to the right spot */
   if ( fseek(rfile, clust*128, 0) != 0 )
   	{
      fprintf(stderr, "Error: unable to seek in file '%s' \n\n", name ) ;
      exit(11) ;  /* if there is a problem with fseek() */
      }
   else
   	{
      /* read in the requested cluster (128 bytes) */
      if ( fread(index[next].buffer, 128, 1, rfile) != 1 )
      	{
         fprintf(stderr, "Error: unable to read file '%s' \n\n", name ) ;
	      exit(12) ;  /* if there is a problem with fread() */
         }
      }
   } /* load()  */

 /* update the buffer attributes after a new cluster is loaded */
 void update(buffer_rec* index, int buff, int clust, int time)
	{
   index[buff].cluster_number = clust ;
   index[buff].when_loaded = time ;
   index[buff].last_access = time ;
   index[buff].num_accesses = 1 ;
   }

 /* find the oldest cluster */
 int fifo(buffer_rec* index, int* oldest_buff)
	{
   int i,
   	 clust = index[0].cluster_number,
       time = index[0].when_loaded ;

   *oldest_buff = 0 ;
   for (i = 1 ; i <= 3 ; i++)
   	/* loop and check when_loaded for each buffer */
   	if ( index[i].when_loaded < time )
      	{
      	time = index[i].when_loaded ;
         *oldest_buff = i ;
         clust = index[i].cluster_number ;
         }
   return clust ;
   } /* fifo()  */

 /* find the cluster not accessed for the longest period */
 int lru(buffer_rec* index, int* oldest_buff)
	{
   int i,
   	 clust = index[0].cluster_number,
       time = index[0].last_access ;

   *oldest_buff = 0 ;
   for (i = 1 ; i <= 3 ; i++)
   	/* loop to find the smallest value of last_access for a buffer */
   	if ( index[i].last_access < time )
      	{
      	time = index[i].last_access ;
         *oldest_buff = i ;
         clust = index[i].cluster_number ;
         }
   return clust ;
   } /* lru() */

 /* find the cluster used the least number of times */
 int lfu(buffer_rec* index, int* infreq_buff)
	{
   int i,
   	 clust = index[0].cluster_number,
       num = index[0].num_accesses ;

   *infreq_buff = 0 ;
   for (i = 1 ; i <= 3 ; i++)
      /* loop finds the buffer with fewest number of accesses */
   	if ( index[i].num_accesses < num )
      	{
      	num = index[i].num_accesses ;
         *infreq_buff = i ;
         clust = index[i].cluster_number ;
         }
   return clust ;
   } /* lfu() */


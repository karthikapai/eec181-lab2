#include <stdio.h>
#include <ctype.h>




static inline unsigned int getCycles ()
{
  unsigned int cycleCount;
  // Read CCNT register
  asm volatile ("MRC p15, 0, %0, c9, c13, 0\t\n": "=r"(cycleCount));
  return cycleCount;
}

static inline void initCounters()
{
  asm volatile("MCR p15, 0, %0, C9, C14, 0\t\n" :: "r" (1));
  int MCRP15ResetALL = 23;
  asm volatile("MCR p15, 0, %0, C9, C12, 0\t\n" :: "r" (MCRP15ResetALL));
  asm volatile("MCR p15, 0, %0, C9, C12, 1\t\n" :: "r" (0x8000000f));
  asm volatile("MCR p15, 0, %0, C9, C14, 2\t\n" :: "r" (0x8000000f));
  asm volatile("MCR p15, 0, %0, C9, C12, 3\t\n" :: "r" (0x8000000f));
  
}


int main(void) {
	// RAM 00;
	//volatile int * hex		 		=(int *) 0xFF200000;
	//volatile int *Hex0_Hex5 = (int*)0xFF200028;
	//volatile int *hex_led 	=(int *) 0xFF200028;
	
  initCounters(); //initialize for counting
  
  volatile int * address;

	unsigned int input = 0;
  unsigned int mode = 0;
	unsigned int valid_in = 0;
	int quit;
	int count =0;
	//int size = 100;
	static int array[100];
	//*(Hex0_Hex5) = 0; // innitialize hex and led display
	
	while(1) 
	{
    
    printf("Enter 1 for FPGA On-CHIP, 2 for FPGA SDRAM, 3 for HPS DDR3 SDRAM and 4 for HPS On-CHIP Memory");
    scanf("%u", &mode);
		printf("Enter an integer: ");
		scanf("%u", &input);
    
    initCounters (); // initialize for counting
    
    if (mode == 1)
      address = (int *)0x00000000;
    if (mode == 2)
      address = (int *)0xC4000000;
    if (mode == 3)
      address = (int *)0x00100000;
    if (mode = 4)
      address = (int *)0xFFFF0000;
	
		if (input <0 || input > 4294967295) 
		{
			printf("Please input a valid number that fits 32-bits number \n");
			continue;
		}
        
		else
			valid_in = input;
			
		// Load into to_hex_to_led register
		*(address) = valid_in;
		address = address +1;
		array[count] = valid_in;
		count = count + 1;
		printf("Do you want to quit? Yes = 1, No = 0: ");
		scanf("%d", &quit);
		if (quit == 1)
		{
			
			break;
		}
		else 
		{ 
			continue;
		}
		
		
	}
	
	printf("count is %d\n", count);
	address = 0xC4000000;
	int readdata;
	int i;
	int valid;
  int k;
  int fakeCounter = 0;
  
  
	for (i=0; i< count; i++)
	{
		readdata = *(address + i);
		if (array[i] == readdata)
			valid = 1;
		else 
			valid = 0;
		
		if (valid == 0)
			printf("invalid data", readdata);
		
	}
  
  if (valid == 1)
  {
    ///get time at very end
    unsigned int time = getCycles();
    for (k = 0; k < 20000; k++)
      fakeCounter = fakeCounter + 1;
    time = getCycles() - time;
    printf ("Elapsed Time: %d cycles\n", time);
  
    time = getCycles();
    for (k = 0; k < 200000; k++)
      fakeCounter = fakeCounter + 1;
    time = getCycles() - time;
    printf ("Elapsed Time: %d cycles\n", time);
  }
	
	return 0;
}



#include <stdio.h>
#include <stdlib.h>
#include <input.h>

int main(void) {
	
	volatile int *Hex0_Hex5 = (int*)0xFF200028;
	
	
	int i, n, len, quit;
	char input[30];
	
	while(1) 
	{
		printf("Enter an integer: ");
		scanf("%s", input);

		len = strlen(input);
		if (len > 10) 
		{
			printf("Input number:\n");
			i = atoi(input);
			*Hex0_Hex5 = i;

			continue;
		}

		printf("Do you want to quit? Yes = 1, No = 0: ");
		scanf("%d", &quit);
		if (quit == 1)
		{
			
			break;
		}
		else if (quit == 0)
			continue;

	}
	
	return 0;
}

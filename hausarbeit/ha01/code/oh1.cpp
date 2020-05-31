#include <stdio.h>
#include <string>
#include <vector>

bool nor(bool a, bool b) { return !(a | b); }

int main(int argc, char* argv[])
{
	std::vector <int (*)(int,int,int,int)> funk
	{
		[](int a, int b, int c, int d) -> int {
			int sum = (a<<3) + (b<<2) + (c<<1) + d;
			if(sum <= 1 || sum == 3 || sum == 4) return 1;
			else if (sum == 2 || (sum >= 5 && sum <= 9)) return 0;
			else return 4;
		},
		[](int a, int b, int c, int d) -> int { return (!a & !b & d) | (!a & !c & !d); },
	};
	int n = funk.size();
	printf("A B C D");
	for (int u = 0; u < n; u ++) printf(" %d", u + 1);
	printf("\n\n");

	for (int i = 0; i < 2; i++) {
		for (int j = 0; j < 2; j++) {
			for (int k = 0; k < 2; k++) {
				for (int l = 0; l < 2; l++) {
					printf("%d %d %d %d", i, j, k, l);
					for (int u = 0; u < n; u ++) printf(" %d", funk[u](i,j,k,l));
					printf("\n");
				}
			}
		}
	}
	return 0;
}

// https://stackoverflow.com/a/31643380
// int (*funk[]) (int a, int b, int c) = 

// std::string outputString = "%d %d %d";
// for (int i = 0; i < n; i++)
// {
// 	outputString += " %d";
// }
// outputString.c_str()
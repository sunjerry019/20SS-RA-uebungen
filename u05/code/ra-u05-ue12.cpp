#include <stdio.h>
#include <string>
#include <vector>

bool nor(bool a, bool b) { return !(a | b); }

int main(int argc, char* argv[])
{
	std::vector <int (*)(int,int,int)> funk
	{
		[](int a, int b, int c) -> int { return (a & b) | a | c; },
		[](int a, int b, int c) -> int { return (a | b | c) & (a | !b | c); },
	};
	int n = funk.size();
	printf("A B C ");
	for (int u = 0; u < n; u ++) printf(" %d", u + 1);
	printf("\n\n");

	for (int i = 0; i < 2; i++) {
		for (int j = 0; j < 2; j++) {
			for (int k = 0; k < 2; k++) {
				printf("%d %d %d ", i, j, k);
				for (int u = 0; u < n; u ++) printf(" %d", funk[u](i,j,k));
				printf("\n");
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
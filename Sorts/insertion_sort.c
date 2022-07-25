#include <stdio.h>
#include <stdlib.h>

void insertion_sort(int *x, int n);

int main() {
	int n;
	scanf("%d", &n);
	

	int *x = malloc(sizeof(int) * n);
	if (!x) {
		printf("Failed to alloc mem");
		return -1;
	}

	for (int i = 0; i < n; ++i) {
		scanf("%d", &x[i]);
	}

	insertion_sort(x, n);

	printf("Sorted array: ");
	for (int i = 0; i < n; ++i) {
		printf("%d ", x[i]);
	}

	free(x);

	return 0;
}

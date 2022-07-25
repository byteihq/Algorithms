#include <stdio.h>
#include <stdlib.h>

void bubble_sort(int *x, int n);
void selection_sort(int *x, int n);
void insertion_sort(int *x, int n);

int main() {
	int n;
	scanf("%d", &n);
	

	int *x_for_bubble = malloc(sizeof(int) * n);
	int *x_for_selection = malloc(sizeof(int) * n);
	int *x_for_insertion = malloc(sizeof(int) * n);
	if (!x_for_bubble || !x_for_selection || !x_for_insertion) {
		printf("Failed to alloc mem");
		return -1;
	}

	for (int i = 0; i < n; ++i) {
		scanf("%d", &x_for_bubble[i]);
		x_for_selection[i] = x_for_bubble[i];
		x_for_insertion[i] = x_for_bubble[i];
	}

	bubble_sort(x_for_bubble, n);
	selection_sort(x_for_selection, n);
	insertion_sort(x_for_insertion, n);

	printf("Bubble sort: ");
	for (int i = 0; i < n; ++i) {
		printf("%d ", x_for_bubble[i]);
	}

	printf("\nSelection sort: ");
	for (int i = 0; i < n; ++i) {
		printf("%d ", x_for_selection[i]);
	}

	printf("\nInsertion sort: ");
	for (int i = 0; i < n; ++i) {
		printf("%d ", x_for_insertion[i]);
	}	

	free(x_for_bubble);
	free(x_for_selection);
	free(x_for_insertion);
	return 0;
}

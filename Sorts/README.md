## Bubble sort
```rust
fn bubble_sort(data: &mut Vec<i32>) {
    if data.is_empty() {
        return;
    }
    for i in 0..data.len() {
        for j in 0..data.len() - i - 1 {
            if data[j] > data[j+1] {
                data.swap(j, j+1);
            }
        }
    }
}
```
**OR**
```assembly
// void bubble_sort(int *x, int n)
//                    r0      r1

.global bubble_sort
bubble_sort:
	push {r4, r5, r6, r7, r8, r9}
	mov r2, #-1 // i
loop1:
	add r2, #1
	cmp r2, r1
	beq end
	mov r3, #-1 // j
	mov r4, r1
	sub r4, r2
	sub r4, #1
loop2:
	add r3, #1
	cmp r3, r4
	beq loop1
	mov r5, r3
	add r5, #1
	mov r6, #4
	mul r6, r3
	mov r7, r6
	add r7, #4
	ldr r8, [r0, r6]
	ldr r9, [r0, r7]
	cmp r8, r9
	bgt swap
	b loop2

swap:
	str r8, [r0, r7]
	str r9, [r0, r6]
	b loop2
	
end:
	pop {r4, r5, r6, r7, r8, r9}
	bx lr
```
## Selection sort
```rust
fn selection_sort(data: &mut Vec<i32>) {
    if data.is_empty() {
        return;
    }
    let mut index_min: isize = -1;
    for i in 0..data.len() {
        for j in i..data.len() {
            if index_min == -1 || data[j] < data[index_min as usize] {
                index_min = j as isize;
            }
        }
        data.swap(i, index_min as usize);
        index_min = -1;
    }
}
```
**OR**
```assembly
// void selection_sort(int *x, int n)
//                       r0      r1


.global selection_sort
selection_sort:
	mov r3, #-1
	push {r4, r5, r6, r7, r8, r9}
	mov r5, #-1
loop1:
	mov r4, r3
	add r3, #1
	cmp r3, r1
	beq end
loop2:
	add r4, #1
	cmp r4, r1
	beq swap
	cmp r5, #-1
	beq change_index
	mov r6, #4
	mul r6, r4
	mov r7, #4
	mul r7, r5
	ldr r8, [r0, r6]
	ldr r9, [r0, r7]
	cmp r8, r9
	blt change_index
	b loop2
	
swap:
	mov r6, #4
	mul r6, r3
	ldr r8, [r0, r6]
	mov r7, #4
	mul r7, r5
	ldr r9, [r0, r7]
	str r8, [r0, r7]
	str r9, [r0, r6]
	mov r5, #-1
	b loop1
	

change_index:
	mov r5, r4
	b loop2

end:
	pop {r4, r5, r6, r7, r8, r9}
	bx lr
```

## Insertion sort
```rust
fn insertion_sort(data: &mut Vec<i32>) {
    if data.is_empty() {
        return;
    }
    for i in 1..data.len() {
        let mut j = i;
        while j > 0 && data[j] < data[j - 1] {
            data.swap(j - 1, j );
            j -= 1;
        }
    }
}
```
**OR**
```assembly
// void insertion_sort(int *x, int n)
//			r0

.text
.global insertion_sort
insertion_sort:
	mov r2, #0
	mov r3, #0
	push {r4, r5, r6, r7, r8}
	mov r8, #4
loop1:
	add r2, #1
	mul r3, r8, r2
	mov r5, r2
	cmp r2, r1
	beq end
loop2:
	cmp r5, #0
	beq loop1
	mov r4, r3
	sub r4, r8
	ldr r6, [r0, r4]
	ldr r7, [r0, r3]
	cmp r7, r6
	bge loop1
	str r7, [r0, r4]
	str r6, [r0, r3]
	sub r5, #1
	sub r3, r8
	b loop2
	
	
end:
	pop {r4, r5, r6, r7, r8}
	bx lr
```
```c
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
```
**Build**
```shell
arm-linux-gnueabi-gcc-${VERSION} -marm bubble_sort.S selection_sort.S insertion_sort.S sorts.c -o sorts
```
**Run**
```shell
qemu-arm-static -L ${PATH_TO_LINARO} sorts
```
## Merge sort
```cpp
template<typename Iter>
std::vector<typename Iter::value_type> merge(Iter begin1, Iter end1, Iter begin2, Iter end2) {
    std::vector<typename Iter::value_type> result;
    result.reserve(std::distance(begin1, end1) + std::distance(begin2, end2) + 1);
    while (begin1 < end1 && begin2 < end2) {
        result.push_back(std::move((*begin1 < *begin2) ? *begin1++ : *begin2++));
    }
    std::move(begin1, end1, std::back_inserter(result));
    std::move(begin2, end2, std::back_inserter(result));
    return result;
}

template<typename Iter>
void merge_sort(Iter begin, Iter end) {
    if (std::distance(begin, end) <= 1) {
        return;
    }
    auto mid = begin + (end - begin) / 2;
    merge_sort(begin, mid);
    merge_sort(mid, end);
    auto res = merge(begin, mid, mid, end);
    std::move(res.begin(), res.end(), begin);
}
```
## Quick sort
```cpp
template<typename Iter>
Iter partition(Iter begin, Iter end) {
    auto pivot = std::prev(end);
    auto pIndex = begin;
    for (auto it = begin; it < std::prev(end); ++it) {
        if (*it < *pivot) {
            std::swap(*pIndex, *it);
            ++pIndex;
        }
    }
    std::swap(*pIndex, *pivot);
    return pIndex;
}

template<typename Iter>
void quick_sort(Iter begin, Iter end) {
    if (std::distance(begin, end) <= 1) {
        return;
    }
    auto p = partition(begin, end);
    quick_sort(begin, p);
    quick_sort(p + 1, end);
}
```
## Heap sort
```cpp
template<typename Iter>
void heapify(Iter begin, Iter end, size_t max_index) {
    auto prev_index = max_index;
    auto left = begin + 2 * max_index + 1;
    auto right = begin + 2 * max_index + 2;
    if (left < end && *left > *(begin + max_index)) {
        max_index = std::distance(begin, left);
    }
    if (right < end && *right > *(begin + max_index)) {
        max_index = std::distance(begin, right);
    }
    if (prev_index != max_index) {
        std::swap(*(begin + prev_index), *(begin + max_index));
        heapify(begin, end, max_index);
    }
}

template<typename Iter>
void heap_sort(Iter begin, Iter end) {
    auto size = std::distance(begin, end);
    for (int i = size / 2 - 1; i >= 0; --i) {
        heapify(begin, end, i);
    }
    for (int i = size - 1; i >= 0; --i) {
        std::swap(*begin, *(begin + i));
        heapify(begin, begin + i, 0);
    }
}
```

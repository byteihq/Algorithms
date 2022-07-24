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

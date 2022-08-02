## Problem 1
**Given an array and a number k.** \
**Question: what number will be in place k if the array is sorted**
```cpp
template <typename Iter>
Iter partition(Iter begin, Iter end) {
    auto pivot = std::prev(end);
    auto pIndex = begin;
    for (auto it = begin; it != end; ++it) {
        if (*it < *pivot) {
            std::swap(*it, *pIndex);
            ++pIndex;
        }
    }
    std::swap(*pivot, *pIndex);
    return pIndex;
}

template<typename Iter>
typename Iter::value_type kth(Iter begin, Iter end, size_t k) {
    if (std::distance(begin, end) <= 1) {
        return *(begin);
    }
    auto it = partition(begin, end);
    auto dist = std::distance(begin, it);
    if (k < dist) {
        kth(begin, it, k);
    } else if (k > dist) {
        kth(it + 1, end, k - dist);
    }
    return *(begin + k);
}
```
## Binary search
```cpp
template<typename Iter>
bool binary_search(Iter begin, Iter end, const typename Iter::value_type &value) {
    if (std::distance(begin, end) <= 1) {
        return *begin == value;
    }
    auto mid = begin + (end - begin) / 2;
    if (value < *mid) {
        binary_search(begin, mid, value);
    } else {
        binary_search(mid, end, value);
    }
}
```

## Greatest increasing sequence
```cpp
template<typename T>
std::pair<std::vector<T>, std::vector<size_t>> gis(const std::vector<T>& data) {
    std::vector<T> f(data.size());
    std::vector<size_t> p(data.size());
    for (size_t i = 0; i < data.size(); ++i) {
        f[i] = 1;
        p[i] = -1;
        for (size_t j = 0; j < i; ++j) {
            if (data[j] < data[i]) {
                if (f[i] < f[j] + 1) {
                    f[i] = f[j] + 1;
                    p[i] = j;
                }
            }
        }
    }
    return { f, p };
}
```

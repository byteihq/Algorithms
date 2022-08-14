[Reverse Linked List](https://leetcode.com/problems/reverse-linked-list/)
```cpp
ListNode* reverseList(ListNode* head)
{
    if (!head)
    {
        return nullptr;
    }
    ListNode *next = head->next;
    head->next = nullptr;
    while (next)
    {
        ListNode *nnext = next->next;
        next->next = head;
        head = next;
        next = nnext;
    }
    return head;
}
```
[Delete the Middle Node of a Linked List](https://leetcode.com/problems/delete-the-middle-node-of-a-linked-list/)
```cpp
ListNode* deleteMiddle(ListNode* head)
{
    if (!head)
    {
        return nullptr;
    }
    ListNode* copy_head = head;
    std::vector<ListNode *> pointers;
    while (head)
    {
        pointers.push_back(head);
        head = head->next;
    }
    size_t mid = pointers.size() / 2;
    if (mid == 0)
    {
        return nullptr;
    }
    pointers[mid - 1]->next = pointers[mid]->next;
    return copy_head;
}
```
OR (With O(1) memory)
```cpp
ListNode *deleteMiddle(ListNode *head)
{
    if (!head || !head->next)
    {
        return nullptr;
    }
    auto *s = head;
    auto *f = head->next;
    while (f->next && f->next->next)
    {
        f = f->next->next;
        s = s->next;
    }
    s->next = s->next->next;
    return head;
}
```
[Middle of the Linked List](https://leetcode.com/problems/middle-of-the-linked-list/)
```cpp
ListNode* middleNode(ListNode* head) {
    if (!head)
    {
        return nullptr;
    }
    if (!head->next)
    {
        return head;
    }
    auto *slow = head;
    auto *fast = head->next;
    while (fast->next && fast->next->next)
    {
        slow = slow->next;
        fast = fast->next->next;
    }
    return slow->next;
}
```
[Merge Two Sorted Lists](https://leetcode.com/problems/merge-two-sorted-lists/)
```cpp
ListNode* mergeTwoLists(ListNode* list1, ListNode* list2) {
    ListNode *res = new ListNode(0);
    ListNode *head_res = res;
    if (!list1)
    {
        return list2;
    }
    if (!list2)
    {
        return list1;
    }
    if (!list1 && !list2)
    {
        return nullptr;
    }
    if (list1->val < list2->val)
    {
        res->val = list1->val;
        list1 = list1->next;
    }
    else
    {
        res->val = list2->val;
        list2 = list2->next;
    }
    while (list1 && list2)
    {
        res->next = new ListNode;
        res = res->next;
        if (list1->val < list2->val)
        {
            res->val = list1->val;
            list1 = list1->next;
        }
        else
        {
            res->val = list2->val;
            list2 = list2->next;
        }
    }
    while (list1)
    {
        res->next = new ListNode(list1->val);
        res = res->next;
        list1 = list1->next;
    }
    while (list2)
    {
        res->next = new ListNode(list2->val);
        res = res->next;
        list2 = list2->next;
    }
    return head_res;
}
```
[Linked List Cycle](https://leetcode.com/problems/linked-list-cycle/)
```cpp
bool hasCycle(ListNode *head)
{
    if (!head || !head->next)
    {
        return false;
    }
    std::unordered_set<ListNode *> nodes;
    while (head)
    {
        if (nodes.count(head))
        {
            return true;
        }
        nodes.insert(head);
        head = head->next;
    }
    return false;
}
```
OR (With O(1) memory)
```cpp
bool hasCycle(ListNode* head)
{
    if (!head || !head->next)
    {
        return false;
    }
    auto *s = head;
    auto *f = head;
    while (f->next && f->next->next)
    {
        s = s->next;
        f = f->next->next;
        if (s == f)
        {
            return true;
        }
    }
    return false;
}
```
[Linked List Cycle II](https://leetcode.com/problems/linked-list-cycle-ii/)
```cpp
ListNode* detectCycle(ListNode* head)
{
    if (!head || !head->next)
    {
        return nullptr;
    }
    auto *s = head;
    auto *f = head;
    while (f->next && f->next->next)
    {
        s = s->next;
        f = f->next->next;
        if (s == f)
        {
            break;
        }
    }
    if (!f->next || !f->next->next)
    {
        return nullptr;
    }
    s = head;
    while (s != f)
    {
        s = s->next;
        f = f->next;
    }
    return s;
}
```

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

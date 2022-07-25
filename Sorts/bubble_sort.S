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

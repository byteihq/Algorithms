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
	

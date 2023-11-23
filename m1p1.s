.global m1p1
m1p1:
    push {r4-r7, lr}  // Save registers
    mov r4, r0  // Copy pointer to r4
    mov r5, #0  // Initialize counter

convert_loop:
    ldrb r3, [r4, r5]  // Load byte at pointer
    cmp r3, #0  // Check for end of string
    beq end_convert  // If end of string, exit loop

    cmp r5, #0  // Check if it's the first character
    beq capitalize

    cmp r3, #32  // Check for space
    beq capitalizeNext

    cmp r3, #90  // Check if the character is equal to or less than uppercase 'Z'
    bgt lowercase  // If it's not, then skip to lowercase

    b skip

capitalizeNext:
    add r5, r5, #1
    ldrb r3, [r4, r5]
    sub r3, r3, #32  // Convert lowercase to uppercase
    strb r3, [r4, r5]
    add r5, r5, #1
    b convert_loop

capitalize:
    sub r3, r3, #32  // Convert lowercase to uppercase
    strb r3, [r4, r5]
    add r5, r5, #1
    b convert_loop

lowercase:
    cmp r3, #65  // Check if the character is equal to or greater than uppercase 'A'
    blt skip

    add r3, r3, #32  // Convert uppercase to lowercase
    strb r3, [r4, r5]
    add r5, r5, #1
    b convert_loop

skip:
    add r5, r5, #1  // Increment the counter
    b convert_loop  // Repeat loop

end_convert:
    pop {r4-r7, pc}  // Restore registers and return

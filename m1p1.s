.global m1p1
m1p1:
    push {r4-r7, lr}  // Save registers
    mov r4, r0  // Move the pointer to r4 for manipulation
    mov r6, #1  // Initialize a flag to check if the current character is the first character of a word

convert_loop:
    ldrb r5, [r4]  // Load the byte at the pointer into r5
    cmp r5, #0  // Compare the byte to 0 (end of string)
    beq end_convert  // If it's 0, we're done, so branch to end

    // Check if the character is a space (ASCII 32)
    cmp r5, #32
    beq next_char

    // Check if the character is uppercase (ASCII 65 to 90)
    cmp r5, #65
    blt next_char
    cmp r5, #90
    bgt next_char

    // Check if the current character is the first character of a word
    cmp r6, #1
    bne next_char

    // Convert to lowercase by adding 32
    add r5, r5, #32
    strb r5, [r4]

next_char:
    // Check if the character is a space (ASCII 32)
    cmp r5, #32
    bne not_space

    // If it's a space, set the flag to 1
    mov r6, #1
    b convert_loop

not_space:
    // If it's not a space, set the flag to 0
    mov r6, #0
    add r4, r4, #1  // Move to the next character
    b convert_loop  // Go back to the start of the loop

end_convert:
    pop {r4-r7, pc}  // Restore registers and return

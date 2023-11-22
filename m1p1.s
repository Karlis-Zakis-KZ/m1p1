.global m1p1
m1p1:
    push {r4-r7, lr}  // Save registers
    mov r4, r0  // Move the pointer to r4 for manipulation

convert_loop:
    ldrb r5, [r4]  // Load the byte at the pointer into r5
    cmp r5, #0  // Compare the byte to 0 (end of string)
    beq end_convert  // If it's 0, we're done, so branch to end

    // Check if the character is a space (ASCII 32)
    cmp r5, #32
    beq next_char

    // Check if the character is lowercase (ASCII 97 to 122)
    cmp r5, #97
    blt next_char
    cmp r5, #122
    bgt next_char

    // Convert to uppercase by subtracting 32
    sub r5, r5, #32
    strb r5, [r4]

next_char:
    add r4, r4, #1  // Move to the next character
    b convert_loop  // Go back to the start of the loop

end_convert:
    pop {r4-r7, pc}  // Restore registers and return

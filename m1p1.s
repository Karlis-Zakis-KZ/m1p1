// Convert text to title case

.global m1p1

m1p1:
  // Save registers
  push {r4-r7, lr}

  // Load the pointer to the string from r0
  mov r4, r0

  // Set a flag to indicate if the next character should be uppercase
  mov r5, #1

  // Loop through the string until the null terminator is encountered
  loop:
    // Load the current character from the string
    ldr r6, [r4]

    // Check if the current character is a space
    cmp r6, #32
    bne handle_character

    // If it's a space, set the flag to uppercase the next character
    mov r5, #1

    // Move to the next character
    add r4, r4, #1

    // Check if the current character is the null terminator
    cmp r6, #0
    beq end_of_string

    // Go to the next iteration of the loop
    b loop

  // Handle non-space characters
handle_character:
    // Check if the flag is set for uppercase
    cmp r5, #1

    // If the flag is set, convert the character to uppercase
    bne convert_to_uppercase

    // If the flag is not set, check if the character is lowercase
    cmp r6, #97
    blt next_character

    // If the character is lowercase, convert it to uppercase
    cmp r6, #122
    bgt next_character

convert_to_uppercase:
    // Subtract 32 to convert the character to uppercase
    sub r6, r6, #32

    // Store the converted character back to the string
    strb r6, [r4]

next_character:
    // Clear the flag for the next character
    mov r5, #0

    // Move to the next character
    add r4, r4, #1

  // Go back to the start of the loop
  b loop

end_of_string:
  // Restore registers
  pop {r4-r7, pc}

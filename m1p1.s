.global m1p1
m1p1:
    push {r4-r7, lr}  // Save registers
    mov r4, r0  // Copy pointer to r4
    mov r6, #1  // Initialize flag for first character of a word

convert_loop:
  // Handle uppercase conversion
  cmp r5, #65 // Check if character is uppercase
  blt next_char // If lowercase, continue processing
  cmp r5, #90 // Check if character is uppercase
  bgt next_char // If uppercase, continue processing

  add r5, r5, #32 // Convert to lowercase
  strb r5, [r4] // Store converted character

  // Reset flag for subsequent characters
  mov r6, #0 // Reset flag before moving to next character

next_char:
  // Handle spaces
  cmp r5, #32 // Check for space
  moveq r6, #1 // If space, set flag to uppercase next character
  bne next_word // If not space, continue processing

next_word:
  // Check for end of string
  ldr r5, [r4] // Load byte at pointer
  cmp r5, #0 // Check for end of string
  beq end_convert // If end of string, exit loop

  // Move to next character
  add r4, r4, #1 // Move to next character
  b convert_loop // Repeat loop

end_convert:
  pop {r4-r7, pc} // Restore registers and return

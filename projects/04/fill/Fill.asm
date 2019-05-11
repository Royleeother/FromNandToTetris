// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// define screen pointer (16384)
@SCREEN
D=A
@pointer
M = D 

// max screen
//@KBD  
@24576
D = A 
@maxscreen
M = D 

(RUNS) 
    @KBD    // if keyboard down, jump to fill  
    D = M 
    @FILL   // blacken 
    D; JGT
    
    @UNFILL // whiten 
    0; JMP  
    

(UNFILL)
    // Do nothing if POINTER == SCREEN (pointer back to the starting position)
    @SCREEN
    D=A
    @pointer
    D=D-M
    @RUNS
    D; JEQ

    // Unfill the screen
    D = 0
    @pointer
    A = M 
    M = D 

    // Decrement pointer
    D = 1
    @pointer
    D = M - D 
    @pointer 
    M = D 

    @RUNS
    0; JMP

(FILL)
    // Do nothing if the screen is full
    @maxscreen
    D = M
    @pointer
    D = D - M
    @RUNS
    D; JEQ

    // fill in 1 pixel that pointer points each iteration
    D = -1
    @pointer
    A = M 
    M = D 

    // iterate pointer by 1
    D = 1
    @pointer
    D = D + M 
    @pointer 
    M = D 

    @RUNS
    0; JMP



// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Description:
//   1. detect if RAM[0] equal to 0 or 1, if it is, set RAM[2] to 0 or RAM[1] respectively.
//   2. detect if RAM[1] equal to 0 or 1, if it is, set RAM[2] to 0 or RAM[0] respectively.
//    3. if accord with 1 or 2, end, go to infinite loop
//   3. compare RAM[0] and RAM[1] to decide which is larger, then set them to counter and larger respectively
//   4. Into the loop, add the larger number to RAM[2] counter'th times, end, go to infinite loop.

// This algorithmn will be fast when it comes to large digit, 
// but it will be a little be reduntdant in the small number situation.
// Actually, there might still be some improvement in it, but I just stop here for the scope of this course.

// Put your code here.
    @0     // retrive data from 0 position
    D = M
    @ZERO   // 0 in, 0 out
    D; JEQ  // if RAM[0] == 0

    @one   // set a varible to 1, check if RAM[0] == 1
    M = 1   // PROBLEMS HERE !!!
    @one 
    D = D - M 
    @RETURN1
    D; JEQ

    @1     // retrive data from 1 position
    D = M
    @ZERO   // 0 in, 0 out
    D; JEQ

    @one   
    D = D - M
    @RETURN0
    D; JEQ

    // compare RAM[0] and RAM[1], set the smaller one as counter
    @2
    M = 0 // ensure RAM[2] = 0
    @1  
    D = M   // retrive data from 1 position
    @compare
    M = D   // set compare to RAM[1]
    @0
    D = M   // retrive data from 0 position
    @compare
    M = M - D  // RAM[1] - RAM[0]
    D = M 
    @SETCOUNERTO0
    D; JGT     // RAM[1] > RAM[0] , so set counter to RAM[0]
    @0
    D = M 
    @larger
    M = D   // // set the larger num to RAM[0]
    @1
    D = M
    @counter 
    M = D   // else set counter to RAM[1]
    @LOOP 
    0; JMP

(SETCOUNERTO0)
    @1
    D = M 
    @larger
    M = D   // // set the smaller num to RAM[1]
    @0
    D = M 
    @counter
    M = D   // so set counter to RAM[0]
    @LOOP 
    0; JMP


(LOOP)
    @counter
    D = M 
    @END    
    D; JEQ  // if counter == 0: go to end
    @larger
    D = M   //  D = larger num
    @2 
    M = D + M  // RAM[2] = RAM[2] + larger num
    @counter
    M = M - 1
    @LOOP
    0; JEQ

(ZERO) // set RAM[2] to 0 and go to end
    @ZERO
    @zero
    M = 0
    D = M
    @ 2
    M = D
    @END
    0; JMP

(RETURN1) // copy RAM[1] to RAM[2] and go to end
    @1
    D = M 
    @ 2
    M = D
    @END
    0; JEQ

(RETURN0) // copy RAM[0] to RAM[2] and go to end
    @0
    D = M 
    @ 2
    M = D 
    @END
    0; JEQ 

(END)  // infinite loop
    @END 
    0; JMP
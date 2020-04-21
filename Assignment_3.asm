# Assignment 3 group: 
# Christopher McGill (100745212)
# Shriji Shah (100665031)
# Franklin Muhuni (100744901)

.data
   	input1:		.asciiz "Enter integer value for maximum range: "
   	input2:		.asciiz "Enter your guess: "
   	input3:		.asciiz "Input your seed: "
   	correct:	.asciiz "\nYou Win"
   	wrong:		.asciiz "You are incorect, try another guess: "
	hotg: 		.asciiz "\nWithin 10% (Hot)"
	coldg: 		.asciiz "\nOutside of 10% (Cold)\n"

.text
#Prompt for N
la $a0,input1
li $v0,4
syscall
#Read N
li $v0,5
syscall
#Store in s0
move $s0,$v0


#Prompt for seed
la $a0,input3
li $v0,4
syscall
#Read N
li $v0,5
syscall
#Store in s1
move $s1,$v0

#Generate random number
	#Set seed
	move $a1, $s1  
   	li   $v0, 40      
   	syscall
   	#Generate random
	move $a1, $s0
	li $v0, 42
	syscall
	
#Random number s2
move $s2,$a0
Loop:
 	#Prompt for guess
    	la $a0,input2
    	li $v0,4
    	syscall
    	#Display :
    	li $a0, 0
    	li $v0,11
    	syscall
    	#Read 
    	li $v0,5
    	syscall
    	
    	# $s2 = random number
    	# $v0 = user guess input
    	
    	beq $v0,$s2,Correct
	
	div $t4, $s2, 20 #random number divided by 20 == 5% of rand nmb
	add $t1, $s2, $t4 #random number + 5% == upper bound
	sub $t2, $s2, $t4 #random number - 5% == lower bound

	bgt $v0, $s2, Upper  # if the guess is above the correct answer, branch to upper
	
	blt $v0, $s2, Lower  # if the guess is below the correct answer, branch to lower

Upper:
	blt $v0, $t1, Hot  # if the guess is below the upper range, its hot
	bgt $v0, $t1, Cold # if the guess is above the upper range, its cold

Lower:
	bgt $v0, $t2, Hot  # if the guess is above the lower range, its hot
	blt $v0, $t2, Cold # if the guess is below the lower range, its cold

Hot:
   la $a0,hotg
    li $v0,4
    syscall
    j Loop
    #Display Hot
    
Cold:
    la $a0,coldg
    li $v0,4
    syscall
    j Loop
    #Display Cold

Correct:
    la $a0,correct
    li $v0,4
    syscall
    #Display when correct
	
    

#####################################################################
#
# CSCB58 Fall 2020 Assembly Final Project
# University of Toronto, Scarborough
#
# Name: Jiayu Lu
# Number: 1005706960
# e-mail: jiay.lu@mail.utoronto.ca
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 512
# - Display height in pixels: 512
# - Base Address for Display: 0x10008000 ($gp)
#
#	Milestone 1: Create animations
#		a. Continually repaint the screen with the appropriate assets
#		b. Draw new location of platforms (3 minimum) and Doodler properly
#	
#	Milestone 2: Implement movement controls
#		a. Doodler should be able to "jump" off a platform
#		b. Change animation direction based on input keys
#
#	Milestone 3: Basic running version (similar to demo)
#		a. Random platform generator / scrolling the screen
#		b. End game and wait for restart if Doodle jumps onto illegal area

#   	Milestone 4: Game features 
#		a. Scoreboard / score count
#			i. Display on the screen
#		b. Different levels
#			i. Add more platforms
#		c. Dynamic increase in difficulty (speed) as game progresses
#
#	Milestone 5: Additional features
#		a. Realistic physics:
#			i. Speed up / slow down jump rate according to some metric
#		b. More platform types
#			ii. fragile" blocks (broken when jumped upon)
#		c. Boosting / power-ups:
#			i. Rocket suit
#			ii. Springs
#		d. Fancier graphics:
#			i. Make it nicer than the demo
#			ii. Add start / game over / pause screens with cool graphics.
#		e. Dynamic on-screen notifications:
#			i. "Awesome!", "Poggers!", "Wow!"
#
#	More additional features:
#		a. springs and rockets are randomly generated anywhere on platforms
#		b. the game can reframe smoothly
#		c. the gravity and the difficulty increase rate can be changed
#		d. the game can be paused and restarted
#
#	
#
#
#
#
#
#

#print_assets:
	#print_doodle
	#print_rocket(x,y)
	#print_spring(x,y)
	#print_platform(x,y)
	#print_fragile_platform(x,y)
	#print_char_doodle_jump(color)
	#print_background(color)

#erase_assets:
	#erase_doodle
	#erase_rocket(x,y)
	#erase_spring(x,y)
	#erase_platform(x,y)
	#erase_fragile_platform(x,y)
	#crash_fragile_platform(x,y)

#repaint_assets:
	#repaint_object
	#repaint_platform

#initialize_the_game:
	#initialize_doodle
	#initialize_rocket
	#initialize_spring
	#initialize_5_platforms
	#initialize_5_fragile_platforms
	#initialize_score_board

#update_the_game:
	#update_new_fragile_platform
	#update_new_platform
	#update_new_object
	#update_score
	#increase_difficulty

#reframe_assets:
	#reframe_doodle
	#reframe_rocket
	#reframe_spring
	#reframe_platform
	#reframe_fragile_platform

#game_process:
	#fall_process
	#pause
	#sleep
	#hold_until_input(key)
	#reset_the_game

#detect_collision:
	#detect_collison_rocket
	#detect_collison_spring
	#detect_collison_platform
	#detect_collison_fragile_platform

#print_interface:
	#print_start_interface
	#print_pause_interface
	#print_end_interface


.data
 	s: .word 0x73
	p: .word 0x70
  	j: .word 0x6A
 	k: .word 0x6B


 	red: .word 0xff0000
	dark_green: .word 0x009900
	dark_green2: .word 0x107d0c
	green: .word 0x6bfa47
	green2: .word 0xa3f68e
	green3: .word 0x85e495
	purple: .word 0xe5a6fc
	blue: .word 0x0000ff
	light_blue: .word 0x00ffff
	white: .word 0xffffff
	yellow: .word 0xdff521
	yellow2: .word 0xf6f685
	black: .word 0x000000
	gray: .word 0x808080
  	light_yellow: .word 0xffe5cc
	pink: .word 0xffe8e8
	brown: .word 0xfdd73e
	brown2: .word 0xfdcb00

	keyBoard: .word 0xffff0000
	displayAddress: .word 0x10008000

	platform1_x: .word 0
  	platform2_x: .word 0
  	platform3_x: .word 0
  	platform4_x: .word 0
 	platform5_x: .word 0

 	platform1_y: .word 4608
  	platform2_y: .word 7424
  	platform3_y: .word 10240
  	platform4_y: .word 13056
  	platform5_y: .word 15872
  	
  	fragile_platform1_x: .word 0
  	fragile_platform2_x: .word 0
  	fragile_platform3_x: .word 0
  	fragile_platform4_x: .word 0
 	fragile_platform5_x: .word 0

 	fragile_platform1_y: .word 3328
  	fragile_platform2_y: .word 6144
  	fragile_platform3_y: .word 8960
  	fragile_platform4_y: .word 11776
  	fragile_platform5_y: .word 14592

	fragile_platform1_active: .word 1
	fragile_platform2_active: .word 1
	fragile_platform3_active: .word 1
	fragile_platform4_active: .word 1
	fragile_platform5_active: .word 1

  	doodle_x: .word 120
  	doodle_y: .word 12544

    	rocket1_x: .word 0
    	rocket1_y: .word 0
    	rocket2_x: .word 0
    	rocket2_y: .word 0
    	rocket3_x: .word 0
    	rocket3_y: .word 0
   	rocket4_x: .word 0
    	rocket4_y: .word 0
    	rocket5_x: .word 0
    	rocket5_y: .word 0

    	rocket1_active: .word 0
    	rocket2_active: .word 0
    	rocket3_active: .word 0
    	rocket4_active: .word 0
    	rocket5_active: .word 0

    	spring1_x: .word 0
    	spring1_y: .word 0
    	spring2_x: .word 0
    	spring2_y: .word 0
    	spring3_x: .word 0
    	spring3_y: .word 0
    	spring4_x: .word 0
    	spring4_y: .word 0
    	spring5_x: .word 0
    	spring5_y: .word 0

    	spring1_active: .word 0
    	spring2_active: .word 0
    	spring3_active: .word 0
    	spring4_active: .word 0
    	spring5_active: .word 0

	score_1: .word 0
	score_2: .word 0
	score_3: .word 0
	
	difficulty: .word 0
	difficulty_increase_rate: .word 0       # the bigger, the slower difficulty increases
	max_difficulty_increase: .word 0

	gravity: .word 5


	
.text
main:
	lw $s0, displayAddress
	lw $s1, keyBoard
	li $s2, 0 # sleep time
	li $s3, 0 # type of collision
	li $s7, 0 # loop index

	start_the_game:
    		jal print_start_interface
		lw $a0, s
    	   	jal hold_until_input
    	

	setup_the_game:
		jal initialize_the_game

   	reframe_the_game:
		jal game_process
		beqz $s3, fail
		li $s3, 0
		j reframe_the_game

	fail:
	    	jal print_end_interface
        	lw $a0, s
    		jal hold_until_input
		jal reset_the_game
		j setup_the_game
        	
        	
	li $v0, 10 
	syscall		

#print_assets:
	#print_doodle
	#print_rocket(x,y)
	#print_spring(x,y)
	#print_platform(x,y)
	#print_fragile_platform(x,y)
	#print_char_doodle_jump(color)
	#print_background(color)

#erase_assets:
	#erase_doodle
	#erase_rocket(x,y)
	#erase_spring(x,y)
	#erase_platform(x,y)
	#erase_fragile_platform(x,y)
	#crash_fragile_platform(x,y)

#repaint_assets:
	#repaint_object
	#repaint_platform

#initialize_the_game:
	#initialize_doodle
	#initialize_rocket
	#initialize_spring
	#initialize_5_platforms
	#initialize_5_fragile_platforms
	#initialize_score_board

#update_the_game:
	#update_new_fragile_platform
	#update_new_platform
	#update_new_object
	#update_score
	#increase_difficulty

#reframe_assets:
	#reframe_doodle
	#reframe_rocket
	#reframe_spring
	#reframe_platform
	#reframe_fragile_platform

#game_process:
	#fall_process
	#pause
	#sleep
	#hold_until_input(key)
	#reset_the_game

#detect_collision:
	#detect_collison_rocket
	#detect_collison_spring
	#detect_collison_platform
	#detect_collison_fragile_platform

#print_interface:
	#print_start_interface
	#print_pause_interface
	#print_end_interface




repaint_object:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	
	# repaint rocket
	lw $t8, rocket1_active
	beq $t8, 0, not_print_rocket1
	
	lw $a0, rocket1_x
	
	lw $a1, rocket1_y
	
	jal print_rocket 
	
	not_print_rocket1:
	lw $t8, rocket2_active
	beq $t8, 0, not_print_rocket2
	
	lw $a0, rocket2_x
	
	lw $a1, rocket2_y
	
	jal print_rocket
	
	not_print_rocket2:
	lw $t8, rocket3_active
	beq $t8, 0, not_print_rocket3
	
	lw $a0, rocket3_x
	
	lw $a1, rocket3_y
	
	jal print_rocket
	
	not_print_rocket3:
	lw $t8, rocket4_active
	beq $t8, 0, not_print_rocket4
	
	lw $a0, rocket4_x
	
	lw $a1, rocket4_y
	
	jal print_rocket
	
	not_print_rocket4:
	lw $t8, rocket5_active
	beq $t8, 0, not_print_rocket5
	
	lw $a0, rocket5_x
	
	lw $a1, rocket5_y
	
	jal print_rocket
	
	not_print_rocket5:
	
	# repaint spring
	lw $t8, spring1_active
	beq $t8, 0, not_print_spring1
	
	lw $a0, spring1_x
	
	lw $a1, spring1_y
	
	jal print_spring 
	
	not_print_spring1:
	lw $t8, spring2_active
	beq $t8, 0, not_print_spring2
	
	lw $a0, spring2_x
	
	lw $a1, spring2_y
	
	jal print_spring
	
	not_print_spring2:
	lw $t8, spring3_active
	beq $t8, 0, not_print_spring3
	
	lw $a0, spring3_x

	lw $a1, spring3_y
	
	jal print_spring
	
	not_print_spring3:
	lw $t8, spring4_active
	beq $t8, 0, not_print_spring4
	
	lw $a0, spring4_x
	
	lw $a1, spring4_y
	
	jal print_spring
	
	not_print_spring4:
	lw $t8, spring5_active
	beq $t8, 0, not_print_spring5
	
	lw $a0, spring5_x
	
	lw $a1, spring5_y
	
	jal print_spring
	
	not_print_spring5:
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4	
	jr $ra
	

repaint_platform:
	addi $sp, $sp, -4
	sw $ra, ($sp)
    		
	lw $a0, platform1_x
	lw $a1, platform1_y
	
	jal print_platform
		

	lw $a0, platform2_x
	lw $a1, platform2_y
	
	jal print_platform
		
	lw $a0, platform3_x
	lw $a1, platform3_y
	
	jal print_platform
		
	lw $a0, platform4_x
	lw $a1, platform4_y
	
	jal print_platform
		
	lw $a0, platform5_x
	lw $a1, platform5_y
	
	jal print_platform
	
	lw $t9, fragile_platform1_active
	beqz $t9, not_print_fragile_platform1
	lw $a0, fragile_platform1_x
	lw $a1, fragile_platform1_y
	
	jal print_fragile_platform
	not_print_fragile_platform1:

	lw $t9, fragile_platform2_active
	beqz $t9, not_print_fragile_platform2
	lw $a0, fragile_platform2_x
	lw $a1, fragile_platform2_y
	
	jal print_fragile_platform
	not_print_fragile_platform2:

	lw $t9, fragile_platform3_active
	beqz $t9, not_print_fragile_platform3
	lw $a0, fragile_platform3_x
	lw $a1, fragile_platform3_y
	
	jal print_fragile_platform
	not_print_fragile_platform3:

	lw $t9, fragile_platform4_active
	beqz $t9, not_print_fragile_platform4
	lw $a0, fragile_platform4_x
	lw $a1, fragile_platform4_y
	
	jal print_fragile_platform
	not_print_fragile_platform4:

	lw $t9, fragile_platform5_active
	beqz $t9, not_print_fragile_platform5
	lw $a0, fragile_platform5_x
	lw $a1, fragile_platform5_y
	
	jal print_fragile_platform
	not_print_fragile_platform5:

	lw $ra, ($sp)
    	addi $sp, $sp, 4	
	jr $ra

initialize_the_game:
	addi $sp, $sp, -4
	sw $ra, ($sp)
    		
	lw $a0, light_yellow       
	jal print_background

	jal initialize_score_board
	jal update_score

   	jal initialize_5_platforms
	jal initialize_5_fragile_platforms
	jal initialize_rocket
	jal initialize_spring
	jal initialize_doodle
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4	
	jr $ra

initialize_doodle:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	
	lw $t8, platform5_x
	addi $t8, $t8, 20
	
	la $t9, doodle_x
	sw $t8, 0($t9)
	
	lw $t8, platform5_y
	addi $t8, $t8, -256
	
	la $t9, doodle_y
	sw $t8, 0($t9)
	
	jal print_doodle
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4	
	jr $ra

erase_doodle:
	
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	lw $t1, doodle_x
	
	lw $t2, doodle_y
	
	add $t9, $t1, $t2  	 
	add $t9, $t9, $s0
	
	lw $t8, light_yellow
	sw $t8, 0($t9)		 
	sw $t8, 8($t9)
	sw $t8, -8($t9)
	sw $t8, -764($t9)		 
	sw $t8, -772($t9)
	
	sw $t8, -256($t9)		 
	sw $t8, -252($t9)
	sw $t8, -248($t9)
	sw $t8, -260($t9)		 
	sw $t8, -264($t9)	
	
	sw $t8, -512($t9)		 
	sw $t8, -508($t9)
	sw $t8, -504($t9)
	sw $t8, -516($t9)		 
	sw $t8, -520($t9)
	
	sw $t8, -768($t9)		 
	sw $t8, -760($t9)
	sw $t8, -776($t9)
	
	sw $t8, -1024($t9)		 
	sw $t8, -1020($t9)
	sw $t8, -1016($t9)
	sw $t8, -1028($t9)		 
	sw $t8, -1032($t9)
	
	sw $t8, -756($t9)
	sw $t8, -752($t9)
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra
		

	lw $ra, ($sp)
    	addi $sp, $sp, 4
  	
	jr $ra

print_doodle:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	la $t0, doodle_x
	lw $t1, 0($t0)
	
	la $t0, doodle_y
	lw $t2, 0($t0)
	
	add $t9, $t1, $t2  	 
	add $t9, $t9, $s0
	
	lw $t8, black
	sw $t8, 0($t9)		 
	sw $t8, 8($t9)
	sw $t8, -8($t9)
	sw $t8, -764($t9)		 
	sw $t8, -772($t9)
	
	lw $t8, green
	sw $t8, -260($t9)		 
	sw $t8, -264($t9)	

	lw $t8, green2
	sw $t8, -256($t9)		 
	sw $t8, -252($t9)
	sw $t8, -248($t9)

	
	lw $t8, yellow
	sw $t8, -512($t9)		 
	sw $t8, -508($t9)
	sw $t8, -504($t9)
	sw $t8, -516($t9)		 
	sw $t8, -520($t9)
	
	sw $t8, -768($t9)		 
	sw $t8, -776($t9)
			 
	sw $t8, -1032($t9)

	lw $t8, yellow2
	sw $t8, -1024($t9)		 
	sw $t8, -1020($t9)
	sw $t8, -1016($t9)
	sw $t8, -1028($t9)
	sw $t8, -752($t9)
	sw $t8, -756($t9)
	sw $t8, -760($t9)
	
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra
	
erase_rocket:
	addi $sp, $sp, -4
    	sw $ra, ($sp)

	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, light_yellow
	sw $t8, 0($t9)		  
	sw $t8, -256($t9)		 
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_rocket:
	addi $sp, $sp, -4
    	sw $ra, ($sp)

	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		
	sw $t8, -256($t9)		 
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_spring:
	addi $sp, $sp, -4
    	sw $ra, ($sp)

	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, green
	sw $t8, 0($t9)		 
	sw $t8, -260($t9)	 

	lw $t8, green3
	sw $t8, -256($t9)
	sw $t8, -252($t9)
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

erase_spring:
	addi $sp, $sp, -4
    	sw $ra, ($sp)

	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, light_yellow
	sw $t8, 0($t9)		  
	sw $t8, -256($t9)	
	sw $t8, -252($t9)
	sw $t8, -260($t9)	 
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra
	

print_platform:
		addi $sp, $sp, -4
    		sw $ra, ($sp)
	
		add $t9, $a0, $a1	
		add $t9, $t9, $s0
		
		lw $t8, dark_green
		sw $t8, 0($t9)           
		sw $t8, 4($t9)
		sw $t8, 8($t9)
		sw $t8, 12($t9)
		sw $t8, 16($t9)

		lw $t8, dark_green2
		sw $t8, 20($t9)
		sw $t8, 24($t9)
		sw $t8, 28($t9)
		sw $t8, 32($t9)
		sw $t8, 36($t9)
		sw $t8, 40($t9)
		
		lw $ra, ($sp)
    		addi $sp, $sp, 4
		jr $ra
		
erase_platform:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
		add $t9, $a0, $a1	
		add $t9, $t9, $s0
		
		lw $t8, light_yellow
		sw $t8, 0($t9)           
		sw $t8, 4($t9)
		sw $t8, 8($t9)
		sw $t8, 12($t9)
		sw $t8, 16($t9)
		sw $t8, 20($t9)
		sw $t8, 24($t9)
		sw $t8, 28($t9)
		sw $t8, 32($t9)
		sw $t8, 36($t9)
		sw $t8, 40($t9)
		
		lw $ra, ($sp)
    		addi $sp, $sp, 4
		jr $ra

print_char_doodlejump:
    addi $sp, $sp, -4
    sw $ra, ($sp)

    # print d
    add $t9, $s0, 2600
    sw $a0, 0($t9)
    
    add $t9, $s0, 2596
    sw $a0, 0($t9)
    
    add $t9, $s0, 2592
    sw $a0, 0($t9)
    
    add $t9, $s0, 2848
    sw $a0, 0($t9)
    
    add $t9, $s0, 3104
    sw $a0, 0($t9)
    
    add $t9, $s0, 3108
    sw $a0, 0($t9)
    
    add $t9, $s0, 3112
    sw $a0, 0($t9)
    
    add $t9, $s0, 2856
    sw $a0, 0($t9)
    
    add $t9, $s0, 2344
    sw $a0, 0($t9)
    
    add $t9, $s0, 2088
    sw $a0, 0($t9)
    
    add $t9, $s0, 1832
    sw $a0, 0($t9)
    
    # print o
    add $t9, $s0, 2608
    sw $a0, 0($t9)
    
    add $t9, $s0, 2612
    sw $a0, 0($t9)
    
    add $t9, $s0, 2616
    sw $a0, 0($t9)
    
    add $t9, $s0, 2872
    sw $a0, 0($t9)
    
    add $t9, $s0, 3128
    sw $a0, 0($t9)
    
    add $t9, $s0, 3124
    sw $a0, 0($t9)
    
    add $t9, $s0, 3120
    sw $a0, 0($t9)
    
    add $t9, $s0, 2864
    sw $a0, 0($t9)
    
    # print o
    add $t9, $s0, 2624
    sw $a0, 0($t9)
    
    add $t9, $s0, 2628
    sw $a0, 0($t9)
    
    add $t9, $s0, 2632
    sw $a0, 0($t9)
    
    add $t9, $s0, 2888
    sw $a0, 0($t9)
    
    add $t9, $s0, 3144
    sw $a0, 0($t9)
    
    add $t9, $s0, 3140
    sw $a0, 0($t9)
    
    add $t9, $s0, 3136
    sw $a0, 0($t9)
    
    add $t9, $s0, 2880
    sw $a0, 0($t9)
    
    add $t9, $s0, 2624
    sw $a0, 0($t9)
    
    # print d
    add $t9, $s0, 2640
    sw $a0, 0($t9)
    
    add $t9, $s0, 2644
    sw $a0, 0($t9)
    
    add $t9, $s0, 2896
    sw $a0, 0($t9)
    
    add $t9, $s0, 3152
    sw $a0, 0($t9)
    
    add $t9, $s0, 3156
    sw $a0, 0($t9)
    
    add $t9, $s0, 3160
    sw $a0, 0($t9)
    
    add $t9, $s0, 2904
    sw $a0, 0($t9)
    
    add $t9, $s0, 2648
    sw $a0, 0($t9)
    
    add $t9, $s0, 2392
    sw $a0, 0($t9)
    
    add $t9, $s0, 2136
    sw $a0, 0($t9)
    
    add $t9, $s0, 1880
    sw $a0, 0($t9)
    
    # print l
    add $t9, $s0, 2656
    sw $a0, 0($t9)
    
    add $t9, $s0, 2912
    sw $a0, 0($t9)
    
    add $t9, $s0, 3168
    sw $a0, 0($t9)
    
    add $t9, $s0, 2400
    sw $a0, 0($t9)
    
    add $t9, $s0, 2144
    sw $a0, 0($t9)
    
    add $t9, $s0, 1888
    sw $a0, 0($t9)
    
    # print e
    add $t9, $s0, 2664
    sw $a0, 0($t9)
    
    add $t9, $s0, 2668
    sw $a0, 0($t9)
    
    add $t9, $s0, 2672
    sw $a0, 0($t9)
    
    add $t9, $s0, 2416
    sw $a0, 0($t9)
    
    add $t9, $s0, 2160
    sw $a0, 0($t9)
    
    add $t9, $s0, 2156
    sw $a0, 0($t9)
    
    add $t9, $s0, 2152
    sw $a0, 0($t9)
    
    add $t9, $s0, 2408
    sw $a0, 0($t9)
    
    add $t9, $s0, 2920
    sw $a0, 0($t9)
    
    add $t9, $s0, 3176
    sw $a0, 0($t9)
    
    add $t9, $s0, 3180
    sw $a0, 0($t9)
    
    add $t9, $s0, 3184
    sw $a0, 0($t9)
    
    # print j
    add $t9, $s0, 2692
    sw $a0, 0($t9)
    
    add $t9, $s0, 2948
    sw $a0, 0($t9)
    
    add $t9, $s0, 3204
    sw $a0, 0($t9)
    
    add $t9, $s0, 3460
    sw $a0, 0($t9)
    
    add $t9, $s0, 3716
    sw $a0, 0($t9)
    
    add $t9, $s0, 3712
    sw $a0, 0($t9)
    
    add $t9, $s0, 2180
    sw $a0, 0($t9)
    
    # print u
    add $t9, $s0, 2700
    sw $a0, 0($t9)
    
    add $t9, $s0, 2956
    sw $a0, 0($t9)
    
    add $t9, $s0, 3212
    sw $a0, 0($t9)
    
    add $t9, $s0, 3216
    sw $a0, 0($t9)
    
    add $t9, $s0, 3220
    sw $a0, 0($t9)
    
    add $t9, $s0, 2964
    sw $a0, 0($t9)
    
    add $t9, $s0, 2708
    sw $a0, 0($t9)
    
    # print m
    add $t9, $s0, 2716
    sw $a0, 0($t9)
    
    add $t9, $s0, 2972
    sw $a0, 0($t9)
    
    add $t9, $s0, 3228
    sw $a0, 0($t9)
    
    add $t9, $s0, 2720
    sw $a0, 0($t9)
    
    add $t9, $s0, 2724
    sw $a0, 0($t9)
    
    add $t9, $s0, 2980
    sw $a0, 0($t9)
    
    add $t9, $s0, 3236
    sw $a0, 0($t9)
    
    add $t9, $s0, 2728
    sw $a0, 0($t9)
    
    add $t9, $s0, 2732
    sw $a0, 0($t9)
    
    add $t9, $s0, 2988
    sw $a0, 0($t9)
    
    add $t9, $s0, 3244
    sw $a0, 0($t9)
   
    # print p
    add $t9, $s0, 2740
    sw $a0, 0($t9)
    
    add $t9, $s0, 2744
    sw $a0, 0($t9)
    
    add $t9, $s0, 2748
    sw $a0, 0($t9)
    
    add $t9, $s0, 3004
    sw $a0, 0($t9)
    
    add $t9, $s0, 3260
    sw $a0, 0($t9)
    
    add $t9, $s0, 3256
    sw $a0, 0($t9)
    
    add $t9, $s0, 2996
    sw $a0, 0($t9)
    
    add $t9, $s0, 3252
    sw $a0, 0($t9)
    
    add $t9, $s0, 3508
    sw $a0, 0($t9)
    
    add $t9, $s0, 3764
    sw $a0, 0($t9)
    
    add $t9, $s0, 4020
    sw $a0, 0($t9)
    
    lw $ra, ($sp)
    addi $sp, $sp, 4
    jr $ra


initialize_5_platforms:
		addi $sp, $sp, -4
    		sw $ra, ($sp)
		
		
		# 1st platform
		li $v0, 42                # $a0 = a random number 0-31
		li $a0, 0
		li $a1, 54
		syscall
		
		sll $a0, $a0, 2	         # $a0 = a random number 0-124 (increment by 4)
		
		la $t9, platform1_x
		sw $a0, 0($t9)
		
		
		# 2ed platform
		li $v0, 42                # $a0 = a random number 0-31
		li $a0, 0
		li $a1, 54
		syscall
		
		sll $a0, $a0, 2	         # $a0 = a random number 0-124 (increment by 4)
		
		add $t1, $a0, $zero      # $t1= the initial position of the 2ed platform
	
		la $t9, platform2_x
		sw $a0, 0($t9)
		
		# 3rd platform
		li $v0, 42                # $a0 = a random number 0-31
		li $a0, 0
		li $a1, 54
		syscall
		
		sll $a0, $a0, 2	         # $a0 = a random number 0-124 (increment by 4)
		
		add $t2, $a0, $zero      # $t2 = the initial position of the 3rd platform
	
		la $t9, platform3_x
		sw $a0, 0($t9)
		
		# 4th platform
		li $v0, 42                # $a0 = a random number 0-31
		li $a0, 0
		li $a1, 54
		syscall
		
		sll $a0, $a0, 2	         # $a0 = a random number 0-124 (increment by 4)
		
		add $t3, $a0, $zero      # $t3 = the initial position of the 4th platform
	
		la $t9, platform4_x
		sw $a0, 0($t9)
		
		# 5th platform
		li $v0, 42                # $a0 = a random number 0-31
		li $a0, 0
		li $a1, 54
		syscall
		
		sll $a0, $a0, 2	         # $a0 = a random number 0-124 (increment by 4)
		
		add $t4, $a0, $zero      # $t4 = the initial position of the 5th platform
	
		la $t9, platform5_x
		sw $a0, 0($t9)
		
		# print 5 platforms
		la $t9, platform1_x
		lw $a0, 0($t9)
	
		la $t9, platform1_y
		lw $a1, 0($t9)
	
		jal print_platform
		
		la $t9, platform2_x
		lw $a0, 0($t9)
	
		la $t9, platform2_y
		lw $a1, 0($t9)
	
		jal print_platform
		
		la $t9, platform3_x
		lw $a0, 0($t9)
	
		la $t9, platform3_y
		lw $a1, 0($t9)
	
		jal print_platform
		
		la $t9, platform4_x
		lw $a0, 0($t9)
	
		la $t9, platform4_y
		lw $a1, 0($t9)
	
		jal print_platform
		
		la $t9, platform5_x
		lw $a0, 0($t9)
	
		la $t9, platform5_y
		lw $a1, 0($t9)
	
		jal print_platform
		
		
		lw $ra, ($sp)
    		addi $sp, $sp, 4
    		
		jr $ra
		
		
initialize_rocket:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
    	
    	
	li $v0, 42                # $a0 = a random number 0-10
	li $a0, 0
	li $a1, 10
	syscall
	
	addi $a0, $a0, -7	  #  3/10 chance of generating a rocket
	bltz $a0, not_generate_rocket
	
	# generate rocket
	li $v0, 42          
	li $a0, 0
	li $a1, 11
	syscall
	
	sll $a0, $a0, 2
	
	la $t9, platform2_x
	lw $t8, 0($t9)
	add $a0, $a0, $t8
	la $t7, rocket2_x
	sw $a0, 0($t7)
	
	la $t9, platform2_y
	lw $a1, 0($t9)
	addi $a1, $a1, -256
	la $t7, rocket2_y
	sw $a1, 0($t7)
	
	jal print_rocket		 
	
	la $t9, rocket2_active
	li $t8, 1
	sw $t8, 0($t9)
	
	not_generate_rocket:

	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra
	
initialize_spring:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
    	
    		
	li $v0, 42                # $a0 = a random number 0-20
	li $a0, 0
	li $a1, 10
	syscall
	
	addi $a0, $a0, -5	  #  1/2 chance of generating a spring
	bltz $a0, not_generate_spring1
	
	# generate spring
	li $v0, 42          
	li $a0, 0
	li $a1, 11
	syscall
	
	sll $a0, $a0, 2
	
	lw $t8, platform3_x
	add $a0, $a0, $t8
	la $t7, spring3_x
	sw $a0, 0($t7)

	lw $a1, platform3_y	
	add $a1, $a1, -256
	la $t7, spring3_y
	sw $a1, 0($t7)	
	
	jal print_spring
	
	la $t9, spring3_active
	li $t8, 1
	sw $t8, 0($t9)
	
	j not_generate_spring2
	
	not_generate_spring1:
		li $v0, 42          
		li $a0, 0
		li $a1, 11
		syscall
	
		sll $a0, $a0, 2
	
		lw $t8, platform4_x
		add $a0, $a0, $t8
		la $t7, spring4_x
		sw $a0, 0($t7)
	
		lw $a1, platform4_y	
		add $a1, $a1, -256
		la $t7, spring4_y
		sw $a1, 0($t7)	
	
		jal print_spring
	
		la $t9, spring4_active
		li $t8, 1
		sw $t8, 0($t9)
	
	not_generate_spring2:
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra
	
game_process:
	addi $sp, $sp, -4
	sw $ra, ($sp)

    	jal jump_process
   	    jal fall_process

    	lw $ra, ($sp)
    	addi $sp, $sp, 4
	jr $ra

fall_process:
	addi $sp, $sp, -4
	sw $ra, ($sp)

	li $s2, 105

	fall_while:
		lw $t9, difficulty
		lw $t7, difficulty_increase_rate
		srlv $t9, $t9, $t7

		lw $t8, max_difficulty_increase
		sub $t8, $t8, $t9
		bgez $t8, fall_latency
		li $t8, 0

		fall_latency:
			li $v0, 32
			move $a0, $t8
			syscall

		lw $s7, doodle_y
		bgt $s7, 16384, fall_while_done 
		
		
		addi $s7, $s7, 1
			
		jal erase_doodle
		jal repaint_platform 	
		jal repaint_object

			
		fall_detect_input:
			lw $t9, 0($s1)
			andi $t9, $t9, 0x00000001
			beqz $t9, fall_detect_done
				
			lbu $t9, 4($s1)
			beq $t9, 0x6A, fall_respond_to_j
			beq $t9, 0x6B, fall_respond_to_k
			beq $t9, 0x70, fall_respond_to_p
			j fall_detect_done
			
		fall_respond_to_p:
			jal pause
			sw $zero, 4($s1)	# erase the previous keyboard input value
			j fall_detect_done
				
		fall_respond_to_j:
			la $t9, doodle_x
			lw $t8, 0($t9)
			bgt $t8, 0, fall_add_done
			addi $t8, $t8, 256
			sw $t8, 0($t9)
				
			la $t9, doodle_y
			lw $t8, 0($t9)
			addi $t8, $t8, 256
			sw $t8, 0($t9)  
				
			fall_add_done:
				
			la $t9, doodle_x
			lw $t8, 0($t9)
			addi $t8, $t8, -4
			sw $t8, 0($t9)  
				
			sw $zero, 4($s1)	# erase the previous keyboard input value
			j fall_detect_done
		
		fall_respond_to_k:
			la $t9, doodle_x
			lw $t8, 0($t9)
			blt $t8, 256, fall_subtract_done
			addi $t8, $t8, -256
			sw $t8, 0($t9)
				
			la $t9, doodle_y
			lw $t8, 0($t9)
			addi $t8, $t8, -256
			sw $t8, 0($t9)
			fall_subtract_done:
					
			la $t9, doodle_x
			lw $t8, 0($t9)
			addi $t8, $t8, 4
			sw $t8, 0($t9)  
				
			sw $zero, 4($s1)	# erase the previous keyboard input value
			j fall_detect_done	# erase the previous keyboard input value
		
		fall_detect_done:
			
			la $t9, doodle_y
			lw $t8, 0($t9)
			addi $t8, $t8, 256
			sw $t8, 0($t9)
			
			jal print_doodle

			jal detect_collision
			
			beq $s3, 0, collide_nothing
			beq $s3, 1, collide_platform1
			beq $s3, 2, collide_platform2
			beq $s3, 3, collide_platform3
			beq $s3, 4, collide_platform4
			beq $s3, 5, collide_platform5
			beq $s3, 6, collide_spring
			beq $s3, 7, collide_rocket
			beq $s3, 8, collide_rocket
			beq $s3, 9, collide_rocket
			beq $s3, 10, collide_rocket
			beq $s3, 11, collide_rocket
			beq $s3, 12, collide_fragile_platform1
			beq $s3, 13, collide_fragile_platform2
			beq $s3, 14, collide_fragile_platform3
			beq $s3, 15, collide_fragile_platform4
			beq $s3, 16, collide_fragile_platform5

			collide_platform5:
				j fall_while_done

			collide_platform4:
				jal reframe_assets
				j fall_while_done

			collide_platform3:
				jal reframe_assets
				jal reframe_assets
				j fall_while_done

			collide_platform2:
				jal reframe_assets
				jal reframe_assets
				jal reframe_assets
				j fall_while_done

			collide_platform1:
				jal reframe_assets
				jal reframe_assets
				jal reframe_assets
				jal reframe_assets
				j fall_while_done

			collide_fragile_platform1:
				la $t9, fragile_platform1_active
				sw $zero, 0($t9)
				lw $a0, fragile_platform1_x
				lw $a1, fragile_platform1_y
				jal crash_fragile_platform
				li $s3, 0
				j collide_nothing

			collide_fragile_platform2:
				la $t9, fragile_platform2_active
				sw $zero, 0($t9)
				lw $a0, fragile_platform2_x
				lw $a1, fragile_platform2_y
				jal crash_fragile_platform
				li $s3, 0
				j collide_nothing

			collide_fragile_platform3:
				la $t9, fragile_platform3_active
				sw $zero, 0($t9)
				lw $a0, fragile_platform3_x
				lw $a1, fragile_platform3_y
				jal crash_fragile_platform
				li $s3, 0
				j collide_nothing

			collide_fragile_platform4:
				la $t9, fragile_platform4_active
				sw $zero, 0($t9)
				lw $a0, fragile_platform4_x
				lw $a1, fragile_platform4_y
				jal crash_fragile_platform
				li $s3, 0
				j collide_nothing

			collide_fragile_platform5:
				la $t9, fragile_platform5_active
				sw $zero, 0($t9)
				lw $a0, fragile_platform5_x
				lw $a1, fragile_platform5_y
				jal crash_fragile_platform
				li $s3, 0
				j collide_nothing
				



			collide_rocket:
				beq $s3, 7, diactive1
				beq $s3, 8, diactive2
				beq $s3, 9, diactive3
				beq $s3, 10, diactive4
				beq $s3, 11, diactive5
				j disactive_done

				diactive1:
					la $t9, rocket1_active
					sw $zero, 0($t9)
					lw $a0, rocket1_x
					lw $a1, rocket1_y
					jal erase_rocket
					j disactive_done

				diactive2:
					la $t9, rocket2_active
					sw $zero, 0($t9)
					lw $a0, rocket2_x
					lw $a1, rocket2_y
					jal erase_rocket
					j disactive_done

				diactive3:
					la $t9, rocket3_active
					sw $zero, 0($t9)
					lw $a0, rocket3_x
					lw $a1, rocket3_y
					jal erase_rocket
					j disactive_done

				diactive4:
					la $t9, rocket4_active
					sw $zero, 0($t9)
					lw $a0, rocket4_x
					lw $a1, rocket4_y
					jal erase_rocket
					j disactive_done

				diactive5:
					la $t9, rocket5_active
					sw $zero, 0($t9)
					lw $a0, rocket5_x
					lw $a1, rocket5_y
					jal erase_rocket
					j disactive_done

				disactive_done:

				li $s4, 0
				active_rocket_while:
					li $a0, 120
					li $a1, 768
					jal print_p
					li $a0, 140
					li $a1, 768
					jal print_o
					li $a0, 160
					li $a1, 768
					jal print_g
					li $a0, 180
					li $a1, 768
					jal print_g
					li $a0, 200
					li $a1, 768
					jal print_e
					li $a0, 220
					li $a1, 768
					jal print_r
					li $a0, 240
					li $a1, 768
					jal print_s

					beq $s4, 100, active_rocket_done

					lw $a0, doodle_x
					lw $a1, doodle_y
					jal erase_doodle
					jal repaint_platform 	
					jal repaint_object
					la $t9, doodle_y
					lw $t8, 0($t9)
					addi $t8, $t8, -256
					sw $t8, 0($t9)
					lw $a0, doodle_x
					lw $a1, doodle_y
					jal print_doodle
					li $v0, 32
					li $a0, 10
					syscall
					addi $s4, $s4, 1

					lw $t8, doodle_y
					bgt $t8, 4608, rocket_not_move_up
				    jal reframe_assets

					rocket_not_move_up:

					j active_rocket_while

				active_rocket_done:
				j fall_while_done

			collide_spring:

				li $s4, 0
				active_spring_while:
					li $a0, 200
					li $a1, 768
					jal print_w
					li $a0, 220
					li $a1, 768
					jal print_o
					li $a0, 240
					li $a1, 768
					jal print_w

					beq $s4, 15, active_spring_done

					lw $a0, doodle_x
					lw $a1, doodle_y
					jal erase_doodle
					jal repaint_platform 	
					jal repaint_object
					la $t9, doodle_y
					lw $t8, 0($t9)
					addi $t8, $t8, -256
					sw $t8, 0($t9)
					lw $a0, doodle_x
					lw $a1, doodle_y
					jal print_doodle
					addi $s4, $s4, 1
					li $v0, 32
					li $a0, 15
					syscall

					lw $t8, doodle_y
					bgt $t8, 4608, spring_not_move_up
					jal reframe_assets

					spring_not_move_up:

					j active_spring_while

				active_spring_done:
				j fall_while_done

			collide_nothing:
			
			blt $s2, 15, speed_not_increase
			lw $t9, gravity
			sub $t9, $zero, $t9
			add $s2, $s2, $t9
			speed_not_increase:

			jal sleep	
	
		j fall_while	

	fall_while_done:

    lw $ra, ($sp)
    	addi $sp, $sp, 4
	jr $ra

update_new_platform:
	addi $sp, $sp, -4
	sw $ra, ($sp)

	li $v0, 42                # $a0 = a random number 0-31
	li $a0, 0
	li $a1, 54
	syscall
		
	sll $a0, $a0, 2

	la $t9, platform1_x
	sw $a0, 0($t9)

	la $t9, platform1_y
	li $t8, 4608
	sw $t8, 0($t9)

	lw $a0, platform1_x
	lw $a1, platform1_y
	jal print_platform

	lw $ra, ($sp)
    	addi $sp, $sp, 4
	jr $ra

update_new_object:
	addi $sp, $sp, -4
	sw $ra, ($sp)

	li $v0, 42              
	li $a0, 0
	li $a1, 11
	syscall
	addi $a0, $a0, -10
	bltz $a0, not_generate_new_rocket	# 1/10
	li $v0, 42           
	li $a0, 0
	li $a1, 11
	syscall
	sll $a0, $a0, 2
	la $t9, rocket1_active
	li $t8, 1
	sw $t8, 0($t9)
	la $t9, rocket1_x
	lw $t8, platform1_x
	add $a0, $a0, $t8
	sw $a0, 0($t9)
	la $t9, rocket1_y
	lw $t8, platform1_y
	addi $t8, $t8, -256
	sw $t8, 0($t9)

	lw $a0, rocket1_x
	lw $a1, rocket1_y
	jal print_rocket
	j object_generate_done

	not_generate_new_rocket:

	li $v0, 42              
	li $a0, 0
	li $a1, 11
	syscall
	addi $a0, $a0, -9
	bltz $a0, not_generate_new_spring	# 1/5
	li $v0, 42           
	li $a0, 0
	li $a1, 11
	syscall
	sll $a0, $a0, 2
	la $t9, spring1_active
	li $t8, 1
	sw $t8, 0($t9)
	la $t9, spring1_x
	lw $t8, platform1_x
	add $a0, $a0, $t8
	sw $a0, 0($t9)
	la $t9, spring1_y
	lw $t8, platform1_y
	addi $t8, $t8, -256
	sw $t8, 0($t9)

	lw $a0, spring1_x
	lw $a1, spring1_y
	jal print_spring
	j object_generate_done

	not_generate_new_spring:

	object_generate_done:

	lw $ra, ($sp)
    addi $sp, $sp, 4
	jr $ra

reframe_rocket:
	addi $sp, $sp, -4
	sw $ra, ($sp)

		lw $t9, rocket1_active
		beq $t9, 0, no_reframe_rocket1
		lw $a0, rocket1_x
		lw $a1, rocket1_y
		jal erase_rocket
		la $t9, rocket1_y
		lw $t8 0($t9)
		addi $t8, $t8, 256
		sw $t8, 0($t9)
		no_reframe_rocket1:

		lw $t9, rocket2_active
		beq $t9, 0, no_reframe_rocket2
		lw $a0, rocket2_x
		lw $a1, rocket2_y
		jal erase_rocket
		la $t9, rocket2_y
		lw $t8 0($t9)
		addi $t8, $t8, 256
		sw $t8, 0($t9)
		no_reframe_rocket2:

		lw $t9, rocket3_active
		beq $t9, 0, no_reframe_rocket3
		lw $a0, rocket3_x
		lw $a1, rocket3_y
		jal erase_rocket
		la $t9, rocket3_y
		lw $t8 0($t9)
		addi $t8, $t8, 256
		sw $t8, 0($t9)
		no_reframe_rocket3:

		lw $t9, rocket4_active
		beq $t9, 0, no_reframe_rocket4
		lw $a0, rocket4_x
		lw $a1, rocket4_y
		jal erase_rocket
		la $t9, rocket4_y
		lw $t8 0($t9)
		addi $t8, $t8, 256
		sw $t8, 0($t9)
		no_reframe_rocket4:

		lw $t9, rocket1_active
		beq $t9, 0, no_paint_rocket1
		lw $a0, rocket1_x
		lw $a1, rocket1_y
		jal print_rocket
		no_paint_rocket1:

		lw $t9, rocket2_active
		beq $t9, 0, no_paint_rocket2
		lw $a0, rocket2_x
		lw $a1, rocket2_y
		jal print_rocket
		no_paint_rocket2:

		lw $t9, rocket3_active
		beq $t9, 0, no_paint_rocket3
		lw $a0, rocket3_x
		lw $a1, rocket3_y
		jal print_rocket
		no_paint_rocket3:

		lw $t9, rocket4_active
		beq $t9, 0, no_paint_rocket4
		lw $a0, rocket4_x
		lw $a1, rocket4_y
		jal print_rocket
		no_paint_rocket4:

		lw $ra, ($sp)
   	 	addi $sp, $sp, 4
		jr $ra

reframe_spring:
		addi $sp, $sp, -4
		sw $ra, ($sp)

		lw $t9, spring1_active
		beq $t9, 0, no_reframe_spring1
		lw $a0, spring1_x
		lw $a1, spring1_y
		jal erase_spring
		la $t9, spring1_y
		lw $t8 0($t9)
		addi $t8, $t8, 256
		sw $t8, 0($t9)
		no_reframe_spring1:

		lw $t9, spring2_active
		beq $t9, 0, no_reframe_spring2
		lw $a0, spring2_x
		lw $a1, spring2_y
		jal erase_spring
		la $t9, spring2_y
		lw $t8 0($t9)
		addi $t8, $t8, 256
		sw $t8, 0($t9)
		no_reframe_spring2:

		lw $t9, spring3_active
		beq $t9, 0, no_reframe_spring3
		lw $a0, spring3_x
		lw $a1, spring3_y
		jal erase_spring
		la $t9, spring3_y
		lw $t8 0($t9)
		addi $t8, $t8, 256
		sw $t8, 0($t9)
		no_reframe_spring3:

		lw $t9, spring4_active
		beq $t9, 0, no_reframe_spring4
		lw $a0, spring4_x
		lw $a1, spring4_y
		jal erase_spring
		la $t9,spring4_y
		lw $t8 0($t9)
		addi $t8, $t8, 256
		sw $t8, 0($t9)
		no_reframe_spring4:

		lw $t9, spring1_active
		beq $t9, 0, no_paint_spring1
		lw $a0, spring1_x
		lw $a1, spring1_y
		jal print_spring
		no_paint_spring1:

		lw $t9, spring2_active
		beq $t9, 0, no_paint_spring2
		lw $a0, spring2_x
		lw $a1, spring2_y
		jal print_spring
		no_paint_spring2:

		lw $t9, spring3_active
		beq $t9, 0, no_paint_spring3
		lw $a0, spring3_x
		lw $a1, spring3_y
		jal print_spring
		no_paint_spring3:

		lw $t9, spring4_active
		beq $t9, 0, no_paint_spring4
		lw $a0, spring4_x
		lw $a1, spring4_y
		jal print_spring
		no_paint_spring4:

		lw $ra, ($sp)
   	 	addi $sp, $sp, 4
		jr $ra
	
reframe_platform:
		addi $sp, $sp, -4
		sw $ra, ($sp)

		lw $a0, platform1_x
		lw $a1, platform1_y
		jal erase_platform

		lw $a0, platform2_x
		lw $a1, platform2_y
		jal erase_platform

		lw $a0, platform3_x
		lw $a1, platform3_y
		jal erase_platform

		lw $a0, platform4_x
		lw $a1, platform4_y
		jal erase_platform

		la $t9, platform1_y
		lw $t8 0($t9)
		addi $t8, $t8, 256
		sw $t8, 0($t9)

		la $t9, platform2_y
		lw $t8 0($t9)
		addi $t8, $t8, 256
		sw $t8, 0($t9)

		la $t9, platform3_y
		lw $t8 0($t9)
		addi $t8, $t8, 256
		sw $t8, 0($t9)

		la $t9, platform4_y
		lw $t8 0($t9)
		addi $t8, $t8, 256
		sw $t8, 0($t9)

		lw $a0, platform1_x
		lw $a1, platform1_y
		jal print_platform

		lw $a0, platform2_x
		lw $a1, platform2_y
		jal print_platform

		lw $a0, platform3_x
		lw $a1, platform3_y
		jal print_platform

		lw $a0, platform4_x
		lw $a1, platform4_y
		jal print_platform

		lw $ra, ($sp)
    		addi $sp, $sp, 4
		jr $ra

reframe_assets:
	addi $sp, $sp, -4
	sw $ra, ($sp)

	lw $a0, platform5_x
	lw $a1, platform5_y
	jal erase_platform

	lw $t9, fragile_platform5_active
	beq $t9, 0, not_erase_fragile_platform5
	lw $a0, fragile_platform5_x
	lw $a1, fragile_platform5_y
	jal erase_fragile_platform
	not_erase_fragile_platform5:

	lw $t9, rocket5_active
	beq $t9, 0, not_erase_rocket5
	lw $a0, rocket5_x
	lw $a1, rocket5_y
	jal erase_rocket
	not_erase_rocket5:

	lw $t9, spring5_active
	beq $t9, 0, not_erase_spring5
	lw $a0, spring5_x
	lw $a1, spring5_y
	jal erase_spring
	not_erase_spring5:

	li $s6, 0
	reframe_while:
		beq $s6, 11, reframe_done
		jal reframe_platform
		jal reframe_fragile_platform
		jal reframe_rocket
		jal reframe_spring
		jal reframe_doodle

		li $v0, 32
		li $a0, 10
		syscall

		addi $s6, $s6, 1
		j reframe_while
	
	reframe_done:

	la $t9, platform5_x
	lw $t8, platform4_x
	sw $t8, 0($t9)
	la $t9, platform5_y
	lw $t8, platform4_y
	sw $t8, 0($t9)

	la $t9, platform4_x
	lw $t8, platform3_x
	sw $t8, 0($t9)
	la $t9, platform4_y
	lw $t8, platform3_y
	sw $t8, 0($t9)

	la $t9, platform3_x
	lw $t8, platform2_x
	sw $t8, 0($t9)
	la $t9, platform3_y
	lw $t8, platform2_y
	sw $t8, 0($t9)

	la $t9, platform2_x
	lw $t8, platform1_x
	sw $t8, 0($t9)
	la $t9, platform2_y
	lw $t8, platform1_y
	sw $t8, 0($t9)

	la $t9, fragile_platform5_active
	lw $t8, fragile_platform4_active
	sw $t8, 0($t9)
	la $t9, fragile_platform5_x
	lw $t8, fragile_platform4_x
	sw $t8, 0($t9)
	la $t9, fragile_platform5_y
	lw $t8, fragile_platform4_y
	sw $t8, 0($t9)

	la $t9, fragile_platform4_active
	lw $t8, fragile_platform3_active
	sw $t8, 0($t9)
	la $t9, fragile_platform4_x
	lw $t8, fragile_platform3_x
	sw $t8, 0($t9)
	la $t9, fragile_platform4_y
	lw $t8, fragile_platform3_y
	sw $t8, 0($t9)

	la $t9, fragile_platform3_active
	lw $t8, fragile_platform2_active
	sw $t8, 0($t9)
	la $t9, fragile_platform3_x
	lw $t8, fragile_platform2_x
	sw $t8, 0($t9)
	la $t9, fragile_platform3_y
	lw $t8, fragile_platform2_y
	sw $t8, 0($t9)

	la $t9, fragile_platform2_active
	lw $t8, fragile_platform1_active
	sw $t8, 0($t9)
	la $t9, fragile_platform2_x
	lw $t8, fragile_platform1_x
	sw $t8, 0($t9)
	la $t9, fragile_platform2_y
	lw $t8, fragile_platform1_y
	sw $t8, 0($t9)
	
	la $t9, fragile_platform1_active
	sw $zero, 0($t9)

	la $t9, rocket5_active
	lw $t8, rocket4_active
	sw $t8, 0($t9)
	la $t9, rocket5_x
	lw $t8, rocket4_x
	sw $t8, 0($t9)
	la $t9, rocket5_y
	lw $t8, rocket4_y
	sw $t8, 0($t9)

	la $t9, rocket4_active
	lw $t8, rocket3_active
	sw $t8, 0($t9)
	la $t9, rocket4_x
	lw $t8, rocket3_x
	sw $t8, 0($t9)
	la $t9, rocket4_y
	lw $t8, rocket3_y
	sw $t8, 0($t9)

	la $t9, rocket3_active
	lw $t8, rocket2_active
	sw $t8, 0($t9)
	la $t9, rocket3_x
	lw $t8, rocket2_x
	sw $t8, 0($t9)
	la $t9, rocket3_y
	lw $t8, rocket2_y
	sw $t8, 0($t9)

	la $t9, rocket2_active
	lw $t8, rocket1_active
	sw $t8, 0($t9)
	la $t9, rocket2_x
	lw $t8, rocket1_x
	sw $t8, 0($t9)
	la $t9, rocket2_y
	lw $t8, rocket1_y
	sw $t8, 0($t9)

	la $t9, rocket1_active
	sw $zero, 0($t9)

	la $t9, spring5_active
	lw $t8, spring4_active
	sw $t8, 0($t9)
	la $t9, spring5_x
	lw $t8, spring4_x
	sw $t8, 0($t9)
	la $t9, spring5_y
	lw $t8, spring4_y
	sw $t8, 0($t9)

	la $t9, spring4_active
	lw $t8, spring3_active
	sw $t8, 0($t9)
	la $t9, spring4_x
	lw $t8, spring3_x
	sw $t8, 0($t9)
	la $t9, spring4_y
	lw $t8, spring3_y
	sw $t8, 0($t9)

	la $t9, spring3_active
	lw $t8, spring2_active
	sw $t8, 0($t9)
	la $t9, spring3_x
	lw $t8, spring2_x
	sw $t8, 0($t9)
	la $t9, spring3_y
	lw $t8, spring2_y
	sw $t8, 0($t9)

	la $t9, spring2_active
	lw $t8, spring1_active
	sw $t8, 0($t9)
	la $t9, spring2_x
	lw $t8, spring1_x
	sw $t8, 0($t9)
	la $t9, spring2_y
	lw $t8, spring1_y
	sw $t8, 0($t9)

	la $t9, spring1_active
	sw $zero, 0($t9)

	jal update_new_platform
	jal update_new_fragile_platform
	jal update_new_object
	jal increase_difficulty
	jal update_score

	lw $ra, ($sp)
    	addi $sp, $sp, 4
	jr $ra





reframe_doodle:
	addi $sp, $sp, -4
	sw $ra, ($sp)

	lw $a0, doodle_x
	lw $a1, doodle_y
	jal erase_doodle

	la $t9, doodle_y
	lw $t8, 0($t9)
	addi $t8, $t8, 256
	sw $t8, ($t9)

	lw $a0, doodle_x
	lw $a1, doodle_y
	jal print_doodle

	lw $ra, ($sp)
    	addi $sp, $sp, 4
	jr $ra


jump_process:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
    
	
	li $s7, 0
	li $s2, 0

	jump_while:
		lw $t9, difficulty
		lw $t7, difficulty_increase_rate
		srlv $t9, $t9, $t7			# difficulty divided by rate
	
		lw $t8, max_difficulty_increase
		sub $t8, $t8, $t9
		bgez $t8, jump_latency
		li $t8, 0

		jump_latency:
			li $v0, 32
			move $a0, $t8
			syscall
		
	
		beq $s7, 35, jump_while_done 
		
		
		addi $s7, $s7, 1
			
		jal erase_doodle
		jal repaint_platform 	
		jal repaint_object

			
			jump_detect_input:
				lw $t9, 0($s1)
				andi $t9, $t9, 0x00000001
				beqz $t9, jump_detect_done
				
				lbu $t9, 4($s1)
				beq $t9, 0x6A, jump_respond_to_j
				beq $t9, 0x6B, jump_respond_to_k
				beq $t9, 0x70, jump_respond_to_p
				j jump_detect_done
			
			jump_respond_to_p:
				jal pause
				sw $zero, 4($s1)	# erase the previous keyboard input value
				j jump_detect_done
				
			jump_respond_to_j:
				la $t9, doodle_x
				lw $t8, 0($t9)
				bgt $t8, 0, jump_add_done
				addi $t8, $t8, 256
				sw $t8, 0($t9)
				
				la $t9, doodle_y
				lw $t8, 0($t9)
				addi $t8, $t8, 256
				sw $t8, 0($t9)  
				
				jump_add_done:
				
				la $t9, doodle_x
				lw $t8, 0($t9)
				addi $t8, $t8, -4
				sw $t8, 0($t9)  
				
				sw $zero, 4($s1)	# erase the previous keyboard input value
				j jump_detect_done
		
			jump_respond_to_k:
				la $t9, doodle_x
				lw $t8, 0($t9)
				blt $t8, 256, jump_subtract_done
				addi $t8, $t8, -256
				sw $t8, 0($t9)
				
				la $t9, doodle_y
				lw $t8, 0($t9)
				addi $t8, $t8, -256
				sw $t8, 0($t9)
				jump_subtract_done:
					
				la $t9, doodle_x
				lw $t8, 0($t9)
				addi $t8, $t8, 4
				sw $t8, 0($t9)  
				
				sw $zero, 4($s1)	# erase the previous keyboard input value
				j jump_detect_done	# erase the previous keyboard input value
		
			jump_detect_done:
			
			la $t9, doodle_y
			lw $t8, 0($t9)
			addi $t8, $t8, -256
			sw $t8, 0($t9)
			
			jal print_doodle

			lw $t8, doodle_y
			bgt $t8, 4608, not_move_up
			jal reframe_assets

			not_move_up:
			
			bgt $s2, 105, no_speed_down
			lw $t9, gravity
			add $s2, $s2, $t9

			no_speed_down:
			jal sleep	
	
		j jump_while
		
	jump_while_done:
	
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
  	
	jr $ra


pause:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	jal print_pause_interface
	
	lw $a0, p
	jal hold_until_input
		
	lw $a0, light_yellow		
	jal print_background
	
	lw $a0, black
	jal initialize_score_board	
	jal update_score	
		
	jal repaint_platform
	jal repaint_object
	
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra
	

# a0 time of sleep
sleep:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
    		
	li $v0, 32
	move $a0, $s2
	syscall
    
    	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra
	
# a0 the key
hold_until_input:
	addi $sp, $sp, -4
    	sw $ra, ($sp)	
    	
    	detect_again:
		lw $t9, 0($s1)
		andi $t9, $t9, 0x00000001
		beqz $t9, detect_again
				
		lbu $t9, 4($s1)
		beq $t9, $a0, respond_to_key
		j detect_again
				
	respond_to_key:
	sw $zero, 4($s1)
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
   	jr $ra
   	 
   	 
initialize_score_board:
		addi $sp, $sp, -4
    		sw $ra, ($sp)
    		
		add $t9, $zero, $s0	# $t9 = position to print             
		add $t8, $zero, $zero   # $t8 = loop index
		lw $t6, black
				
		score_while:
			addi $t7, $t8, -768    # index < 640
			beqz $t7, score_done		# exit the loop
			
			sw $t6, 0($t9)		# print black at the position
				
			add $t9, $t9, 4		# $t9 = $t9 + 4
			addi $t8, $t8, 1	# $t8 = $t8 + 1
				
			j score_while			
		score_done:	
		
		lw $ra, ($sp)
    		addi $sp, $sp, 4
    		
		jr $ra
		
# a0 color to print
print_background:
   		addi $sp, $sp, -4
   		sw $ra, ($sp)


		move $t9, $s0	      # $t9 = position to print             
		li $t8, 0            # $t8 = loop index  
				
		background_while:
			addi $t7, $t8, -4096    # index < 4096
			beqz $t7, background_done		# exit the loop
			
			sw $a0, 0($t9)		# print white at the position
				
			add $t9, $t9, 4		# $t9 = $t9 + 4
			addi $t8, $t8, 1	# $t8 = $t8 + 1
				
			j background_while		
		background_done:	
    
    lw $ra, ($sp)
    addi $sp, $sp, 4
    jr $ra
    
    
print_start_interface:
    addi $sp, $sp, -4
    sw $ra, ($sp)

    lw $a0, purple
    jal print_background

    lw $a0, red
    jal print_char_doodlejump

	jal print_doodle

	li $a0, 100
	li $a1, 12800
	jal print_platform

    lw $ra, ($sp)
    addi $sp, $sp, 4
    jr $ra

detect_collision:
	addi $sp, $sp, -4
    sw $ra, ($sp)

    jal detect_collision_rocket
	bne $s3, 0, detect_collision_done
	jal detect_collision_spring
	bne $s3, 0, detect_collision_done
	jal detect_collision_platform
	bne $s3, 0, detect_collision_done
	jal detect_collision_fragile_platform

	detect_collision_done:

    lw $ra, ($sp)
    addi $sp, $sp, 4
    jr $ra

detect_collision_rocket:
	addi $sp, $sp, -4
    sw $ra, ($sp)

	lw $t9, rocket1_active
	bne $t9, 1, no_collision_rocket1

    lw $t9, doodle_y
	lw $t8, rocket1_y
	beq $t9, $t8, rocket1_same_y
	addi $t7, $t8, -256
	beq $t9, $t7, rocket1_same_y
	j no_collision_rocket1

	rocket1_same_y:

	lw $t9, doodle_x
	lw $t8, rocket1_x
	beq $t9, $t8, collision_rocket1
	addi $t7, $t8, 4
	beq $t9, $t7, collision_rocket1
	addi $t7, $t8, 8
	beq $t9, $t7, collision_rocket1
	addi $t7, $t8, -4
	beq $t9, $t7, collision_rocket1
	addi $t7, $t8, -8
	beq $t9, $t7, collision_rocket1
	j no_collision_rocket1


	no_collision_rocket1:

	lw $t9, rocket2_active
	bne $t9, 1, no_collision_rocket2

	lw $t9, doodle_y
	lw $t8, rocket2_y
	beq $t9, $t8, rocket2_same_y
	addi $t7, $t8, -256
	beq $t9, $t7, rocket2_same_y
	j no_collision_rocket2

	rocket2_same_y:

	lw $t9, doodle_x
	lw $t8, rocket2_x
	beq $t9, $t8, collision_rocket2
	addi $t7, $t8, 4
	beq $t9, $t7, collision_rocket2
	addi $t7, $t8, 8
	beq $t9, $t7, collision_rocket2
	addi $t7, $t8, -4
	beq $t9, $t7, collision_rocket2
	addi $t7, $t8, -8
	beq $t9, $t7, collision_rocket2
	j no_collision_rocket2

	no_collision_rocket2:

	lw $t9, rocket3_active
	bne $t9, 1, no_collision_rocket3

	lw $t9, doodle_y
	lw $t8, rocket3_y
	beq $t9, $t8, rocket3_same_y
	addi $t7, $t8, -256
	beq $t9, $t7, rocket3_same_y
	j no_collision_rocket3

	rocket3_same_y:

	lw $t9, doodle_x
	lw $t8, rocket3_x
	beq $t9, $t8, collision_rocket3
	addi $t7, $t8, 4
	beq $t9, $t7, collision_rocket3
	addi $t7, $t8, 8
	beq $t9, $t7, collision_rocket3
	addi $t7, $t8, -4
	beq $t9, $t7, collision_rocket3
	addi $t7, $t8, -8
	beq $t9, $t7, collision_rocket3
	j no_collision_rocket3

	no_collision_rocket3:

	lw $t9, rocket4_active
	bne $t9, 1, no_collision_rocket4

	lw $t9, doodle_y
	lw $t8, rocket4_y
	beq $t9, $t8, rocket4_same_y
	addi $t7, $t8, -256
	beq $t9, $t7, rocket4_same_y
	j no_collision_rocket4

	rocket4_same_y:

	lw $t9, doodle_x
	lw $t8, rocket4_x
	beq $t9, $t8, collision_rocket4
	addi $t7, $t8, 4
	beq $t9, $t7, collision_rocket4
	addi $t7, $t8, 8
	beq $t9, $t7, collision_rocket4
	addi $t7, $t8, -4
	beq $t9, $t7, collision_rocket4
	addi $t7, $t8, -8
	beq $t9, $t7, collision_rocket4
	j no_collision_rocket4

	no_collision_rocket4:

	lw $t9, rocket5_active
	bne $t9, 1, no_collision_rocket5

	lw $t9, doodle_y
	lw $t8, rocket5_y
	beq $t9, $t8, rocket5_same_y
	addi $t7, $t8, -256
	beq $t9, $t7, rocket5_same_y
	j no_collision_rocket5

	rocket5_same_y:

	lw $t9, doodle_x
	lw $t8, rocket5_x
	beq $t9, $t8, collision_rocket5
	addi $t7, $t8, 4
	beq $t9, $t7, collision_rocket5
	addi $t7, $t8, 8
	beq $t9, $t7, collision_rocket5
	addi $t7, $t8, -4
	beq $t9, $t7, collision_rocket5
	addi $t7, $t8, -8
	beq $t9, $t7, collision_rocket5
	j no_collision_rocket5

	no_collision_rocket5:
	j rocket_detect_done

	collision_rocket1:
		li $s3, 7
		j rocket_detect_done

	collision_rocket2:
		li $s3, 8
		j rocket_detect_done

	collision_rocket3:
		li $s3, 9
		j rocket_detect_done

	collision_rocket4:
		li $s3, 10
		j rocket_detect_done

	collision_rocket5:
		li $s3, 11
		j rocket_detect_done

	rocket_detect_done:

    lw $ra, ($sp)
    addi $sp, $sp, 4
    jr $ra

detect_collision_spring:
	addi $sp, $sp, -4
    	sw $ra, ($sp)

	lw $t9, spring1_active
	bne $t9, 1, no_collision_spring1

    	lw $t9, doodle_y
	lw $t8, spring1_y
	addi $t7, $t8, -256
	beq $t9, $t7, spring1_same_y
	j no_collision_spring1

	spring1_same_y:

	lw $t9, doodle_x
	lw $t8, spring1_x
	beq $t9, $t8, collision_spring
	addi $t7, $t8, 12
	beq $t9, $t7, collision_spring
	addi $t7, $t8, -12
	beq $t9, $t7, collision_spring
	addi $t7, $t8, 4
	beq $t9, $t7, collision_spring
	addi $t7, $t8, 8
	beq $t9, $t7, collision_spring
	addi $t7, $t8, -4
	beq $t9, $t7, collision_spring
	addi $t7, $t8, -8
	beq $t9, $t7, collision_spring
	j no_collision_spring1


	no_collision_spring1:

	lw $t9, spring2_active
	bne $t9, 1, no_collision_spring2

    	lw $t9, doodle_y
	lw $t8, spring2_y
	addi $t7, $t8, -256
	beq $t9, $t7, spring2_same_y
	j no_collision_spring2

	spring2_same_y:

	lw $t9, doodle_x
	lw $t8, spring2_x
	beq $t9, $t8, collision_spring
	addi $t7, $t8, 12
	beq $t9, $t7, collision_spring
	addi $t7, $t8, -12
	beq $t9, $t7, collision_spring
	addi $t7, $t8, 4
	beq $t9, $t7, collision_spring
	addi $t7, $t8, 8
	beq $t9, $t7, collision_spring
	addi $t7, $t8, -4
	beq $t9, $t7, collision_spring
	addi $t7, $t8, -8
	beq $t9, $t7, collision_spring
	j no_collision_spring2

	no_collision_spring2:

	lw $t9, spring3_active
	bne $t9, 1, no_collision_spring3

    	lw $t9, doodle_y
	lw $t8, spring3_y
	addi $t7, $t8, -256
	beq $t9, $t7, spring3_same_y
	j no_collision_spring3

	spring3_same_y:

	lw $t9, doodle_x
	lw $t8, spring3_x
	beq $t9, $t8, collision_spring
	addi $t7, $t8, 12
	beq $t9, $t7, collision_spring
	addi $t7, $t8, -12
	beq $t9, $t7, collision_spring
	addi $t7, $t8, 4
	beq $t9, $t7, collision_spring
	addi $t7, $t8, 8
	beq $t9, $t7, collision_spring
	addi $t7, $t8, -4
	beq $t9, $t7, collision_spring
	addi $t7, $t8, -8
	beq $t9, $t7, collision_spring
	j no_collision_spring3

	no_collision_spring3:

	lw $t9, spring4_active
	bne $t9, 1, no_collision_spring4

    	lw $t9, doodle_y
	lw $t8, spring4_y
	addi $t7, $t8, -256
	beq $t9, $t7, spring4_same_y
	j no_collision_spring4

	spring4_same_y:

	lw $t9, doodle_x
	lw $t8, spring4_x
	beq $t9, $t7, collision_spring
	addi $t7, $t8, 4
	beq $t9, $t7, collision_spring
	addi $t7, $t8, 8
	beq $t9, $t7, collision_spring
	addi $t7, $t8, -4
	beq $t9, $t7, collision_spring
	addi $t7, $t8, -8
	beq $t9, $t7, collision_spring
	j no_collision_spring4

	no_collision_spring4:

	lw $t9, spring5_active
	bne $t9, 1, no_collision_spring5

    	lw $t9, doodle_y
	lw $t8, spring5_y
	addi $t7, $t8, -256
	beq $t9, $t7, spring5_same_y
	j no_collision_spring5

	spring5_same_y:

	lw $t9, doodle_x
	lw $t8, spring5_x
	beq $t9, $t8, collision_spring
	addi $t7, $t8, 12
	beq $t9, $t7, collision_spring
	addi $t7, $t8, -12
	beq $t9, $t7, collision_spring
	addi $t7, $t8, 4
	beq $t9, $t7, collision_spring
	addi $t7, $t8, 8
	beq $t9, $t7, collision_spring
	addi $t7, $t8, -4
	beq $t9, $t7, collision_spring
	addi $t7, $t8, -8
	beq $t9, $t7, collision_spring
	j no_collision_spring5

	no_collision_spring5:
	j spring_detect_done

	collision_spring:
		li $s3, 6
		j spring_detect_done

	spring_detect_done:

    	lw $ra, ($sp)
    	addi $sp, $sp, 4
    	jr $ra

detect_collision_platform:
	addi $sp, $sp, -4
   	sw $ra, ($sp)

    	lw $t9, doodle_y
	lw $t8, platform1_y
	addi $t7, $t8, 0
	bne $t9, $t7, no_collision_platform1

	lw $t9, doodle_x
	lw $t8, platform1_x
	beq $t9, $t8, collision_platform1
	addi $t7, $t8, -8
	beq $t9, $t7, collision_platform1
	addi $t7, $t8, -4
	beq $t9, $t7, collision_platform1
	addi $t7, $t8, 4
	beq $t9, $t7, collision_platform1
	addi $t7, $t8, 8
	beq $t9, $t7, collision_platform1
	addi $t7, $t8, 12
	beq $t9, $t7, collision_platform1
	addi $t7, $t8, 16
	beq $t9, $t7, collision_platform1
	addi $t7, $t8, 20
	beq $t9, $t7, collision_platform1
	addi $t7, $t8, 24
	beq $t9, $t7, collision_platform1
	addi $t7, $t8, 28
	beq $t9, $t7, collision_platform1
	addi $t7, $t8, 32
	beq $t9, $t7, collision_platform1
	addi $t7, $t8, 36
	beq $t9, $t7, collision_platform1
	addi $t7, $t8, 40
	beq $t9, $t7, collision_platform1
	addi $t7, $t8, 44
	beq $t9, $t7, collision_platform1
	addi $t7, $t8, 48
	beq $t9, $t7, collision_platform1
	addi $t7, $t8, 52

	no_collision_platform1:

	lw $t9, doodle_y
	lw $t8, platform2_y
	addi $t7, $t8, 0
	bne $t9, $t7, no_collision_platform2

	lw $t9, doodle_x
	lw $t8, platform2_x
	beq $t9, $t8, collision_platform2
	addi $t7, $t8, -8
	beq $t9, $t7, collision_platform2
	addi $t7, $t8, -4
	beq $t9, $t7, collision_platform2
	addi $t7, $t8, 4
	beq $t9, $t7, collision_platform2
	addi $t7, $t8, 8
	beq $t9, $t7, collision_platform2
	addi $t7, $t8, 12
	beq $t9, $t7, collision_platform2
	addi $t7, $t8, 16
	beq $t9, $t7, collision_platform2
	addi $t7, $t8, 20
	beq $t9, $t7, collision_platform2
	addi $t7, $t8, 24
	beq $t9, $t7, collision_platform2
	addi $t7, $t8, 28
	beq $t9, $t7, collision_platform2
	addi $t7, $t8, 32
	beq $t9, $t7, collision_platform2
	addi $t7, $t8, 36
	beq $t9, $t7, collision_platform2
	addi $t7, $t8, 40
	beq $t9, $t7, collision_platform2
	addi $t7, $t8, 44
	beq $t9, $t7, collision_platform2
	addi $t7, $t8, 48
	beq $t9, $t7, collision_platform2
	addi $t7, $t8, 52

	no_collision_platform2:

	lw $t9, doodle_y
	lw $t8, platform3_y
	addi $t7, $t8, 0
	bne $t9, $t7, no_collision_platform3

	lw $t9, doodle_x
	lw $t8, platform3_x
	beq $t9, $t8, collision_platform3
	addi $t7, $t8, -8
	beq $t9, $t7, collision_platform3
	addi $t7, $t8, -4
	beq $t9, $t7, collision_platform3
	addi $t7, $t8, 4
	beq $t9, $t7, collision_platform3
	addi $t7, $t8, 8
	beq $t9, $t7, collision_platform3
	addi $t7, $t8, 12
	beq $t9, $t7, collision_platform3
	addi $t7, $t8, 16
	beq $t9, $t7, collision_platform3
	addi $t7, $t8, 20
	beq $t9, $t7, collision_platform3
	addi $t7, $t8, 24
	beq $t9, $t7, collision_platform3
	addi $t7, $t8, 28
	beq $t9, $t7, collision_platform3
	addi $t7, $t8, 32
	beq $t9, $t7, collision_platform3
	addi $t7, $t8, 36
	beq $t9, $t7, collision_platform3
	addi $t7, $t8, 40
	beq $t9, $t7, collision_platform3
	addi $t7, $t8, 44
	beq $t9, $t7, collision_platform3
	addi $t7, $t8, 48
	beq $t9, $t7, collision_platform3
	addi $t7, $t8, 52

	no_collision_platform3:

	lw $t9, doodle_y
	lw $t8, platform4_y
	addi $t7, $t8, 0
	bne $t9, $t7, no_collision_platform4

	lw $t9, doodle_x
	lw $t8, platform4_x
	beq $t9, $t8, collision_platform4
	addi $t7, $t8, -8
	beq $t9, $t7, collision_platform4
	addi $t7, $t8, -4
	beq $t9, $t7, collision_platform4
	addi $t7, $t8, 4
	beq $t9, $t7, collision_platform4
	addi $t7, $t8, 8
	beq $t9, $t7, collision_platform4
	addi $t7, $t8, 12
	beq $t9, $t7, collision_platform4
	addi $t7, $t8, 16
	beq $t9, $t7, collision_platform4
	addi $t7, $t8, 20
	beq $t9, $t7, collision_platform4
	addi $t7, $t8, 24
	beq $t9, $t7, collision_platform4
	addi $t7, $t8, 28
	beq $t9, $t7, collision_platform4
	addi $t7, $t8, 32
	beq $t9, $t7, collision_platform4
	addi $t7, $t8, 36
	beq $t9, $t7, collision_platform4
	addi $t7, $t8, 40
	beq $t9, $t7, collision_platform4
	addi $t7, $t8, 44
	beq $t9, $t7, collision_platform4
	addi $t7, $t8, 48
	beq $t9, $t7, collision_platform4
	addi $t7, $t8, 52

	no_collision_platform4:

	lw $t9, doodle_y
	lw $t8, platform5_y
	addi $t7, $t8, 0
	bne $t9, $t7, no_collision_platform5

	lw $t9, doodle_x
	lw $t8, platform5_x
	beq $t9, $t8, collision_platform5
	addi $t7, $t8, -8
	beq $t9, $t7, collision_platform5
	addi $t7, $t8, -4
	beq $t9, $t7, collision_platform5
	addi $t7, $t8, 4
	beq $t9, $t7, collision_platform5
	addi $t7, $t8, 8
	beq $t9, $t7, collision_platform5
	addi $t7, $t8, 12
	beq $t9, $t7, collision_platform5
	addi $t7, $t8, 16
	beq $t9, $t7, collision_platform5
	addi $t7, $t8, 20
	beq $t9, $t7, collision_platform5
	addi $t7, $t8, 24
	beq $t9, $t7, collision_platform5
	addi $t7, $t8, 28
	beq $t9, $t7, collision_platform5
	addi $t7, $t8, 32
	beq $t9, $t7, collision_platform5
	addi $t7, $t8, 36
	beq $t9, $t7, collision_platform5
	addi $t7, $t8, 40
	beq $t9, $t7, collision_platform5
	addi $t7, $t8, 44
	beq $t9, $t7, collision_platform5
	addi $t7, $t8, 48
	beq $t9, $t7, collision_platform5
	addi $t7, $t8, 52

	no_collision_platform5:
	j platform_detect_done

	collision_platform1:
		li $s3, 1
		j platform_detect_done

	collision_platform2:
		li $s3, 2
		j platform_detect_done

	collision_platform3:
		li $s3, 3
		j platform_detect_done

	collision_platform4:
		li $s3, 4
		j platform_detect_done

	collision_platform5:
		li $s3, 5
		j platform_detect_done

	platform_detect_done:

    	lw $ra, ($sp)
    	addi $sp, $sp, 4
    	jr $ra

print_1:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 4($t9)
	sw $t8, 260($t9)
	sw $t8, 516($t9)		 
	sw $t8, 772($t9)
	sw $t8, 1028($t9)
	
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_2:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 4($t9)
	sw $t8, 8($t9)
	sw $t8, 264($t9)
	sw $t8, 520($t9)		 
	sw $t8, 516($t9)
	sw $t8, 512($t9)
	sw $t8, 768($t9)
	sw $t8, 1024($t9)
	sw $t8, 1028($t9)
	sw $t8, 1032($t9)
	
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
	jr $ra

print_3:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 4($t9)
	sw $t8, 8($t9)
	sw $t8, 264($t9)
	sw $t8, 520($t9)		 
	sw $t8, 516($t9)
	sw $t8, 512($t9)
	sw $t8, 776($t9)
	sw $t8, 1024($t9)
	sw $t8, 1028($t9)
	sw $t8, 1032($t9)
	
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_4:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 256($t9)
	sw $t8, 512($t9)
	sw $t8, 516($t9)
	sw $t8, 520($t9)		 
	sw $t8, 264($t9)
	sw $t8, 8($t9)
	sw $t8, 776($t9)
	sw $t8, 1032($t9)
	
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_5:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 4($t9)
	sw $t8, 8($t9)
	sw $t8, 256($t9)
	sw $t8, 512($t9)		 
	sw $t8, 516($t9)
	sw $t8, 520($t9)
	sw $t8, 776($t9)
	sw $t8, 1032($t9)
	sw $t8, 1028($t9)
	sw $t8, 1024($t9)

	
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_6:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 4($t9)
	sw $t8, 8($t9)
	sw $t8, 256($t9)
	sw $t8, 512($t9)		 
	sw $t8, 516($t9)
	sw $t8, 520($t9)
	sw $t8, 776($t9)
	sw $t8, 768($t9)
	sw $t8, 1032($t9)
	sw $t8, 1028($t9)
	sw $t8, 1024($t9)

	
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_7:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 4($t9)
	sw $t8, 8($t9)
	sw $t8, 256($t9)
	sw $t8, 264($t9)
	sw $t8, 520($t9)
	sw $t8, 776($t9)
	sw $t8, 1032($t9)

	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_8:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 4($t9)
	sw $t8, 8($t9)
	sw $t8, 256($t9)
	sw $t8, 264($t9)
	sw $t8, 512($t9)		 
	sw $t8, 516($t9)
	sw $t8, 520($t9)
	sw $t8, 776($t9)
	sw $t8, 768($t9)
	sw $t8, 1032($t9)
	sw $t8, 1028($t9)
	sw $t8, 1024($t9)

	
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_9:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 4($t9)
	sw $t8, 8($t9)
	sw $t8, 256($t9)
	sw $t8, 264($t9)
	sw $t8, 512($t9)		 
	sw $t8, 516($t9)
	sw $t8, 520($t9)
	sw $t8, 776($t9)
	sw $t8, 1032($t9)
	sw $t8, 1028($t9)
	sw $t8, 1024($t9)

	
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_0:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 4($t9)
	sw $t8, 8($t9)
	sw $t8, 256($t9)
	sw $t8, 264($t9)
	sw $t8, 512($t9)		 
	sw $t8, 520($t9)
	sw $t8, 776($t9)
	sw $t8, 768($t9)
	sw $t8, 1032($t9)
	sw $t8, 1028($t9)
	sw $t8, 1024($t9)

	
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

increase_difficulty:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	la $t9, difficulty
	lw $t8, 0($t9)
	addi $t8, $t8, 1
	sw $t8, 0($t9)

	la $t9, score_3
	lw $t8, 0($t9)
	addi $t8, $t8, 1
	beq $t8, 10, increase_score_2
	sw $t8, 0($t9)
	j increase_difficulty_done

	increase_score_2:
		sw $zero, 0($t9)
		la $t9, score_2
		lw $t8, 0($t9)
		addi $t8, $t8, 1
		beq $t8, 10, increase_score_3
		sw $t8, 0($t9)
		j increase_difficulty_done

	increase_score_3:
		sw $zero, 0($t9)
		la $t9, score_1
		lw $t8, 0($t9)
		addi $t8, $t8, 1
		sw $t8, 0($t9)

	increase_difficulty_done:
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

update_score:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	jal initialize_score_board

	lw $t9, score_1
	li $a0, 20
	li $a1, 768
	beq $t9, 0, a_print_0
	beq $t9, 1, a_print_1
	beq $t9, 2, a_print_2
	beq $t9, 3, a_print_3
	beq $t9, 4, a_print_4
	beq $t9, 5, a_print_5
	beq $t9, 6, a_print_6
	beq $t9, 7, a_print_7
	beq $t9, 8, a_print_8
	beq $t9, 9, a_print_9

	a_print_0:
		jal print_0
		j a_print_done

	a_print_1:
		jal print_1
		j a_print_done

	a_print_2:
		jal print_2
		j a_print_done

	a_print_3:
		jal print_3
		j a_print_done

	a_print_4:
		jal print_4
		j a_print_done

	a_print_5:
		jal print_5
		j a_print_done

	a_print_6:
		jal print_6
		j a_print_done

	a_print_7:
		jal print_7
		j a_print_done

	a_print_8:
		jal print_8
		j a_print_done

	a_print_9:
		jal print_9
		j a_print_done

	a_print_done:

	lw $t9, score_2
	li $a0, 40
	li $a1, 768
	beq $t9, 0, b_print_0
	beq $t9, 1, b_print_1
	beq $t9, 2, b_print_2
	beq $t9, 3, b_print_3
	beq $t9, 4, b_print_4
	beq $t9, 5, b_print_5
	beq $t9, 6, b_print_6
	beq $t9, 7, b_print_7
	beq $t9, 8, b_print_8
	beq $t9, 9, b_print_9

	b_print_0:
		jal print_0
		j b_print_done

	b_print_1:
		jal print_1
		j b_print_done

	b_print_2:
		jal print_2
		j b_print_done

	b_print_3:
		jal print_3
		j b_print_done

	b_print_4:
		jal print_4
		j b_print_done

	b_print_5:
		jal print_5
		j b_print_done

	b_print_6:
		jal print_6
		j b_print_done

	b_print_7:
		jal print_7
		j b_print_done

	b_print_8:
		jal print_8
		j b_print_done

	b_print_9:
		jal print_9
		j b_print_done

	b_print_done:

	lw $t9, score_3
	li $a0, 60
	li $a1, 768
	beq $t9, 0, c_print_0
	beq $t9, 1, c_print_1
	beq $t9, 2, c_print_2
	beq $t9, 3, c_print_3
	beq $t9, 4, c_print_4
	beq $t9, 5, c_print_5
	beq $t9, 6, c_print_6
	beq $t9, 7, c_print_7
	beq $t9, 8, c_print_8
	beq $t9, 9, c_print_9

	c_print_0:
		jal print_0
		j c_print_done

	c_print_1:
		jal print_1
		j c_print_done

	c_print_2:
		jal print_2
		j c_print_done

	c_print_3:
		jal print_3
		j c_print_done

	c_print_4:
		jal print_4
		j c_print_done

	c_print_5:
		jal print_5
		j c_print_done

	c_print_6:
		jal print_6
		j c_print_done

	c_print_7:
		jal print_7
		j c_print_done

	c_print_8:
		jal print_8
		j c_print_done

	c_print_9:
		jal print_9
		j c_print_done

	c_print_done:
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_w:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 8($t9)
	sw $t8, 256($t9)
	sw $t8, 264($t9)
	sw $t8, 512($t9)		 
	sw $t8, 520($t9)
	sw $t8, 776($t9)
	sw $t8, 768($t9)
	sw $t8, 1032($t9)
	sw $t8, 772($t9)
	sw $t8, 1024($t9)
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_o:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)
	sw $t8, 4($t9)		 
	sw $t8, 8($t9)
	sw $t8, 256($t9)
	sw $t8, 264($t9)
	sw $t8, 512($t9)		 
	sw $t8, 520($t9)
	sw $t8, 776($t9)
	sw $t8, 768($t9)
	sw $t8, 1032($t9)
	sw $t8, 1028($t9)
	sw $t8, 1024($t9)
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_p:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)
	sw $t8, 4($t9)		 
	sw $t8, 8($t9)
	sw $t8, 256($t9)
	sw $t8, 264($t9)
	sw $t8, 512($t9)	
	sw $t8, 516($t9)	 
	sw $t8, 520($t9)
	sw $t8, 768($t9)
	sw $t8, 1024($t9)
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_g:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 4($t9)
	sw $t8, 8($t9)
	sw $t8, 256($t9)
	sw $t8, 512($t9)		 
	sw $t8, 520($t9)
	sw $t8, 776($t9)
	sw $t8, 768($t9)
	sw $t8, 1032($t9)
	sw $t8, 1028($t9)
	sw $t8, 1024($t9)
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_e:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 4($t9)
	sw $t8, 8($t9)
	sw $t8, 256($t9)
	sw $t8, 512($t9)		 
	sw $t8, 516($t9)
	sw $t8, 520($t9)
	sw $t8, 768($t9)
	sw $t8, 1032($t9)
	sw $t8, 1028($t9)
	sw $t8, 1024($t9)

	
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_r:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)
	sw $t8, 4($t9)		 
	sw $t8, 8($t9)
	sw $t8, 256($t9)
	sw $t8, 264($t9)
	sw $t8, 512($t9)	
	sw $t8, 516($t9)	 
	sw $t8, 520($t9)
	sw $t8, 768($t9)
	sw $t8, 772($t9)
	sw $t8, 1024($t9)
	sw $t8, 1032($t9)
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_s:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 4($t9)
	sw $t8, 8($t9)
	sw $t8, 256($t9)
	sw $t8, 512($t9)		 
	sw $t8, 516($t9)
	sw $t8, 520($t9)
	sw $t8, 776($t9)
	sw $t8, 1032($t9)
	sw $t8, 1028($t9)
	sw $t8, 1024($t9)

	
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_pause_interface:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	li $a0, 80
	li $a1, 7680
	jal print_p

	li $a0, 100
	li $a1, 7680
	jal print_a

	li $a0, 120
	li $a1, 7680
	jal print_u

	li $a0, 140
	li $a1, 7680
	jal print_s

	li $a0, 160
	li $a1, 7680
	jal print_e
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_a:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 4($t9)
	sw $t8, 8($t9)
	sw $t8, 256($t9)
	sw $t8, 264($t9)
	sw $t8, 512($t9)		 
	sw $t8, 516($t9)
	sw $t8, 520($t9)
	sw $t8, 776($t9)
	sw $t8, 768($t9)
	sw $t8, 1032($t9)
	sw $t8, 1024($t9)

	
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_u:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 8($t9)
	sw $t8, 256($t9)
	sw $t8, 264($t9)
	sw $t8, 512($t9)		 
	sw $t8, 520($t9)
	sw $t8, 776($t9)
	sw $t8, 768($t9)
	sw $t8, 1032($t9)
	sw $t8, 1028($t9)
	sw $t8, 1024($t9)

	
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_end_interface:
	addi $sp, $sp, -4
    	sw $ra, ($sp)

	lw $a0, purple
	jal print_background

	li $a0, 92
	li $a1, 8960
	jal print_g

	li $a0, 112
	li $a1, 8960
	jal print_a

	li $a0, 132
	li $a1, 8960
	jal print_m

	li $a0, 152
	li $a1, 8960
	jal print_e

	li $a0, 92
	li $a1, 10752
	jal print_o

	li $a0, 112
	li $a1, 10752
	jal print_v

	li $a0, 132
	li $a1, 10752
	jal print_e

	li $a0, 152
	li $a1, 10752
	jal print_r



	lw $t9, score_1
	li $a0, 100
	li $a1, 5120
	beq $t9, 0, d_print_0
	beq $t9, 1, d_print_1
	beq $t9, 2, d_print_2
	beq $t9, 3, d_print_3
	beq $t9, 4, d_print_4
	beq $t9, 5, d_print_5
	beq $t9, 6, d_print_6
	beq $t9, 7, d_print_7
	beq $t9, 8, d_print_8
	beq $t9, 9, d_print_9

	d_print_0:
		jal print_0
		j d_print_done

	d_print_1:
		jal print_1
		j d_print_done

	d_print_2:
		jal print_2
		j d_print_done

	d_print_3:
		jal print_3
		j d_print_done

	d_print_4:
		jal print_4
		j d_print_done

	d_print_5:
		jal print_5
		j d_print_done

	d_print_6:
		jal print_6
		j d_print_done

	d_print_7:
		jal print_7
		j d_print_done

	d_print_8:
		jal print_8
		j d_print_done

	d_print_9:
		jal print_9
		j d_print_done

	d_print_done:

	lw $t9, score_2
	li $a0, 120
	li $a1, 5120
	beq $t9, 0, e_print_0
	beq $t9, 1, e_print_1
	beq $t9, 2, e_print_2
	beq $t9, 3, e_print_3
	beq $t9, 4, e_print_4
	beq $t9, 5, e_print_5
	beq $t9, 6, e_print_6
	beq $t9, 7, e_print_7
	beq $t9, 8, e_print_8
	beq $t9, 9, e_print_9

	e_print_0:
		jal print_0
		j e_print_done

	e_print_1:
		jal print_1
		j e_print_done

	e_print_2:
		jal print_2
		j e_print_done

	e_print_3:
		jal print_3
		j e_print_done

	e_print_4:
		jal print_4
		j e_print_done

	e_print_5:
		jal print_5
		j e_print_done

	e_print_6:
		jal print_6
		j e_print_done

	e_print_7:
		jal print_7
		j e_print_done

	e_print_8:
		jal print_8
		j e_print_done

	e_print_9:
		jal print_9
		j e_print_done

	e_print_done:

	lw $t9, score_3
	li $a0, 140
	li $a1, 5120
	beq $t9, 0, f_print_0
	beq $t9, 1, f_print_1
	beq $t9, 2, f_print_2
	beq $t9, 3, f_print_3
	beq $t9, 4, f_print_4
	beq $t9, 5, f_print_5
	beq $t9, 6, f_print_6
	beq $t9, 7, f_print_7
	beq $t9, 8, f_print_8
	beq $t9, 9, f_print_9

	f_print_0:
		jal print_0
		j f_print_done

	f_print_1:
		jal print_1
		j f_print_done

	f_print_2:
		jal print_2
		j f_print_done

	f_print_3:
		jal print_3
		j f_print_done

	f_print_4:
		jal print_4
		j f_print_done

	f_print_5:
		jal print_5
		j c_print_done

	f_print_6:
		jal print_6
		j f_print_done

	f_print_7:
		jal print_7
		j f_print_done

	f_print_8:
		jal print_8
		j f_print_done

	f_print_9:
		jal print_9
		j f_print_done

	f_print_done:
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra


print_m:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 8($t9)
	sw $t8, 256($t9)
	sw $t8, 260($t9)
	sw $t8, 264($t9)
	sw $t8, 512($t9)		 
	sw $t8, 520($t9)
	sw $t8, 776($t9)
	sw $t8, 768($t9)
	sw $t8, 1032($t9)
	sw $t8, 1024($t9)

	
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_v:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	add $t9, $a0, $a1  	 
	add $t9, $t9, $s0
	
	lw $t8, red
	sw $t8, 0($t9)		 
	sw $t8, 8($t9)
	sw $t8, 256($t9)
	sw $t8, 264($t9)
	sw $t8, 512($t9)		 
	sw $t8, 520($t9)
	sw $t8, 776($t9)
	sw $t8, 768($t9)
	sw $t8, 1028($t9)
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

reset_the_game:
	addi $sp, $sp, -4
    	sw $ra, ($sp)
	
	la $t9, rocket1_active
	sw $zero, 0($t9)

	la $t9, rocket2_active
	sw $zero, 0($t9)

	la $t9, rocket3_active
	sw $zero, 0($t9)

	la $t9, rocket4_active
	sw $zero, 0($t9)

	la $t9, rocket5_active
	sw $zero, 0($t9)

	la $t9, spring1_active
	sw $zero, 0($t9)

	la $t9, spring2_active
	sw $zero, 0($t9)

	la $t9, spring3_active
	sw $zero, 0($t9)

	la $t9, spring4_active
	sw $zero, 0($t9)

	la $t9, spring5_active
	sw $zero, 0($t9)

	la $t9, score_1
	sw $zero, 0($t9)

	la $t9, score_2
	sw $zero, 0($t9)

	la $t9, score_3
	sw $zero, 0($t9)

	la $t9, difficulty
	sw $zero, 0($t9)
	
	lw $ra, ($sp)
    	addi $sp, $sp, 4
    		
	jr $ra

print_fragile_platform:
		addi $sp, $sp, -4
    		sw $ra, ($sp)
	
		add $t9, $a0, $a1	
		add $t9, $t9, $s0
		
		lw $t8, brown
		sw $t8, 0($t9)           
		sw $t8, 4($t9)
		sw $t8, 8($t9)
		sw $t8, 12($t9)
		sw $t8, 16($t9)

		lw $t8, brown2
		sw $t8, 20($t9)
		sw $t8, 24($t9)
		sw $t8, 28($t9)
		sw $t8, 32($t9)
		sw $t8, 36($t9)
		sw $t8, 40($t9)
		
		lw $ra, ($sp)
    		addi $sp, $sp, 4
		jr $ra

erase_fragile_platform:
		addi $sp, $sp, -4
    	sw $ra, ($sp)
	
		add $t9, $a0, $a1	
		add $t9, $t9, $s0

		lw $t8, light_yellow
		sw $t8, 0($t9)           
		sw $t8, 4($t9)
		sw $t8, 8($t9)
		sw $t8, 12($t9)
		sw $t8, 16($t9)
		sw $t8, 20($t9)
		sw $t8, 24($t9)
		sw $t8, 28($t9)
		sw $t8, 32($t9)
		sw $t8, 36($t9)
		sw $t8, 40($t9)
		
		lw $ra, ($sp)
    		addi $sp, $sp, 4
		jr $ra

initialize_5_fragile_platforms:
		addi $sp, $sp, -4
    		sw $ra, ($sp)
		
		
		# 1st platform
		li $v0, 42                # $a0 = a random number 0-31
		li $a0, 0
		li $a1, 54
		syscall
		
		sll $a0, $a0, 2	         # $a0 = a random number 0-124 (increment by 4)
		
		la $t9, fragile_platform1_x
		sw $a0, 0($t9)
		
		
		# 2ed platform
		li $v0, 42                # $a0 = a random number 0-31
		li $a0, 0
		li $a1, 54
		syscall
		
		sll $a0, $a0, 2	         # $a0 = a random number 0-124 (increment by 4)
		
		add $t1, $a0, $zero      # $t1= the initial position of the 2ed platform
	
		la $t9, fragile_platform2_x
		sw $a0, 0($t9)
		
		# 3rd platform
		li $v0, 42                # $a0 = a random number 0-31
		li $a0, 0
		li $a1, 54
		syscall
		
		sll $a0, $a0, 2	         # $a0 = a random number 0-124 (increment by 4)
		
		add $t2, $a0, $zero      # $t2 = the initial position of the 3rd platform
	
		la $t9, fragile_platform3_x
		sw $a0, 0($t9)
		
		# 4th platform
		li $v0, 42                # $a0 = a random number 0-31
		li $a0, 0
		li $a1, 54
		syscall
		
		sll $a0, $a0, 2	         # $a0 = a random number 0-124 (increment by 4)
		
		add $t3, $a0, $zero      # $t3 = the initial position of the 4th platform
	
		la $t9, fragile_platform4_x
		sw $a0, 0($t9)
		
		# 5th platform
		li $v0, 42                # $a0 = a random number 0-31
		li $a0, 0
		li $a1, 54
		syscall
		
		sll $a0, $a0, 2	         # $a0 = a random number 0-124 (increment by 4)
		
		add $t4, $a0, $zero      # $t4 = the initial position of the 5th platform
	
		la $t9, fragile_platform5_x
		sw $a0, 0($t9)
		
		# print 5 platforms
		la $t9, fragile_platform1_x
		lw $a0, 0($t9)
	
		la $t9, fragile_platform1_y
		lw $a1, 0($t9)
	
		jal print_fragile_platform
		
		la $t9, fragile_platform2_x
		lw $a0, 0($t9)
	
		la $t9, fragile_platform2_y
		lw $a1, 0($t9)
	
		jal print_fragile_platform
		
		la $t9, fragile_platform3_x
		lw $a0, 0($t9)
	
		la $t9, fragile_platform3_y
		lw $a1, 0($t9)
	
		jal print_fragile_platform
		
		la $t9, fragile_platform4_x
		lw $a0, 0($t9)
	
		la $t9, fragile_platform4_y
		lw $a1, 0($t9)
	
		jal print_fragile_platform
		
		la $t9, fragile_platform5_x
		lw $a0, 0($t9)
	
		la $t9, fragile_platform5_y
		lw $a1, 0($t9)
	
		jal print_fragile_platform
		
		
		lw $ra, ($sp)
    		addi $sp, $sp, 4
    		
		jr $ra

update_new_fragile_platform:
	addi $sp, $sp, -4
	sw $ra, ($sp)

	li $v0, 42                # $a0 = a random number 0-31
	li $a0, 0
	li $a1, 54
	syscall
		
	sll $a0, $a0, 2

	la $t9, fragile_platform1_x
	sw $a0, 0($t9)

	la $t9, fragile_platform1_y
	li $t8, 3328
	sw $t8, 0($t9)

	lw $a0, fragile_platform1_x
	lw $a1, fragile_platform1_y
	jal print_fragile_platform

	la $t9, fragile_platform1_active
	li $t8, 1
	sw $t8, 0($t9)

	lw $ra, ($sp)
    	addi $sp, $sp, 4
	jr $ra

reframe_fragile_platform:
		addi $sp, $sp, -4
		sw $ra, ($sp)


		lw $t9, fragile_platform1_active
		beqz $t9, not_reframe_fragile_platform1
		lw $a0, fragile_platform1_x
		lw $a1, fragile_platform1_y
		jal erase_fragile_platform
		not_reframe_fragile_platform1:

		lw $t9, fragile_platform2_active
		beqz $t9, not_reframe_fragile_platform2
		lw $a0, fragile_platform2_x
		lw $a1, fragile_platform2_y
		jal erase_fragile_platform
		not_reframe_fragile_platform2:

		lw $t9, fragile_platform3_active
		beqz $t9, not_reframe_fragile_platform3
		lw $a0, fragile_platform3_x
		lw $a1, fragile_platform3_y
		jal erase_fragile_platform
		not_reframe_fragile_platform3:

		lw $t9, fragile_platform4_active
		beqz $t9, not_reframe_fragile_platform4
		lw $a0, fragile_platform4_x
		lw $a1, fragile_platform4_y
		jal erase_fragile_platform
		not_reframe_fragile_platform4:

		
		la $t9, fragile_platform1_y
		lw $t8 0($t9)
		addi $t8, $t8, 256
		sw $t8, 0($t9)

		la $t9, fragile_platform2_y
		lw $t8 0($t9)
		addi $t8, $t8, 256
		sw $t8, 0($t9)

		la $t9, fragile_platform3_y
		lw $t8 0($t9)
		addi $t8, $t8, 256
		sw $t8, 0($t9)

		la $t9, fragile_platform4_y
		lw $t8 0($t9)
		addi $t8, $t8, 256
		sw $t8, 0($t9)

		lw $t9, fragile_platform1_active
		beqz $t9, not_reframe2_fragile_platform1
		lw $a0, fragile_platform1_x
		lw $a1, fragile_platform1_y
		jal print_fragile_platform
		not_reframe2_fragile_platform1:

		lw $t9, fragile_platform2_active
		beqz $t9, not_reframe2_fragile_platform2
		lw $a0, fragile_platform2_x
		lw $a1, fragile_platform2_y
		jal print_fragile_platform
		not_reframe2_fragile_platform2:

		lw $t9, fragile_platform3_active
		beqz $t9, not_reframe2_fragile_platform3
		lw $a0, fragile_platform3_x
		lw $a1, fragile_platform3_y
		jal print_fragile_platform
		not_reframe2_fragile_platform3:

		lw $t9, fragile_platform4_active
		beqz $t9, not_reframe2_fragile_platform4
		lw $a0, fragile_platform4_x
		lw $a1, fragile_platform4_y
		jal print_fragile_platform
		not_reframe2_fragile_platform4:

		lw $ra, ($sp)
    		addi $sp, $sp, 4
		jr $ra

detect_collision_fragile_platform:
	addi $sp, $sp, -4
   	sw $ra, ($sp)

	lw $t9, fragile_platform1_active
	beqz $t9, no_collision_fragile_platform1
    lw $t9, doodle_y
	lw $t8, fragile_platform1_y
	addi $t7, $t8, -256
	bne $t9, $t7, no_collision_fragile_platform1

	lw $t9, doodle_x
	lw $t8, fragile_platform1_x
	beq $t9, $t8, collision_fragile_platform1
	addi $t7, $t8, -8
	beq $t9, $t7, collision_fragile_platform1
	addi $t7, $t8, -4
	beq $t9, $t7, collision_fragile_platform1
	addi $t7, $t8, 4
	beq $t9, $t7, collision_fragile_platform1
	addi $t7, $t8, 8
	beq $t9, $t7, collision_fragile_platform1
	addi $t7, $t8, 12
	beq $t9, $t7, collision_fragile_platform1
	addi $t7, $t8, 16
	beq $t9, $t7, collision_fragile_platform1
	addi $t7, $t8, 20
	beq $t9, $t7, collision_fragile_platform1
	addi $t7, $t8, 24
	beq $t9, $t7, collision_fragile_platform1
	addi $t7, $t8, 28
	beq $t9, $t7, collision_fragile_platform1
	addi $t7, $t8, 32
	beq $t9, $t7, collision_fragile_platform1
	addi $t7, $t8, 36
	beq $t9, $t7, collision_fragile_platform1
	addi $t7, $t8, 40
	beq $t9, $t7, collision_fragile_platform1
	addi $t7, $t8, 44
	beq $t9, $t7, collision_fragile_platform1
	addi $t7, $t8, 48
	beq $t9, $t7, collision_fragile_platform1
	addi $t7, $t8, 52

	no_collision_fragile_platform1:

	lw $t9, fragile_platform2_active
	beqz $t9, no_collision_fragile_platform2
	lw $t9, doodle_y
	lw $t8, fragile_platform2_y
	addi $t7, $t8, -256
	bne $t9, $t7, no_collision_fragile_platform2

	lw $t9, doodle_x
	lw $t8, fragile_platform2_x
	beq $t9, $t8, collision_fragile_platform2
	addi $t7, $t8, -8
	beq $t9, $t7, collision_fragile_platform2
	addi $t7, $t8, -4
	beq $t9, $t7, collision_fragile_platform2
	addi $t7, $t8, 4
	beq $t9, $t7, collision_fragile_platform2
	addi $t7, $t8, 8
	beq $t9, $t7, collision_fragile_platform2
	addi $t7, $t8, 12
	beq $t9, $t7, collision_fragile_platform2
	addi $t7, $t8, 16
	beq $t9, $t7, collision_fragile_platform2
	addi $t7, $t8, 20
	beq $t9, $t7, collision_fragile_platform2
	addi $t7, $t8, 24
	beq $t9, $t7, collision_fragile_platform2
	addi $t7, $t8, 28
	beq $t9, $t7, collision_fragile_platform2
	addi $t7, $t8, 32
	beq $t9, $t7, collision_fragile_platform2
	addi $t7, $t8, 36
	beq $t9, $t7, collision_fragile_platform2
	addi $t7, $t8, 40
	beq $t9, $t7, collision_fragile_platform2
	addi $t7, $t8, 44
	beq $t9, $t7, collision_fragile_platform2
	addi $t7, $t8, 48
	beq $t9, $t7, collision_fragile_platform2
	addi $t7, $t8, 52

	no_collision_fragile_platform2:

	lw $t9, fragile_platform3_active
	beqz $t9, no_collision_fragile_platform3
	lw $t9, doodle_y
	lw $t8, fragile_platform3_y
	addi $t7, $t8, -256
	bne $t9, $t7, no_collision_fragile_platform3

	lw $t9, doodle_x
	lw $t8, fragile_platform3_x
	beq $t9, $t8, collision_fragile_platform3
	addi $t7, $t8, -8
	beq $t9, $t7, collision_fragile_platform3
	addi $t7, $t8, -4
	beq $t9, $t7, collision_fragile_platform3
	addi $t7, $t8, 4
	beq $t9, $t7, collision_fragile_platform3
	addi $t7, $t8, 8
	beq $t9, $t7, collision_fragile_platform3
	addi $t7, $t8, 12
	beq $t9, $t7, collision_fragile_platform3
	addi $t7, $t8, 16
	beq $t9, $t7, collision_fragile_platform3
	addi $t7, $t8, 20
	beq $t9, $t7, collision_fragile_platform3
	addi $t7, $t8, 24
	beq $t9, $t7, collision_fragile_platform3
	addi $t7, $t8, 28
	beq $t9, $t7, collision_fragile_platform3
	addi $t7, $t8, 32
	beq $t9, $t7, collision_fragile_platform3
	addi $t7, $t8, 36
	beq $t9, $t7, collision_fragile_platform3
	addi $t7, $t8, 40
	beq $t9, $t7, collision_fragile_platform3
	addi $t7, $t8, 44
	beq $t9, $t7, collision_fragile_platform3
	addi $t7, $t8, 48
	beq $t9, $t7, collision_fragile_platform3
	addi $t7, $t8, 52

	no_collision_fragile_platform3:

	lw $t9, fragile_platform4_active
	beqz $t9, no_collision_fragile_platform4
	lw $t9, doodle_y
	lw $t8, fragile_platform4_y
	addi $t7, $t8, -256
	bne $t9, $t7, no_collision_fragile_platform4

	lw $t9, doodle_x
	lw $t8, fragile_platform4_x
	beq $t9, $t8, collision_fragile_platform4
	addi $t7, $t8, -8
	beq $t9, $t7, collision_fragile_platform4
	addi $t7, $t8, -4
	beq $t9, $t7, collision_fragile_platform4
	addi $t7, $t8, 4
	beq $t9, $t7, collision_fragile_platform4
	addi $t7, $t8, 8
	beq $t9, $t7, collision_fragile_platform4
	addi $t7, $t8, 12
	beq $t9, $t7, collision_fragile_platform4
	addi $t7, $t8, 16
	beq $t9, $t7, collision_fragile_platform4
	addi $t7, $t8, 20
	beq $t9, $t7, collision_fragile_platform4
	addi $t7, $t8, 24
	beq $t9, $t7, collision_fragile_platform4
	addi $t7, $t8, 28
	beq $t9, $t7, collision_fragile_platform4
	addi $t7, $t8, 32
	beq $t9, $t7, collision_fragile_platform4
	addi $t7, $t8, 36
	beq $t9, $t7, collision_fragile_platform4
	addi $t7, $t8, 40
	beq $t9, $t7, collision_fragile_platform4
	addi $t7, $t8, 44
	beq $t9, $t7, collision_fragile_platform4
	addi $t7, $t8, 48
	beq $t9, $t7, collision_fragile_platform4
	addi $t7, $t8, 52

	no_collision_fragile_platform4:

	lw $t9, fragile_platform5_active
	beqz $t9, no_collision_fragile_platform5
	lw $t9, doodle_y
	lw $t8, fragile_platform5_y
	addi $t7, $t8, -256
	bne $t9, $t7, no_collision_fragile_platform5

	lw $t9, doodle_x
	lw $t8, fragile_platform5_x
	beq $t9, $t8, collision_fragile_platform5
	addi $t7, $t8, -8
	beq $t9, $t7, collision_fragile_platform5
	addi $t7, $t8, -4
	beq $t9, $t7, collision_fragile_platform5
	addi $t7, $t8, 4
	beq $t9, $t7, collision_fragile_platform5
	addi $t7, $t8, 8
	beq $t9, $t7, collision_fragile_platform5
	addi $t7, $t8, 12
	beq $t9, $t7, collision_fragile_platform5
	addi $t7, $t8, 16
	beq $t9, $t7, collision_fragile_platform5
	addi $t7, $t8, 20
	beq $t9, $t7, collision_fragile_platform5
	addi $t7, $t8, 24
	beq $t9, $t7, collision_fragile_platform5
	addi $t7, $t8, 28
	beq $t9, $t7, collision_fragile_platform5
	addi $t7, $t8, 32
	beq $t9, $t7, collision_fragile_platform5
	addi $t7, $t8, 36
	beq $t9, $t7, collision_fragile_platform5
	addi $t7, $t8, 40
	beq $t9, $t7, collision_fragile_platform5
	addi $t7, $t8, 44
	beq $t9, $t7, collision_fragile_platform5
	addi $t7, $t8, 48
	beq $t9, $t7, collision_fragile_platform5
	addi $t7, $t8, 52

	no_collision_fragile_platform5:
	j fragile_platform_detect_done

	collision_fragile_platform1:
		li $s3, 12
		j platform_detect_done

	collision_fragile_platform2:
		li $s3, 13
		j platform_detect_done

	collision_fragile_platform3:
		li $s3, 14
		j platform_detect_done

	collision_fragile_platform4:
		li $s3, 15
		j platform_detect_done

	collision_fragile_platform5:
		li $s3, 16
		j platform_detect_done

	fragile_platform_detect_done:

    	lw $ra, ($sp)
    	addi $sp, $sp, 4
    	jr $ra

crash_fragile_platform:
		addi $sp, $sp, -4
    	sw $ra, ($sp)
	
		add $t9, $a0, $a1	
		add $t9, $t9, $s0

		lw $t8, light_yellow
		sw $t8, 0($t9)           
		sw $t8, 4($t9)
		sw $t8, 8($t9)
		sw $t8, 12($t9)
		sw $t8, 16($t9)
		sw $t8, 20($t9)
		sw $t8, 24($t9)
		sw $t8, 28($t9)
		sw $t8, 32($t9)
		sw $t8, 36($t9)
		sw $t8, 40($t9)

		lw $t8, brown
		sw $t8, 0($t9)           
		sw $t8, 260($t9)
		sw $t8, 520($t9)
		sw $t8, 524($t9)

		lw $t8, black
		sw $t8, 784($t9)
		sw $t8, 532($t9)
		sw $t8, 280($t9)

		lw $t8, brown2
		sw $t8, 28($t9)
		sw $t8, 32($t9)
		sw $t8, 36($t9)
		sw $t8, 40($t9)

		li $v0, 32
		li $a0, 20
		syscall

		lw $t8, light_yellow
		sw $t8, 0($t9)           
		sw $t8, 260($t9)
		sw $t8, 520($t9)
		sw $t8, 524($t9)
		sw $t8, 784($t9)
		sw $t8, 532($t9)
		sw $t8, 280($t9)
		sw $t8, 28($t9)
		sw $t8, 32($t9)
		sw $t8, 36($t9)
		sw $t8, 40($t9)

		lw $ra, ($sp)
    	addi $sp, $sp, 4
    	jr $ra

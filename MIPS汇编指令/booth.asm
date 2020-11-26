.text
_start:
	addi	$2, $2, 2	# $2 <- 2
	addi	$3, $3, 5	# $3 <- 4
	addiu	$4, $4, 0	# $4 <- 0
	addiu	$11, $11, 31	# $11 <- 31
	sll	$3, $3, 1
	
label1:	beq	$4, $11, label4	# if($4==31)
	sub	$7, $7, $7	# $7 <- 0
	andi	$7, $3, 1	# $7 <- $3&1
	sub	$6, $6, $6	# $6 <- 0
	sra	$3, $3, 1	# $3 <- $3>>1
	andi	$6, $3, 1	# $6 <- $3&1
	sllv	$12, $2, $4
	addiu	$4, $4, 1	# $4++
	beq	$6, $7, label1	# if($6==$7)
	slt	$8, $6, $7
	addiu	$13, $13, 0
	bne	$13, $8, label2	# if($7>$6)
	beq	$13, $8, label3	# if($7<$6)
	
label2: add	$9, $9, $12
	j	label1
	
label3: sub	$9, $9, $12
	j	label1

label4:
		


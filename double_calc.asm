
.data
	prompt: .asciiz "\nWprowadz pierwsza liczbe: "
	operations: .asciiz "Wybierz dzialanie: \n\n Dodawanie: 0  Odejmowanie: 1  Mnozenie: 2  Dzielenie: 3 "
	prompt2: .asciiz "\nWprowadz druga liczbe: "
	result: .asciiz "\nWynik: "
	number1: .asciiz "\nPierwsza liczba: "
	operation: .asciiz "\nDzialanie: "
	number2: .asciiz "\nDruga liczba: "
	ifContinue: .asciiz "\n\nCzy chcesz kontynuowac? Nie: 0  Tak: 1\n”
	
.text

	main:
	
	while:
	
		#prosi o pierwszą liczbę
		li $v0, 4
		la $a0, prompt
		syscall
	
	
		#pobiera doubla
		li $v0, 7
		syscall
	

		add.d $f12, $f0, $f10	
		mov.d $f2, $f12
	
		#prosi o działanie
		li $v0, 4
		la $a0, operations
		syscall
	
		#pobiera działanie
		li $v0, 5
		syscall
	
		#zapisuje działanie w rejestrze $t1
		move $t1, $v0
	
		li $v0, 7
		syscall
	
		add.d $f12, $f0, $f10
		mov.d $f4, $f12
		
		
		#drukuje pierwszą liczbę
		li $v0, 4
		la $a0, number1
		syscall
		
		li $v0, 3
		add.d $f12, $f2, $f10
		syscall
		
		#drukuje działanie
		li $v0, 4
		la $a0, operation
		syscall
		
		li $v0, 1
		move $a0, $t1
		syscall
		
		#drukuje drugą liczbę
		li $v0, 4
		la $a0, number2
		syscall
		
		li $v0, 3
		add.d $f12, $f4, $f10
		syscall
		
		#sprawdza, które działanie wybrał użytkownik
		beq $t1, 0, sum
		beq $t1, 1, substract
		beq $t1, 2, multiply
		beq $t1, 3, divide
		
	continue:
		
		#pyta, czy kontynuować
		li $v0, 4
		la $a0, ifContinue
		syscall
		
		#pobiera odpowiedź
		li $v0, 5
		syscall
		
		#zapisuje odpowiedź w rejestrze $t0
		move $t0, $v0
		
		#zakańcza lub kontynuuje program
		beq $t0, 0, exit
		beq $t0, 1, while
		

	exit:
		#koniec programu
		li $v0, 10
		syscall

		
	sum:
		
		
		
		#drukuje wynik
		li $v0, 4
		la $a0, result
		syscall
		
		li $v0, 3
		add.d $f12, $f4, $f2
		syscall
		

		j continue
	
	substract:
	
		sub $t3, $t0, $t2
		
		#drukuje wynik
		li $v0, 4
		la $a0, result
		syscall
		
 
 		li $v0, 1
 		move $a0, $t3
 		syscall
 		
 		j continue

	multiply:
	
		mult $t0, $t2
		mflo $t3

		#drukuje wynik
		li $v0, 4
		la $a0, result
		syscall
		

		li $v0, 1
		add $a0, $zero, $t3
		syscall
		
		j continue
		
	divide:
	
		div $t3, $t0, $t2	
		
		#drukuje wynik
		li $v0, 4
		la $a0, result
		syscall
		
		li $v0, 1
		add $a0, $zero, $t3
		syscall

		j continue
	

	.file	"kernel.c"
	.text
	.globl	keyboard_map
	.data
	.align 32
	.type	keyboard_map, @object
	.size	keyboard_map, 128
keyboard_map:
	.string	""
	.string	"\0331234567890-=\b\tqwertyuiop[]\n"
	.string	"asdfghjkl;'`"
	.string	"\\zxcvbnm,./"
	.string	"*"
	.string	" "
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"-"
	.string	""
	.string	""
	.string	"+"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.zero	37
	.globl	current_loc
	.section	.bss
	.align 4
	.type	current_loc, @object
	.size	current_loc, 4
current_loc:
	.zero	4
	.globl	vidptr
	.data
	.align 4
	.type	vidptr, @object
	.size	vidptr, 4
vidptr:
	.long	753664
	.globl	IDT
	.section	.bss
	.align 32
	.type	IDT, @object
	.size	IDT, 2048
IDT:
	.zero	2048
	.text
	.globl	idt_init
	.type	idt_init, @function
idt_init:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$keyboard_handler, -12(%ebp)
	movl	-12(%ebp), %eax
	movw	%ax, IDT+264
	movw	$8, IDT+266
	movb	$0, IDT+268
	movb	$-114, IDT+269
	movl	-12(%ebp), %eax
	shrl	$16, %eax
	movw	%ax, IDT+270
	subl	$8, %esp
	pushl	$17
	pushl	$32
	call	write_port
	addl	$16, %esp
	subl	$8, %esp
	pushl	$17
	pushl	$160
	call	write_port
	addl	$16, %esp
	subl	$8, %esp
	pushl	$32
	pushl	$33
	call	write_port
	addl	$16, %esp
	subl	$8, %esp
	pushl	$40
	pushl	$161
	call	write_port
	addl	$16, %esp
	subl	$8, %esp
	pushl	$0
	pushl	$33
	call	write_port
	addl	$16, %esp
	subl	$8, %esp
	pushl	$0
	pushl	$161
	call	write_port
	addl	$16, %esp
	subl	$8, %esp
	pushl	$1
	pushl	$33
	call	write_port
	addl	$16, %esp
	subl	$8, %esp
	pushl	$1
	pushl	$161
	call	write_port
	addl	$16, %esp
	subl	$8, %esp
	pushl	$255
	pushl	$33
	call	write_port
	addl	$16, %esp
	subl	$8, %esp
	pushl	$255
	pushl	$161
	call	write_port
	addl	$16, %esp
	movl	$IDT, -16(%ebp)
	movl	-16(%ebp), %eax
	sall	$16, %eax
	addl	$2048, %eax
	movl	%eax, -24(%ebp)
	movl	-16(%ebp), %eax
	shrl	$16, %eax
	movl	%eax, -20(%ebp)
	subl	$12, %esp
	leal	-24(%ebp), %eax
	pushl	%eax
	call	load_idt
	addl	$16, %esp
	nop
	leave
	ret
	.size	idt_init, .-idt_init
	.globl	kb_init
	.type	kb_init, @function
kb_init:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	subl	$8, %esp
	pushl	$253
	pushl	$33
	call	write_port
	addl	$16, %esp
	nop
	leave
	ret
	.size	kb_init, .-kb_init
	.globl	kprint
	.type	kprint, @function
kprint:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$16, %esp
	movl	$0, -8(%ebp)
	jmp	.L4
.L5:
	movl	-8(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, -8(%ebp)
	movl	8(%ebp), %edx
	leal	(%eax,%edx), %ecx
	movl	vidptr, %ebx
	movl	current_loc, %eax
	leal	1(%eax), %edx
	movl	%edx, current_loc
	leal	(%ebx,%eax), %edx
	movzbl	(%ecx), %eax
	movb	%al, (%edx)
	movl	vidptr, %ecx
	movl	current_loc, %eax
	leal	1(%eax), %edx
	movl	%edx, current_loc
	addl	%ecx, %eax
	movb	$7, (%eax)
.L4:
	movl	8(%ebp), %edx
	movl	-8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L5
	nop
	nop
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	kprint, .-kprint
	.globl	mse_nl
	.type	mse_nl, @function
mse_nl:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$160, -4(%ebp)
	movl	current_loc, %eax
	movl	$0, %edx
	divl	-4(%ebp)
	movl	%edx, %ecx
	movl	-4(%ebp), %eax
	subl	%ecx, %eax
	movl	%eax, %edx
	movl	current_loc, %eax
	addl	%edx, %eax
	movl	%eax, current_loc
	nop
	leave
	ret
	.size	mse_nl, .-mse_nl
	.globl	clear_screen
	.type	clear_screen, @function
clear_screen:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	jmp	.L8
.L9:
	movl	vidptr, %ecx
	movl	-4(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, -4(%ebp)
	addl	%ecx, %eax
	movb	$32, (%eax)
	movl	vidptr, %ecx
	movl	-4(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, -4(%ebp)
	addl	%ecx, %eax
	movb	$7, (%eax)
.L8:
	cmpl	$3999, -4(%ebp)
	jbe	.L9
	nop
	nop
	leave
	ret
	.size	clear_screen, .-clear_screen
	.globl	vga_entry_color
	.type	vga_entry_color, @function
vga_entry_color:
	pushl	%ebp
	movl	%esp, %ebp
	movl	12(%ebp), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	orl	%edx, %eax
	popl	%ebp
	ret
	.size	vga_entry_color, .-vga_entry_color
	.globl	vga_entry
	.type	vga_entry, @function
vga_entry:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %edx
	movl	12(%ebp), %eax
	movb	%dl, -4(%ebp)
	movb	%al, -8(%ebp)
	movzbl	-4(%ebp), %edx
	movzbl	-8(%ebp), %eax
	sall	$8, %eax
	orl	%edx, %eax
	leave
	ret
	.size	vga_entry, .-vga_entry
	.globl	strlen
	.type	strlen, @function
strlen:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	jmp	.L15
.L16:
	addl	$1, -4(%ebp)
.L15:
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L16
	movl	-4(%ebp), %eax
	leave
	ret
	.size	strlen, .-strlen
	.section	.rodata
	.align 4
	.type	VGA_WIDTH, @object
	.size	VGA_WIDTH, 4
VGA_WIDTH:
	.long	80
	.align 4
	.type	VGA_HEIGHT, @object
	.size	VGA_HEIGHT, 4
VGA_HEIGHT:
	.long	25
	.globl	terminal_row
	.section	.bss
	.align 4
	.type	terminal_row, @object
	.size	terminal_row, 4
terminal_row:
	.zero	4
	.globl	terminal_column
	.align 4
	.type	terminal_column, @object
	.size	terminal_column, 4
terminal_column:
	.zero	4
	.globl	terminal_color
	.type	terminal_color, @object
	.size	terminal_color, 1
terminal_color:
	.zero	1
	.globl	terminal_buffer
	.align 4
	.type	terminal_buffer, @object
	.size	terminal_buffer, 4
terminal_buffer:
	.zero	4
	.text
	.globl	term_init
	.type	term_init, @function
term_init:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$16, %esp
	movl	$0, terminal_row
	movl	$0, terminal_column
	pushl	$0
	pushl	$7
	call	vga_entry_color
	addl	$8, %esp
	movb	%al, terminal_color
	movl	$753664, terminal_buffer
	movl	$0, -8(%ebp)
	jmp	.L19
.L22:
	movl	$0, -12(%ebp)
	jmp	.L20
.L21:
	movl	$80, %eax
	imull	-8(%ebp), %eax
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -16(%ebp)
	movzbl	terminal_color, %eax
	movzbl	%al, %eax
	movl	terminal_buffer, %edx
	movl	-16(%ebp), %ecx
	addl	%ecx, %ecx
	leal	(%edx,%ecx), %ebx
	pushl	%eax
	pushl	$32
	call	vga_entry
	addl	$8, %esp
	movw	%ax, (%ebx)
	addl	$1, -12(%ebp)
.L20:
	movl	$80, %eax
	cmpl	%eax, -12(%ebp)
	jb	.L21
	addl	$1, -8(%ebp)
.L19:
	movl	$25, %eax
	cmpl	%eax, -8(%ebp)
	jb	.L22
	nop
	nop
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	term_init, .-term_init
	.globl	setclr
	.type	setclr, @function
setclr:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	vga_entry_color
	addl	$8, %esp
	movb	%al, terminal_color
	nop
	leave
	ret
	.size	setclr, .-setclr
	.globl	write_to
	.type	write_to, @function
write_to:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$24, %esp
	movl	8(%ebp), %edx
	movl	12(%ebp), %eax
	movb	%dl, -24(%ebp)
	movb	%al, -28(%ebp)
	movl	$80, %eax
	imull	20(%ebp), %eax
	movl	%eax, %edx
	movl	16(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -8(%ebp)
	movzbl	-28(%ebp), %edx
	movzbl	-24(%ebp), %eax
	movzbl	%al, %eax
	movl	terminal_buffer, %ecx
	movl	-8(%ebp), %ebx
	addl	%ebx, %ebx
	addl	%ecx, %ebx
	pushl	%edx
	pushl	%eax
	call	vga_entry
	addl	$8, %esp
	movw	%ax, (%ebx)
	nop
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	write_to, .-write_to
	.globl	putchar
	.type	putchar, @function
putchar:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$4, %esp
	movl	8(%ebp), %eax
	movb	%al, -8(%ebp)
	movl	terminal_row, %ebx
	movl	terminal_column, %ecx
	movzbl	terminal_color, %eax
	movzbl	%al, %edx
	movsbl	-8(%ebp), %eax
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%eax
	call	write_to
	addl	$16, %esp
	movl	terminal_column, %eax
	addl	$1, %eax
	movl	%eax, terminal_column
	movl	terminal_column, %eax
	movl	$80, %edx
	cmpl	%edx, %eax
	jne	.L27
	movl	$0, terminal_column
	movl	terminal_row, %eax
	addl	$1, %eax
	movl	%eax, terminal_row
	movl	terminal_row, %eax
	movl	$25, %edx
	cmpl	%edx, %eax
	jne	.L27
	movl	$0, terminal_row
.L27:
	nop
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	putchar, .-putchar
	.globl	write
	.type	write, @function
write:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$20, %esp
	movl	16(%ebp), %eax
	movb	%al, -20(%ebp)
	movl	$0, -4(%ebp)
	jmp	.L29
.L31:
	movl	terminal_row, %eax
	addl	$1, %eax
	movl	%eax, terminal_row
	movzbl	-20(%ebp), %eax
	negl	%eax
	movl	%eax, terminal_column
	addl	$1, -4(%ebp)
.L30:
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	cmpb	$10, %al
	je	.L31
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	pushl	%eax
	call	putchar
	addl	$4, %esp
	movl	-4(%ebp), %eax
	movl	%eax, -8(%ebp)
	addl	$1, -4(%ebp)
.L29:
	movl	-4(%ebp), %eax
	cmpl	12(%ebp), %eax
	jb	.L30
	nop
	nop
	leave
	ret
	.size	write, .-write
	.section	.rodata
.LC0:
	.string	" "
	.text
	.globl	clear
	.type	clear, @function
clear:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	call	term_init
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	nop
	leave
	ret
	.size	clear, .-clear
	.globl	printf
	.type	printf, @function
printf:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	terminal_row, %eax
	movl	$25, %edx
	cmpl	%edx, %eax
	jb	.L35
	call	clear
	call	clear_screen
.L35:
	subl	$12, %esp
	pushl	8(%ebp)
	call	strlen
	addl	$16, %esp
	subl	$4, %esp
	pushl	$0
	pushl	%eax
	pushl	8(%ebp)
	call	write
	addl	$16, %esp
	nop
	leave
	ret
	.size	printf, .-printf
	.globl	nprintf
	.type	nprintf, @function
nprintf:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$16, %esp
	movl	terminal_row, %eax
	movl	$25, %edx
	cmpl	%edx, %eax
	jb	.L37
	movl	$0, -8(%ebp)
	jmp	.L38
.L41:
	movl	$0, -12(%ebp)
	jmp	.L39
.L40:
	movl	terminal_buffer, %eax
	movl	-8(%ebp), %edx
	addl	$1, %edx
	movl	%edx, %ecx
	movl	$80, %edx
	imull	%edx, %ecx
	movl	-12(%ebp), %edx
	addl	%ecx, %edx
	addl	%edx, %edx
	leal	(%eax,%edx), %ecx
	movl	terminal_buffer, %edx
	movl	-8(%ebp), %eax
	movl	$80, %ebx
	imull	%eax, %ebx
	movl	-12(%ebp), %eax
	addl	%ebx, %eax
	addl	%eax, %eax
	addl	%eax, %edx
	movzwl	(%ecx), %eax
	movw	%ax, (%edx)
	addl	$1, -12(%ebp)
.L39:
	movl	-12(%ebp), %eax
	movl	$80, %edx
	cmpl	%edx, %eax
	jb	.L40
	addl	$1, -8(%ebp)
.L38:
	movl	-8(%ebp), %eax
	movl	$25, %edx
	cmpl	%edx, %eax
	jb	.L41
.L37:
	pushl	8(%ebp)
	call	strlen
	addl	$4, %esp
	pushl	$1
	pushl	%eax
	pushl	8(%ebp)
	call	write
	addl	$12, %esp
	nop
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	nprintf, .-nprintf
	.globl	get_digits
	.type	get_digits, @function
get_digits:
	pushl	%ebp
	movl	%esp, %ebp
	cmpl	$9, 8(%ebp)
	jg	.L43
	movl	$1, %eax
	jmp	.L44
.L43:
	cmpl	$99, 8(%ebp)
	jg	.L45
	movl	$2, %eax
	jmp	.L44
.L45:
	cmpl	$999, 8(%ebp)
	jg	.L46
	movl	$3, %eax
	jmp	.L44
.L46:
	cmpl	$9999, 8(%ebp)
	jg	.L47
	movl	$4, %eax
	jmp	.L44
.L47:
	cmpl	$99999, 8(%ebp)
	jg	.L48
	movl	$5, %eax
	jmp	.L44
.L48:
	cmpl	$999999, 8(%ebp)
	jg	.L49
	movl	$6, %eax
	jmp	.L44
.L49:
	cmpl	$9999999, 8(%ebp)
	jg	.L50
	movl	$7, %eax
	jmp	.L44
.L50:
	cmpl	$99999999, 8(%ebp)
	jg	.L51
	movl	$8, %eax
	jmp	.L44
.L51:
	cmpl	$999999999, 8(%ebp)
	jg	.L52
	movl	$9, %eax
	jmp	.L44
.L52:
	movl	$10, %eax
.L44:
	popl	%ebp
	ret
	.size	get_digits, .-get_digits
	.section	.rodata
.LC1:
	.string	"0"
.LC2:
	.string	"1"
.LC3:
	.string	"2"
.LC4:
	.string	"-1"
.LC5:
	.string	"-2"
	.text
	.globl	prnt
	.type	prnt, @function
prnt:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	addl	$2, %eax
	cmpl	$4, %eax
	ja	.L54
	movl	.L56(,%eax,4), %eax
	jmp	*%eax
	.section	.rodata
	.align 4
	.align 4
.L56:
	.long	.L60
	.long	.L59
	.long	.L58
	.long	.L57
	.long	.L55
	.text
.L58:
	movl	$.LC1, %eax
	jmp	.L53
.L57:
	movl	$.LC2, %eax
	jmp	.L53
.L55:
	movl	$.LC3, %eax
	jmp	.L53
.L59:
	movl	$.LC4, %eax
	jmp	.L53
.L60:
	movl	$.LC5, %eax
	jmp	.L53
.L54:
.L53:
	popl	%ebp
	ret
	.size	prnt, .-prnt
	.globl	itoa
	.type	itoa, @function
itoa:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$48, %esp
	leal	-36(%ebp), %eax
	movl	%eax, -4(%ebp)
	cmpl	$10, 16(%ebp)
	jne	.L63
	cmpl	$0, 8(%ebp)
	jns	.L63
	movl	$1, %eax
	jmp	.L64
.L63:
	movl	$0, %eax
.L64:
	movl	%eax, -16(%ebp)
	cmpl	$0, -16(%ebp)
	je	.L65
	movl	8(%ebp), %eax
	negl	%eax
	movl	%eax, -8(%ebp)
	jmp	.L67
.L65:
	movl	8(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	.L67
.L69:
	movl	16(%ebp), %ecx
	movl	-8(%ebp), %eax
	movl	$0, %edx
	divl	%ecx
	movl	%edx, %eax
	movl	%eax, -20(%ebp)
	movl	16(%ebp), %ecx
	movl	-8(%ebp), %eax
	movl	$0, %edx
	divl	%ecx
	movl	%eax, -8(%ebp)
	cmpl	$9, -20(%ebp)
	jg	.L68
	movl	-20(%ebp), %eax
	leal	48(%eax), %ecx
	movl	-4(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, -4(%ebp)
	movl	%ecx, %edx
	movb	%dl, (%eax)
	jmp	.L67
.L68:
	movl	-20(%ebp), %eax
	leal	87(%eax), %ecx
	movl	-4(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, -4(%ebp)
	movl	%ecx, %edx
	movb	%dl, (%eax)
.L67:
	cmpl	$0, -8(%ebp)
	jne	.L69
	leal	-36(%ebp), %eax
	cmpl	%eax, -4(%ebp)
	je	.L69
	leal	-36(%ebp), %eax
	movl	-4(%ebp), %edx
	subl	%eax, %edx
	movl	%edx, -12(%ebp)
	cmpl	$0, -16(%ebp)
	je	.L71
	movl	12(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, 12(%ebp)
	movb	$45, (%eax)
	addl	$1, -12(%ebp)
	jmp	.L71
.L72:
	subl	$1, -4(%ebp)
	movl	12(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, 12(%ebp)
	movl	-4(%ebp), %edx
	movzbl	(%edx), %edx
	movb	%dl, (%eax)
.L71:
	leal	-36(%ebp), %eax
	cmpl	-4(%ebp), %eax
	jb	.L72
	movl	-12(%ebp), %eax
	leave
	ret
	.size	itoa, .-itoa
	.globl	printn
	.type	printn, @function
printn:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	pushl	$10
	leal	-23(%ebp), %eax
	pushl	%eax
	pushl	8(%ebp)
	call	itoa
	addl	$12, %esp
	subl	$12, %esp
	leal	-23(%ebp), %eax
	pushl	%eax
	call	printf
	addl	$16, %esp
	nop
	leave
	ret
	.size	printn, .-printn
	.section	.rodata
.LC6:
	.string	"0x"
	.text
	.globl	printh
	.type	printh, @function
printh:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	pushl	$16
	leal	-23(%ebp), %eax
	pushl	%eax
	pushl	8(%ebp)
	call	itoa
	addl	$12, %esp
	subl	$12, %esp
	pushl	$.LC6
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	leal	-23(%ebp), %eax
	pushl	%eax
	call	printf
	addl	$16, %esp
	nop
	leave
	ret
	.size	printh, .-printh
	.globl	printhx
	.type	printhx, @function
printhx:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	pushl	$16
	leal	-23(%ebp), %eax
	pushl	%eax
	pushl	8(%ebp)
	call	itoa
	addl	$12, %esp
	subl	$12, %esp
	leal	-23(%ebp), %eax
	pushl	%eax
	call	printf
	addl	$16, %esp
	nop
	leave
	ret
	.size	printhx, .-printhx
	.globl	strcat
	.type	strcat, @function
strcat:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	cmpl	$0, 8(%ebp)
	jne	.L78
	cmpl	$0, 12(%ebp)
	jne	.L78
	movl	$0, %eax
	jmp	.L79
.L78:
	movl	8(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L80
.L81:
	addl	$1, -4(%ebp)
.L80:
	movl	-4(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L81
	jmp	.L82
.L83:
	movl	12(%ebp), %edx
	leal	1(%edx), %eax
	movl	%eax, 12(%ebp)
	movl	-4(%ebp), %eax
	leal	1(%eax), %ecx
	movl	%ecx, -4(%ebp)
	movzbl	(%edx), %edx
	movb	%dl, (%eax)
.L82:
	movl	12(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L83
	movl	-4(%ebp), %eax
	movb	$0, (%eax)
	movl	8(%ebp), %eax
.L79:
	leave
	ret
	.size	strcat, .-strcat
	.section	.rodata
.LC7:
	.string	"3"
.LC8:
	.string	"4"
.LC9:
	.string	"5"
.LC10:
	.string	"6"
.LC11:
	.string	"7"
.LC12:
	.string	"8"
.LC13:
	.string	"9"
	.text
	.globl	strnum
	.type	strnum, @function
strnum:
	pushl	%ebp
	movl	%esp, %ebp
	cmpl	$.LC1, 8(%ebp)
	jne	.L85
	movl	$0, %eax
	jmp	.L86
.L85:
	cmpl	$.LC2, 8(%ebp)
	jne	.L87
	movl	$1, %eax
	jmp	.L86
.L87:
	cmpl	$.LC3, 8(%ebp)
	jne	.L88
	movl	$2, %eax
	jmp	.L86
.L88:
	cmpl	$.LC7, 8(%ebp)
	jne	.L89
	movl	$3, %eax
	jmp	.L86
.L89:
	cmpl	$.LC8, 8(%ebp)
	jne	.L90
	movl	$4, %eax
	jmp	.L86
.L90:
	cmpl	$.LC9, 8(%ebp)
	jne	.L91
	movl	$5, %eax
	jmp	.L86
.L91:
	cmpl	$.LC10, 8(%ebp)
	jne	.L92
	movl	$6, %eax
	jmp	.L86
.L92:
	cmpl	$.LC11, 8(%ebp)
	jne	.L93
	movl	$7, %eax
	jmp	.L86
.L93:
	cmpl	$.LC12, 8(%ebp)
	jne	.L94
	movl	$8, %eax
	jmp	.L86
.L94:
	cmpl	$.LC13, 8(%ebp)
	jne	.L95
	movl	$9, %eax
	jmp	.L86
.L95:
	movl	$-1, %eax
.L86:
	popl	%ebp
	ret
	.size	strnum, .-strnum
	.globl	atoi
	.type	atoi, @function
atoi:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	movl	$0, -8(%ebp)
	jmp	.L97
.L98:
	movl	-4(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	movl	%eax, %ecx
	movl	-8(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	addl	%ecx, %eax
	subl	$48, %eax
	movl	%eax, -4(%ebp)
	addl	$1, -8(%ebp)
.L97:
	movl	-8(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L98
	movl	-4(%ebp), %eax
	leave
	ret
	.size	atoi, .-atoi
	.section	.rodata
.LC14:
	.string	"kernel: "
	.text
	.globl	kprintf
	.type	kprintf, @function
kprintf:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	pushl	$0
	pushl	$11
	call	setclr
	addl	$8, %esp
	subl	$12, %esp
	pushl	$.LC14
	call	printf
	addl	$16, %esp
	subl	$8, %esp
	pushl	$0
	pushl	$15
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	printf
	addl	$16, %esp
	nop
	leave
	ret
	.size	kprintf, .-kprintf
	.section	.rodata
.LC15:
	.string	"SUCCESS"
.LC16:
	.string	"FAILURE"
	.text
	.globl	kprintd
	.type	kprintd, @function
kprintd:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	12(%ebp), %eax
	movb	%al, -12(%ebp)
	subl	$12, %esp
	pushl	8(%ebp)
	call	kprintf
	addl	$16, %esp
	cmpb	$0, -12(%ebp)
	je	.L102
	subl	$8, %esp
	pushl	$0
	pushl	$2
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC15
	call	printf
	addl	$16, %esp
	jmp	.L103
.L102:
	subl	$8, %esp
	pushl	$0
	pushl	$4
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC16
	call	printf
	addl	$16, %esp
.L103:
	subl	$8, %esp
	pushl	$0
	pushl	$15
	call	setclr
	addl	$16, %esp
	nop
	leave
	ret
	.size	kprintd, .-kprintd
	.section	.rodata
.LC17:
	.string	"\nkernel: "
.LC18:
	.string	"panic: error: \""
.LC19:
	.string	"fatal: "
.LC20:
	.string	"non-fatal: "
.LC21:
	.string	"\""
.LC22:
	.string	"\nDebugging Info:\n\n"
.LC23:
	.string	""
	.string	""
	.align 4
.LC24:
	.string	"\n\nSending you to dumped data..."
.LC25:
	.string	"abort()\n"
.LC26:
	.string	" Continue on your journey.\n"
	.text
	.globl	panic
	.type	panic, @function
panic:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	16(%ebp), %eax
	movb	%al, -28(%ebp)
	pushl	$0
	pushl	$11
	call	setclr
	addl	$8, %esp
	call	mse_nl
	subl	$12, %esp
	pushl	$.LC17
	call	printf
	addl	$16, %esp
	subl	$8, %esp
	pushl	$0
	pushl	$4
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC18
	call	printf
	addl	$16, %esp
	cmpb	$0, -28(%ebp)
	je	.L105
	subl	$8, %esp
	pushl	$0
	pushl	$13
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC19
	call	printf
	addl	$16, %esp
	jmp	.L106
.L105:
	subl	$8, %esp
	pushl	$0
	pushl	$2
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC20
	call	printf
	addl	$16, %esp
.L106:
	subl	$8, %esp
	pushl	$0
	pushl	$12
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	12(%ebp)
	call	printf
	addl	$16, %esp
	subl	$8, %esp
	pushl	$0
	pushl	$4
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC21
	call	printf
	addl	$16, %esp
	call	mse_nl
	subl	$12, %esp
	pushl	$.LC22
	call	printf
	addl	$16, %esp
	call	mse_nl
	call	mse_nl
	subl	$8, %esp
	pushl	$0
	pushl	$5
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	printf
	addl	$16, %esp
	subl	$8, %esp
	pushl	$0
	pushl	$4
	call	setclr
	addl	$16, %esp
	cmpb	$0, -28(%ebp)
	je	.L107
	movl	$0, -12(%ebp)
	jmp	.L108
.L109:
	addl	$1, -12(%ebp)
	subl	$12, %esp
	pushl	$.LC23
	call	printf
	addl	$16, %esp
.L108:
	cmpl	$74999999, -12(%ebp)
	jle	.L109
	subl	$12, %esp
	pushl	$.LC24
	call	printf
	addl	$16, %esp
	call	dump
/APP
/  37 "libc/kernel/abort.h" 1
	hlt
/  0 "" 2
/NO_APP
	subl	$12, %esp
	pushl	$.LC25
	call	printf
	addl	$16, %esp
.L110:
	jmp	.L110
.L107:
	subl	$12, %esp
	pushl	$.LC26
	call	printf
	addl	$16, %esp
	call	mse_nl
	call	mse_nl
	subl	$8, %esp
	pushl	$0
	pushl	$15
	call	setclr
	addl	$16, %esp
	nop
	leave
	ret
	.size	panic, .-panic
	.section	.rodata
.LC27:
	.string	"Escape"
.LC28:
	.string	"-"
.LC29:
	.string	"="
.LC30:
	.string	"BKSP"
.LC31:
	.string	"Tab"
.LC32:
	.string	"q"
.LC33:
	.string	"w"
.LC34:
	.string	"e"
.LC35:
	.string	"r"
.LC36:
	.string	"t"
.LC37:
	.string	"y"
.LC38:
	.string	"u"
.LC39:
	.string	"i"
.LC40:
	.string	"o"
.LC41:
	.string	"p"
.LC42:
	.string	"{"
.LC43:
	.string	"}"
.LC44:
	.string	"\n"
.LC45:
	.string	"L-CTRL"
.LC46:
	.string	"a"
.LC47:
	.string	"s"
.LC48:
	.string	"d"
.LC49:
	.string	"f"
.LC50:
	.string	"g"
.LC51:
	.string	"h"
.LC52:
	.string	"j"
.LC53:
	.string	"k"
.LC54:
	.string	"l"
.LC55:
	.string	";"
.LC56:
	.string	"'"
.LC57:
	.string	"#"
.LC58:
	.string	"L-SHIFT"
.LC59:
	.string	"\\"
.LC60:
	.string	"z"
.LC61:
	.string	"x"
.LC62:
	.string	"c"
.LC63:
	.string	"v"
.LC64:
	.string	"b"
.LC65:
	.string	"n"
.LC66:
	.string	"m"
.LC67:
	.string	","
.LC68:
	.string	"."
.LC69:
	.string	"/"
.LC70:
	.string	"R-SHIFT"
.LC71:
	.string	"L-ALT"
.LC72:
	.string	"CAPS"
.LC73:
	.string	"F1"
.LC74:
	.string	"F2"
.LC75:
	.string	"F3"
.LC76:
	.string	"F4"
.LC77:
	.string	"F5"
.LC78:
	.string	"F6"
.LC79:
	.string	"F7"
.LC80:
	.string	"F8"
.LC81:
	.string	"F9"
.LC82:
	.string	"F10"
.LC83:
	.string	"NUM"
.LC84:
	.string	"SCROLL"
.LC85:
	.string	"UP"
.LC86:
	.string	"LEFT"
.LC87:
	.string	"RIGHT"
.LC88:
	.string	"DOWN"
.LC89:
	.string	"?"
	.text
	.globl	keys
	.type	keys, @function
keys:
	pushl	%ebp
	movl	%esp, %ebp
	cmpl	$80, 8(%ebp)
	ja	.L112
	movl	8(%ebp), %eax
	sall	$2, %eax
	addl	$.L114, %eax
	movl	(%eax), %eax
	jmp	*%eax
	.section	.rodata
	.align 4
	.align 4
.L114:
	.long	.L112
	.long	.L187
	.long	.L186
	.long	.L185
	.long	.L184
	.long	.L183
	.long	.L182
	.long	.L181
	.long	.L180
	.long	.L179
	.long	.L178
	.long	.L177
	.long	.L176
	.long	.L175
	.long	.L174
	.long	.L173
	.long	.L172
	.long	.L171
	.long	.L170
	.long	.L169
	.long	.L168
	.long	.L167
	.long	.L166
	.long	.L165
	.long	.L164
	.long	.L163
	.long	.L162
	.long	.L161
	.long	.L160
	.long	.L159
	.long	.L158
	.long	.L157
	.long	.L156
	.long	.L155
	.long	.L154
	.long	.L153
	.long	.L152
	.long	.L151
	.long	.L150
	.long	.L149
	.long	.L148
	.long	.L147
	.long	.L146
	.long	.L145
	.long	.L144
	.long	.L143
	.long	.L142
	.long	.L141
	.long	.L140
	.long	.L139
	.long	.L138
	.long	.L137
	.long	.L136
	.long	.L135
	.long	.L134
	.long	.L133
	.long	.L132
	.long	.L131
	.long	.L130
	.long	.L129
	.long	.L128
	.long	.L127
	.long	.L126
	.long	.L125
	.long	.L124
	.long	.L123
	.long	.L122
	.long	.L121
	.long	.L120
	.long	.L119
	.long	.L118
	.long	.L112
	.long	.L117
	.long	.L112
	.long	.L112
	.long	.L116
	.long	.L112
	.long	.L115
	.long	.L112
	.long	.L112
	.long	.L113
	.text
.L187:
	movl	$.LC27, %eax
	jmp	.L188
.L186:
	movl	$.LC2, %eax
	jmp	.L188
.L185:
	movl	$.LC3, %eax
	jmp	.L188
.L184:
	movl	$.LC7, %eax
	jmp	.L188
.L183:
	movl	$.LC8, %eax
	jmp	.L188
.L182:
	movl	$.LC9, %eax
	jmp	.L188
.L181:
	movl	$.LC10, %eax
	jmp	.L188
.L180:
	movl	$.LC11, %eax
	jmp	.L188
.L179:
	movl	$.LC12, %eax
	jmp	.L188
.L178:
	movl	$.LC13, %eax
	jmp	.L188
.L177:
	movl	$.LC1, %eax
	jmp	.L188
.L176:
	movl	$.LC28, %eax
	jmp	.L188
.L175:
	movl	$.LC29, %eax
	jmp	.L188
.L174:
	movl	$.LC30, %eax
	jmp	.L188
.L173:
	movl	$.LC31, %eax
	jmp	.L188
.L172:
	movl	$.LC32, %eax
	jmp	.L188
.L171:
	movl	$.LC33, %eax
	jmp	.L188
.L170:
	movl	$.LC34, %eax
	jmp	.L188
.L169:
	movl	$.LC35, %eax
	jmp	.L188
.L168:
	movl	$.LC36, %eax
	jmp	.L188
.L167:
	movl	$.LC37, %eax
	jmp	.L188
.L166:
	movl	$.LC38, %eax
	jmp	.L188
.L165:
	movl	$.LC39, %eax
	jmp	.L188
.L164:
	movl	$.LC40, %eax
	jmp	.L188
.L163:
	movl	$.LC41, %eax
	jmp	.L188
.L162:
	movl	$.LC42, %eax
	jmp	.L188
.L161:
	movl	$.LC43, %eax
	jmp	.L188
.L160:
	movl	$.LC44, %eax
	jmp	.L188
.L159:
	movl	$.LC45, %eax
	jmp	.L188
.L158:
	movl	$.LC46, %eax
	jmp	.L188
.L157:
	movl	$.LC47, %eax
	jmp	.L188
.L156:
	movl	$.LC48, %eax
	jmp	.L188
.L155:
	movl	$.LC49, %eax
	jmp	.L188
.L154:
	movl	$.LC50, %eax
	jmp	.L188
.L153:
	movl	$.LC51, %eax
	jmp	.L188
.L152:
	movl	$.LC52, %eax
	jmp	.L188
.L151:
	movl	$.LC53, %eax
	jmp	.L188
.L150:
	movl	$.LC54, %eax
	jmp	.L188
.L149:
	movl	$.LC55, %eax
	jmp	.L188
.L148:
	movl	$.LC56, %eax
	jmp	.L188
.L147:
	movl	$.LC57, %eax
	jmp	.L188
.L146:
	movl	$.LC58, %eax
	jmp	.L188
.L145:
	movl	$.LC59, %eax
	jmp	.L188
.L144:
	movl	$.LC60, %eax
	jmp	.L188
.L143:
	movl	$.LC61, %eax
	jmp	.L188
.L142:
	movl	$.LC62, %eax
	jmp	.L188
.L141:
	movl	$.LC63, %eax
	jmp	.L188
.L140:
	movl	$.LC64, %eax
	jmp	.L188
.L139:
	movl	$.LC65, %eax
	jmp	.L188
.L138:
	movl	$.LC66, %eax
	jmp	.L188
.L137:
	movl	$.LC67, %eax
	jmp	.L188
.L136:
	movl	$.LC68, %eax
	jmp	.L188
.L135:
	movl	$.LC69, %eax
	jmp	.L188
.L134:
	movl	$.LC70, %eax
	jmp	.L188
.L133:
	movl	$.LC28, %eax
	jmp	.L188
.L132:
	movl	$.LC71, %eax
	jmp	.L188
.L131:
	movl	$.LC0, %eax
	jmp	.L188
.L130:
	movl	$.LC72, %eax
	jmp	.L188
.L129:
	movl	$.LC73, %eax
	jmp	.L188
.L128:
	movl	$.LC74, %eax
	jmp	.L188
.L127:
	movl	$.LC75, %eax
	jmp	.L188
.L126:
	movl	$.LC76, %eax
	jmp	.L188
.L125:
	movl	$.LC77, %eax
	jmp	.L188
.L124:
	movl	$.LC78, %eax
	jmp	.L188
.L123:
	movl	$.LC79, %eax
	jmp	.L188
.L122:
	movl	$.LC80, %eax
	jmp	.L188
.L121:
	movl	$.LC81, %eax
	jmp	.L188
.L120:
	movl	$.LC82, %eax
	jmp	.L188
.L119:
	movl	$.LC83, %eax
	jmp	.L188
.L118:
	movl	$.LC84, %eax
	jmp	.L188
.L117:
	movl	$.LC85, %eax
	jmp	.L188
.L116:
	movl	$.LC86, %eax
	jmp	.L188
.L115:
	movl	$.LC87, %eax
	jmp	.L188
.L113:
	movl	$.LC88, %eax
	jmp	.L188
.L112:
	movl	$.LC89, %eax
.L188:
	popl	%ebp
	ret
	.size	keys, .-keys
	.data
	.align 4
	.type	next, @object
	.size	next, 4
next:
	.long	1
	.text
	.globl	rand
	.type	rand, @function
rand:
	pushl	%ebp
	movl	%esp, %ebp
	movl	next, %eax
	imull	$1103515245, %eax, %eax
	addl	$12345, %eax
	movl	%eax, next
	movl	next, %eax
	shrl	$16, %eax
	andl	$32767, %eax
	popl	%ebp
	ret
	.size	rand, .-rand
	.globl	srand
	.type	srand, @function
srand:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	movl	%eax, next
	nop
	popl	%ebp
	ret
	.size	srand, .-srand
	.globl	rnd
	.data
	.align 4
	.type	rnd, @object
	.size	rnd, 4
rnd:
	.long	1686470885
	.section	.rodata
.LC90:
	.string	"X"
.LC91:
	.string	"O"
	.text
	.globl	printt
	.type	printt, @function
printt:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	cmpl	$3, 8(%ebp)
	jne	.L193
	subl	$12, %esp
	pushl	$.LC28
	call	printf
	addl	$16, %esp
	jmp	.L194
.L193:
	cmpl	$1, 8(%ebp)
	jne	.L195
	subl	$12, %esp
	pushl	$.LC90
	call	printf
	addl	$16, %esp
	jmp	.L194
.L195:
	cmpl	$0, 8(%ebp)
	jne	.L196
	subl	$12, %esp
	pushl	$.LC91
	call	printf
	addl	$16, %esp
	jmp	.L194
.L196:
	movl	$1, %eax
	jmp	.L197
.L194:
	movl	$0, %eax
.L197:
	leave
	ret
	.size	printt, .-printt
	.globl	tries
	.section	.bss
	.align 4
	.type	tries, @object
	.size	tries, 4
tries:
	.zero	4
	.section	.rodata
.LC92:
	.string	" -- "
.LC93:
	.string	"_____\n"
	.text
	.globl	render
	.type	render, @function
render:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	printt
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	12(%ebp)
	call	printt
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	16(%ebp)
	call	printt
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	20(%ebp)
	call	printt
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	24(%ebp)
	call	printt
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	28(%ebp)
	call	printt
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC92
	call	printf
	addl	$16, %esp
	movl	tries, %eax
	subl	$12, %esp
	pushl	%eax
	call	printn
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	32(%ebp)
	call	printt
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	36(%ebp)
	call	printt
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	40(%ebp)
	call	printt
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC93
	call	printf
	addl	$16, %esp
	nop
	leave
	ret
	.size	render, .-render
	.globl	toreturn
	.section	.rodata
.LC94:
	.string	"tl"
.LC95:
	.string	"tm"
.LC96:
	.string	"tr"
.LC97:
	.string	"ml"
.LC98:
	.string	"mm"
.LC99:
	.string	"mr"
.LC100:
	.string	"bl"
.LC101:
	.string	"bm"
.LC102:
	.string	"br"
	.data
	.align 32
	.type	toreturn, @object
	.size	toreturn, 36
toreturn:
	.long	.LC94
	.long	.LC95
	.long	.LC96
	.long	.LC97
	.long	.LC98
	.long	.LC99
	.long	.LC100
	.long	.LC101
	.long	.LC102
	.globl	p
	.align 32
	.type	p, @object
	.size	p, 36
p:
	.long	3
	.long	3
	.long	3
	.long	3
	.long	3
	.long	3
	.long	3
	.long	3
	.long	3
	.globl	winner
	.align 4
	.type	winner, @object
	.size	winner, 4
winner:
	.long	3
	.text
	.globl	checkwin
	.type	checkwin, @function
checkwin:
	pushl	%ebp
	movl	%esp, %ebp
	movl	p, %eax
	testl	%eax, %eax
	jne	.L200
	movl	p+4, %eax
	testl	%eax, %eax
	jne	.L200
	movl	p+8, %eax
	testl	%eax, %eax
	je	.L201
.L200:
	movl	p, %eax
	cmpl	$1, %eax
	jne	.L202
	movl	p+4, %eax
	cmpl	$1, %eax
	jne	.L202
	movl	p+8, %eax
	cmpl	$1, %eax
	jne	.L202
.L201:
	movl	$1, %eax
	jmp	.L203
.L202:
	movl	p+12, %eax
	testl	%eax, %eax
	jne	.L204
	movl	p+16, %eax
	testl	%eax, %eax
	jne	.L204
	movl	p+20, %eax
	testl	%eax, %eax
	je	.L205
.L204:
	movl	p+12, %eax
	cmpl	$1, %eax
	jne	.L206
	movl	p+16, %eax
	cmpl	$1, %eax
	jne	.L206
	movl	p+20, %eax
	cmpl	$1, %eax
	jne	.L206
.L205:
	movl	$1, %eax
	jmp	.L203
.L206:
	movl	p+24, %eax
	testl	%eax, %eax
	jne	.L207
	movl	p+28, %eax
	testl	%eax, %eax
	jne	.L207
	movl	p+32, %eax
	testl	%eax, %eax
	je	.L208
.L207:
	movl	p+24, %eax
	cmpl	$1, %eax
	jne	.L209
	movl	p+28, %eax
	cmpl	$1, %eax
	jne	.L209
	movl	p+32, %eax
	cmpl	$1, %eax
	jne	.L209
.L208:
	movl	$1, %eax
	jmp	.L203
.L209:
	movl	p, %eax
	testl	%eax, %eax
	jne	.L210
	movl	p+12, %eax
	testl	%eax, %eax
	jne	.L210
	movl	p+24, %eax
	testl	%eax, %eax
	je	.L211
.L210:
	movl	p, %eax
	cmpl	$1, %eax
	jne	.L212
	movl	p+12, %eax
	cmpl	$1, %eax
	jne	.L212
	movl	p+24, %eax
	cmpl	$1, %eax
	jne	.L212
.L211:
	movl	$1, %eax
	jmp	.L203
.L212:
	movl	p+4, %eax
	testl	%eax, %eax
	jne	.L213
	movl	p+16, %eax
	testl	%eax, %eax
	jne	.L213
	movl	p+28, %eax
	testl	%eax, %eax
	je	.L214
.L213:
	movl	p+4, %eax
	cmpl	$1, %eax
	jne	.L215
	movl	p+16, %eax
	cmpl	$1, %eax
	jne	.L215
	movl	p+28, %eax
	cmpl	$1, %eax
	jne	.L215
.L214:
	movl	$1, %eax
	jmp	.L203
.L215:
	movl	p+8, %eax
	testl	%eax, %eax
	jne	.L216
	movl	p+20, %eax
	testl	%eax, %eax
	jne	.L216
	movl	p+32, %eax
	testl	%eax, %eax
	je	.L217
.L216:
	movl	p+8, %eax
	cmpl	$1, %eax
	jne	.L218
	movl	p+20, %eax
	cmpl	$1, %eax
	jne	.L218
	movl	p+32, %eax
	cmpl	$1, %eax
	jne	.L218
.L217:
	movl	$1, %eax
	jmp	.L203
.L218:
	movl	p, %eax
	testl	%eax, %eax
	jne	.L219
	movl	p+16, %eax
	testl	%eax, %eax
	jne	.L219
	movl	p+32, %eax
	testl	%eax, %eax
	je	.L220
.L219:
	movl	p, %eax
	cmpl	$1, %eax
	jne	.L221
	movl	p+16, %eax
	cmpl	$1, %eax
	jne	.L221
	movl	p+32, %eax
	cmpl	$1, %eax
	jne	.L221
.L220:
	movl	$1, %eax
	jmp	.L203
.L221:
	movl	p+8, %eax
	testl	%eax, %eax
	jne	.L222
	movl	p+16, %eax
	testl	%eax, %eax
	jne	.L222
	movl	p+24, %eax
	testl	%eax, %eax
	je	.L223
.L222:
	movl	p+8, %eax
	cmpl	$1, %eax
	jne	.L224
	movl	p+16, %eax
	cmpl	$1, %eax
	jne	.L224
	movl	p+24, %eax
	cmpl	$1, %eax
	jne	.L224
.L223:
	movl	$1, %eax
	jmp	.L203
.L224:
	movl	$0, %eax
.L203:
	popl	%ebp
	ret
	.size	checkwin, .-checkwin
	.globl	getInput
	.type	getInput, @function
getInput:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	call	rand
	movl	%eax, %ecx
	movl	$1717986919, %edx
	movl	%ecx, %eax
	imull	%edx
	movl	%edx, %eax
	sarl	$2, %eax
	movl	%ecx, %edx
	sarl	$31, %edx
	subl	%edx, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	movl	%edx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	toreturn(,%eax,4), %eax
	movl	%eax, -20(%ebp)
	movl	-16(%ebp), %eax
	movl	p(,%eax,4), %eax
	cmpl	$3, %eax
	je	.L226
	call	getInput
	jmp	.L225
.L226:
	movl	-20(%ebp), %eax
.L225:
	leave
	ret
	.size	getInput, .-getInput
	.section	.rodata
	.align 4
.LC103:
	.string	"Victory for Noughts O, on go number "
	.align 4
.LC104:
	.string	"Victory for crosses X, on go number "
.LC105:
	.string	"Nobody wins."
	.text
	.globl	win
	.type	win, @function
win:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	cmpl	$1, 8(%ebp)
	jne	.L230
	subl	$12, %esp
	pushl	$.LC103
	call	printf
	addl	$16, %esp
	movl	tries, %eax
	subl	$1, %eax
	subl	$12, %esp
	pushl	%eax
	call	printn
	addl	$16, %esp
	jmp	.L233
.L230:
	cmpl	$0, 8(%ebp)
	jne	.L232
	subl	$12, %esp
	pushl	$.LC104
	call	printf
	addl	$16, %esp
	movl	tries, %eax
	subl	$1, %eax
	subl	$12, %esp
	pushl	%eax
	call	printn
	addl	$16, %esp
	jmp	.L233
.L232:
	cmpl	$-1, 8(%ebp)
	jne	.L233
	subl	$12, %esp
	pushl	$.LC105
	call	printf
	addl	$16, %esp
.L233:
	nop
	leave
	ret
	.size	win, .-win
	.section	.rodata
	.align 4
.LC106:
	.string	" #######             #######                  #######               \n"
	.align 4
.LC107:
	.string	"    #    #  ####        #      ##    ####        #     ####  ###### \n"
	.align 4
.LC108:
	.string	"    #    # #    #       #     #  #  #    #       #    #    # #      \n"
	.align 4
.LC109:
	.string	"    #    # #            #    #    # #            #    #    # #####  \n"
	.align 4
.LC110:
	.string	"    #    # #            #    ###### #            #    #    # #      \n"
	.align 4
.LC111:
	.string	"    #    # #    #       #    #    # #    #       #    #    # #      \n"
	.align 4
.LC112:
	.string	"    #    #  ####        #    #    #  ####        #     ####  ###### "
	.text
	.globl	tic
	.type	tic, @function
tic:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$60, %esp
	movl	$0, -28(%ebp)
	jmp	.L235
.L236:
	movl	-28(%ebp), %eax
	movl	$3, p(,%eax,4)
	addl	$1, -28(%ebp)
.L235:
	cmpl	$8, -28(%ebp)
	jle	.L236
	movl	$0, tries
	call	clear
	call	clear_screen
	movl	$0, -32(%ebp)
	subl	$12, %esp
	pushl	$.LC106
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC107
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC108
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC109
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC110
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC111
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC112
	call	printf
	addl	$16, %esp
	jmp	.L237
.L238:
	addl	$1, -32(%ebp)
	subl	$12, %esp
	pushl	$.LC23
	call	printf
	addl	$16, %esp
.L237:
	cmpl	$64999999, -32(%ebp)
	jle	.L238
	call	clear
	call	clear_screen
	movl	$0, -44(%ebp)
	movb	$0, -33(%ebp)
.L239:
	cmpb	$0, -33(%ebp)
	je	.L240
	movb	$0, -33(%ebp)
	jmp	.L241
.L240:
	movl	tries, %eax
	addl	$1, %eax
	movl	%eax, tries
.L241:
	movl	tries, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$31, %eax
	addl	%eax, %edx
	andl	$1, %edx
	subl	%eax, %edx
	movl	%edx, -44(%ebp)
	call	checkwin
	testb	%al, %al
	je	.L242
	subl	$12, %esp
	pushl	-44(%ebp)
	call	win
	addl	$16, %esp
	jmp	.L243
.L242:
	movl	tries, %eax
	cmpl	$9, %eax
	jle	.L244
	subl	$12, %esp
	pushl	$-1
	call	win
	addl	$16, %esp
	jmp	.L243
.L244:
	call	getInput
	movl	%eax, -48(%ebp)
	cmpl	$.LC94, -48(%ebp)
	jne	.L245
	movl	p, %eax
	cmpl	$3, %eax
	jne	.L245
	movl	-44(%ebp), %eax
	movl	%eax, p
	jmp	.L246
.L245:
	cmpl	$.LC95, -48(%ebp)
	jne	.L247
	movl	p+4, %eax
	cmpl	$3, %eax
	jne	.L247
	movl	-44(%ebp), %eax
	movl	%eax, p+4
	jmp	.L246
.L247:
	cmpl	$.LC96, -48(%ebp)
	jne	.L248
	movl	p+8, %eax
	cmpl	$3, %eax
	jne	.L248
	movl	-44(%ebp), %eax
	movl	%eax, p+8
	jmp	.L246
.L248:
	cmpl	$.LC97, -48(%ebp)
	jne	.L249
	movl	p+12, %eax
	cmpl	$3, %eax
	jne	.L249
	movl	-44(%ebp), %eax
	movl	%eax, p+12
	jmp	.L246
.L249:
	cmpl	$.LC98, -48(%ebp)
	jne	.L250
	movl	p+16, %eax
	cmpl	$3, %eax
	jne	.L250
	movl	-44(%ebp), %eax
	movl	%eax, p+16
	jmp	.L246
.L250:
	cmpl	$.LC99, -48(%ebp)
	jne	.L251
	movl	p+20, %eax
	cmpl	$3, %eax
	jne	.L251
	movl	-44(%ebp), %eax
	movl	%eax, p+20
	jmp	.L246
.L251:
	cmpl	$.LC100, -48(%ebp)
	jne	.L252
	movl	p+24, %eax
	cmpl	$3, %eax
	jne	.L252
	movl	-44(%ebp), %eax
	movl	%eax, p+24
	jmp	.L246
.L252:
	cmpl	$.LC101, -48(%ebp)
	jne	.L253
	movl	p+28, %eax
	cmpl	$3, %eax
	jne	.L253
	movl	-44(%ebp), %eax
	movl	%eax, p+28
	jmp	.L246
.L253:
	cmpl	$.LC102, -48(%ebp)
	jne	.L254
	movl	p+32, %eax
	cmpl	$3, %eax
	jne	.L254
	movl	-44(%ebp), %eax
	movl	%eax, p+32
	jmp	.L246
.L254:
	movb	$1, -33(%ebp)
	jmp	.L239
.L246:
	movl	$0, -40(%ebp)
	movl	p+32, %edx
	movl	p+28, %ebx
	movl	p+24, %eax
	movl	%eax, -60(%ebp)
	movl	p+20, %ecx
	movl	%ecx, -64(%ebp)
	movl	p+16, %esi
	movl	%esi, -68(%ebp)
	movl	p+12, %edi
	movl	p+8, %esi
	movl	p+4, %ecx
	movl	p, %eax
	subl	$12, %esp
	pushl	%edx
	pushl	%ebx
	pushl	-60(%ebp)
	pushl	-64(%ebp)
	pushl	-68(%ebp)
	pushl	%edi
	pushl	%esi
	pushl	%ecx
	pushl	%eax
	call	render
	addl	$48, %esp
	jmp	.L255
.L256:
	addl	$1, -40(%ebp)
	subl	$12, %esp
	pushl	$.LC23
	call	printf
	addl	$16, %esp
.L255:
	cmpl	$34999999, -40(%ebp)
	jle	.L256
	call	clear
	call	clear_screen
	jmp	.L239
.L243:
	nop
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	tic, .-tic
	.globl	prtf
	.type	prtf, @function
prtf:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	nop
	leave
	ret
	.size	prtf, .-prtf
	.section	.rodata
	.align 4
.LC113:
	.string	"                             ,%@@@@@@@@@@@@@@@@@@@@@@%,     "
	.align 4
.LC114:
	.string	"                        ,&@@@@@@@&#*            *#&@@@@@@@&, "
	.align 4
.LC115:
	.string	"                     #@@@@@@/        *(%%&%#/,         /@@@@@@#    "
	.align 4
.LC116:
	.string	"                  /@@@@@(       *@@@@@@@@@@@@@@@@%         (@@@@@/  "
	.align 4
.LC117:
	.string	"                #@@@@#        #@@@@@@@@(**/#@@@@@@@@.         #@@@@#  "
	.align 4
.LC118:
	.string	"              /@@@@/        .@@@@@@&          ,@@@@@@%          *@@@@/    "
	.align 4
.LC119:
	.string	"             @@@@#         .@@@@@@*             @@@@@@&           #@@@@   "
	.align 4
.LC120:
	.string	"           .@@@@.          @@@@@@(               @@@@@@(           .@@@@. "
	.align 4
.LC121:
	.string	"           @@@@           (@@@@@@                *@@@@@@             @@@@.  "
	.align 4
.LC122:
	.string	"          @@@@.           &@@@@@%                 @@@@@@/            .@@@@  "
	.align 4
.LC123:
	.string	"         ,@@@%            @@@@@@*                 @@@@@@%             #@@@, "
	.align 4
.LC124:
	.string	"         %@@@,           .@@@@@@,                 @@@@@@&             ,@@@%  "
	.align 4
.LC125:
	.string	"         @@@@            ,@@@@@@,                 &@@@@@&              @@@@  "
	.align 4
.LC126:
	.string	"         &@@@.           .@@@@@@,                 @@@@@@%             .@@@&   "
	.align 4
.LC127:
	.string	"         /@@@(            @@@@@@/                 @@@@@@#             /@@@/  "
	.align 4
.LC128:
	.string	"          @@@@            %@@@@@&                .@@@@@@,             @@@@. "
	.align 4
.LC129:
	.string	"          *@@@%           *@@@@@@.               #@@@@@&             %@@@*  "
	.align 4
.LC130:
	.string	"           /@@@%           %@@@@@@              .@@@@@@,            %@@@(   "
	.align 4
.LC131:
	.string	"            *@@@@           &@@@@@@            .@@@@@@/            @@@@*  "
	.align 4
.LC132:
	.string	"             .@@@@#          #@@@@@@#        .@@@@@@@,           #@@@@. "
	.align 4
.LC133:
	.string	"               *@@@@%          &@@@@@@@@@@@@@@@@@@@/           #@@@@* "
	.align 4
.LC134:
	.string	"                 *@@@@@*         .&@@@@@@@@@@@@@(           *@@@@@* "
	.align 4
.LC135:
	.string	"                    %@@@@@#                              #@@@@@% "
	.align 4
.LC136:
	.string	"                       (@@@@@@@#.                  .#@@@@@@@#   "
	.align 4
.LC137:
	.string	"                           *@@@@@@@@@@@@@@@@@@@@@@@@@@@@* "
	.text
	.globl	zero
	.type	zero, @function
zero:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	subl	$12, %esp
	pushl	$.LC113
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC114
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC115
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC116
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC117
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC118
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC119
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC120
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC121
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC122
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC123
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC124
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC125
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC126
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC127
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC128
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC129
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC130
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC131
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC132
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC133
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC134
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC135
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC136
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC137
	call	prtf
	addl	$16, %esp
	nop
	leave
	ret
	.size	zero, .-zero
	.section	.rodata
	.align 4
.LC138:
	.string	"                           .(@@@@@@@@@@@@@@@@@@@@@@@@@@@(.  "
	.align 4
.LC139:
	.string	"                        #@@@@@@&/     ,@@@@@@&      /&@@@@@@# "
	.align 4
.LC140:
	.string	"                     %@@@@@(        /@@@@@@@@&           (@@@@@% "
	.align 4
.LC141:
	.string	"                  ,@@@@@*         #@@@@@@@@@@&              *@@@@@,  "
	.align 4
.LC142:
	.string	"                .@@@@%          &@@@@@@@@@@@@&                 %@@@@,"
	.align 4
.LC143:
	.string	"               %@@@&         .@@@@@@@. @@@@@@&                   &@@@% "
	.align 4
.LC144:
	.string	"              @@@@*         (@@@@@@    @@@@@@&                    ,@@@@   "
	.align 4
.LC145:
	.string	"             @@@@.            (@%      @@@@@@&                      @@@@ "
	.align 4
.LC146:
	.string	"            &@@@,                      @@@@@@&                      ,@@@& "
	.align 4
.LC147:
	.string	"           ,@@@#                       @@@@@@&                       #@@@,"
	.align 4
.LC148:
	.string	"           %@@@,                       @@@@@@&                       ,@@@%    "
	.align 4
.LC149:
	.string	"           @@@@                        @@@@@@&                        @@@@   "
	.align 4
.LC150:
	.string	"           &@@@.                       @@@@@@&                       .@@@&   "
	.align 4
.LC151:
	.string	"           /@@@(                       @@@@@@&                       /@@@/   "
	.align 4
.LC152:
	.string	"            @@@@                       @@@@@@&                       @@@@     "
	.align 4
.LC153:
	.string	"            ,@@@%                      @@@@@@&                      %@@@*  "
	.align 4
.LC154:
	.string	"             *@@@&                     @@@@@@&                     &@@@* "
	.align 4
.LC155:
	.string	"              ,@@@@,                   @@@@@@&                   ,@@@@,  "
	.align 4
.LC156:
	.string	"                %@@@@.       &@@@@@@@@@@@@@@@@@@@@@@@@@%       .@@@@& "
	.align 4
.LC157:
	.string	"                 .@@@@@*     &@@@@@@@@@@@@@@@@@@@@@@@@@%     *@@@@@.  "
	.align 4
.LC158:
	.string	"                    %@@@@@*  **************************,  ,@@@@@%  "
	.align 4
.LC159:
	.string	"                      .&@@@@@&*                       *&@@@@@&. "
	.align 4
.LC160:
	.string	"                          *@@@@@@@@@&%/,.   .,/#&@@@@@@@@@*    "
	.text
	.globl	one
	.type	one, @function
one:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	subl	$12, %esp
	pushl	$.LC138
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC139
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC140
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC141
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC142
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC143
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC144
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC145
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC146
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC147
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC148
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC149
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC150
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC151
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC152
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC153
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC154
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC155
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC156
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC157
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC158
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC159
	call	prtf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC160
	call	prtf
	addl	$16, %esp
	nop
	leave
	ret
	.size	one, .-one
	.globl	computer
	.section	.bss
	.type	computer, @object
	.size	computer, 1
computer:
	.zero	1
	.globl	human
	.type	human, @object
	.size	human, 1
human:
	.zero	1
	.text
	.globl	toss
	.type	toss, @function
toss:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$31, %eax
	addl	%eax, %edx
	andl	$1, %edx
	subl	%eax, %edx
	movl	%edx, -4(%ebp)
	cmpl	$0, -4(%ebp)
	jne	.L261
	movb	$1, computer
	movl	$0, %eax
	jmp	.L260
.L261:
	cmpl	$1, -4(%ebp)
	jne	.L263
	movb	$1, human
	movl	$1, %eax
	jmp	.L260
.L263:
.L260:
	leave
	ret
	.size	toss, .-toss
	.section	.rodata
.LC161:
	.string	"21"
.LC162:
	.string	"Human wins! Good Job!"
	.text
	.globl	comp
	.type	comp, @function
comp:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	call	rand
	movl	%eax, %ecx
	movl	$1431655766, %edx
	movl	%ecx, %eax
	imull	%edx
	movl	%edx, %ebx
	movl	%ecx, %edx
	sarl	$31, %edx
	movl	%ebx, %eax
	subl	%edx, %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	movl	%edx, -16(%ebp)
	movl	8(%ebp), %edx
	movl	-16(%ebp), %eax
	addl	%edx, %eax
	cmpl	$19, %eax
	jle	.L265
	subl	$12, %esp
	pushl	$.LC161
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC162
	call	printf
	addl	$16, %esp
	movl	$-1, %eax
	jmp	.L266
.L265:
	cmpl	$0, -16(%ebp)
	js	.L267
	movl	8(%ebp), %eax
	addl	$1, %eax
	subl	$12, %esp
	pushl	%eax
	call	printn
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	movl	8(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -12(%ebp)
.L267:
	cmpl	$0, -16(%ebp)
	jle	.L268
	movl	8(%ebp), %eax
	addl	$2, %eax
	subl	$12, %esp
	pushl	%eax
	call	printn
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	movl	8(%ebp), %eax
	addl	$2, %eax
	movl	%eax, -12(%ebp)
.L268:
	cmpl	$1, -16(%ebp)
	jle	.L269
	movl	8(%ebp), %eax
	addl	$3, %eax
	subl	$12, %esp
	pushl	%eax
	call	printn
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	movl	8(%ebp), %eax
	addl	$3, %eax
	movl	%eax, -12(%ebp)
.L269:
	cmpl	$20, -12(%ebp)
	jle	.L270
	subl	$12, %esp
	pushl	$.LC162
	call	printf
	addl	$16, %esp
	movl	$-1, %eax
	jmp	.L266
.L270:
	movl	-12(%ebp), %eax
.L266:
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	comp, .-comp
	.globl	memcpy
	.type	memcpy, @function
memcpy:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	8(%ebp), %eax
	movl	%eax, -8(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	$0, -4(%ebp)
	jmp	.L272
.L273:
	movl	-12(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movl	-8(%ebp), %ecx
	movl	-4(%ebp), %edx
	addl	%ecx, %edx
	movzbl	(%eax), %eax
	movb	%al, (%edx)
	addl	$1, -4(%ebp)
.L272:
	movl	-4(%ebp), %eax
	cmpl	16(%ebp), %eax
	jb	.L273
	movl	8(%ebp), %eax
	leave
	ret
	.size	memcpy, .-memcpy
	.globl	roots
	.data
	.align 32
	.type	roots, @object
	.size	roots, 1028
roots:
	.long	0
	.string	"Hello from root"
	.zero	1008
	.globl	info
	.align 32
	.type	info, @object
	.size	info, 1028
info:
	.long	1
	.string	"OS: NerdOS \n Version: v0.02 \"wren\" \n Devs: werdl;thisiscoding1234 \n Github: spartanproj/os"
	.zero	933
	.globl	root
	.section	.bss
	.align 32
	.type	root, @object
	.size	root, 11308
root:
	.zero	11308
	.text
	.globl	fsinit
	.type	fsinit, @function
fsinit:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	movl	$root+10280, %edx
	movl	$info, %ebx
	movl	$257, %eax
	movl	%edx, %edi
	movl	%ebx, %esi
	movl	%eax, %ecx
	rep movsl
	nop
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	fsinit, .-fsinit
	.globl	writefs
	.type	writefs, @function
writefs:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$1028, %esp
	movl	12(%ebp), %eax
	movb	%al, -1028(%ebp)
	cmpb	$119, -1028(%ebp)
	jne	.L277
	cmpl	$9, 16(%ebp)
	ja	.L278
	movl	16(%ebp), %eax
	sall	$2, %eax
	addl	$.L280, %eax
	movl	(%eax), %eax
	jmp	*%eax
	.section	.rodata
	.align 4
	.align 4
.L280:
	.long	.L289
	.long	.L288
	.long	.L287
	.long	.L286
	.long	.L285
	.long	.L284
	.long	.L283
	.long	.L282
	.long	.L281
	.long	.L279
	.text
.L289:
	pushl	$1024
	pushl	8(%ebp)
	pushl	$root+4
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L288:
	pushl	$1024
	pushl	8(%ebp)
	pushl	$root+1032
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L287:
	pushl	$1024
	pushl	8(%ebp)
	pushl	$root+2060
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L286:
	pushl	$1024
	pushl	8(%ebp)
	pushl	$root+3088
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L285:
	pushl	$1024
	pushl	8(%ebp)
	pushl	$root+4116
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L284:
	pushl	$1024
	pushl	8(%ebp)
	pushl	$root+5144
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L283:
	pushl	$1024
	pushl	8(%ebp)
	pushl	$root+6172
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L282:
	pushl	$1024
	pushl	8(%ebp)
	pushl	$root+7200
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L281:
	pushl	$1024
	pushl	8(%ebp)
	pushl	$root+8228
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L279:
	pushl	$1024
	pushl	8(%ebp)
	pushl	$root+9256
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L278:
	movl	$0, %eax
	jmp	.L276
.L277:
	cmpb	$97, -1028(%ebp)
	jne	.L291
	cmpl	$9, 16(%ebp)
	ja	.L291
	movl	16(%ebp), %eax
	sall	$2, %eax
	addl	$.L294, %eax
	movl	(%eax), %eax
	jmp	*%eax
	.section	.rodata
	.align 4
	.align 4
.L294:
	.long	.L303
	.long	.L302
	.long	.L301
	.long	.L300
	.long	.L299
	.long	.L298
	.long	.L297
	.long	.L296
	.long	.L295
	.long	.L293
	.text
.L303:
	pushl	$1024
	pushl	$root+4
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	memcpy
	addl	$12, %esp
	pushl	8(%ebp)
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	strcat
	addl	$8, %esp
	pushl	$1024
	pushl	%eax
	pushl	$root+4
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L302:
	pushl	$1024
	pushl	$root+1032
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	memcpy
	addl	$12, %esp
	pushl	8(%ebp)
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	strcat
	addl	$8, %esp
	pushl	$1024
	pushl	%eax
	pushl	$root+1032
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L301:
	pushl	$1024
	pushl	$root+2060
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	memcpy
	addl	$12, %esp
	pushl	8(%ebp)
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	strcat
	addl	$8, %esp
	pushl	$1024
	pushl	%eax
	pushl	$root+2060
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L300:
	pushl	$1024
	pushl	$root+3088
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	memcpy
	addl	$12, %esp
	pushl	8(%ebp)
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	strcat
	addl	$8, %esp
	pushl	$1024
	pushl	%eax
	pushl	$root+3088
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L299:
	pushl	$1024
	pushl	$root+4116
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	memcpy
	addl	$12, %esp
	pushl	8(%ebp)
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	strcat
	addl	$8, %esp
	pushl	$1024
	pushl	%eax
	pushl	$root+4116
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L298:
	pushl	$1024
	pushl	$root+5144
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	memcpy
	addl	$12, %esp
	pushl	8(%ebp)
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	strcat
	addl	$8, %esp
	pushl	$1024
	pushl	%eax
	pushl	$root+5144
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L297:
	pushl	$1024
	pushl	$root+6172
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	memcpy
	addl	$12, %esp
	pushl	8(%ebp)
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	strcat
	addl	$8, %esp
	pushl	$1024
	pushl	%eax
	pushl	$root+6172
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L296:
	pushl	$1024
	pushl	$root+7200
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	memcpy
	addl	$12, %esp
	pushl	8(%ebp)
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	strcat
	addl	$8, %esp
	pushl	$1024
	pushl	%eax
	pushl	$root+7200
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L295:
	pushl	$1024
	pushl	$root+8228
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	memcpy
	addl	$12, %esp
	pushl	8(%ebp)
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	strcat
	addl	$8, %esp
	pushl	$1024
	pushl	%eax
	pushl	$root+8228
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L293:
	pushl	$1024
	pushl	$root+9256
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	memcpy
	addl	$12, %esp
	pushl	8(%ebp)
	leal	-1024(%ebp), %eax
	pushl	%eax
	call	strcat
	addl	$8, %esp
	pushl	$1024
	pushl	%eax
	pushl	$root+9256
	call	memcpy
	addl	$12, %esp
	movl	$0, %eax
	jmp	.L276
.L291:
.L276:
	leave
	ret
	.size	writefs, .-writefs
	.globl	readfs
	.type	readfs, @function
readfs:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	cmpl	$9, 8(%ebp)
	ja	.L306
	movl	8(%ebp), %eax
	sall	$2, %eax
	addl	$.L308, %eax
	movl	(%eax), %eax
	jmp	*%eax
	.section	.rodata
	.align 4
	.align 4
.L308:
	.long	.L317
	.long	.L316
	.long	.L315
	.long	.L314
	.long	.L313
	.long	.L312
	.long	.L311
	.long	.L310
	.long	.L309
	.long	.L307
	.text
.L317:
	pushl	$1024
	pushl	$root+4
	pushl	-4(%ebp)
	call	memcpy
	addl	$12, %esp
.L316:
	pushl	$1024
	pushl	$root+1032
	pushl	-4(%ebp)
	call	memcpy
	addl	$12, %esp
.L315:
	pushl	$1024
	pushl	$root+2060
	pushl	-4(%ebp)
	call	memcpy
	addl	$12, %esp
.L314:
	pushl	$1024
	pushl	$root+3088
	pushl	-4(%ebp)
	call	memcpy
	addl	$12, %esp
.L313:
	pushl	$1024
	pushl	$root+4116
	pushl	-4(%ebp)
	call	memcpy
	addl	$12, %esp
.L312:
	pushl	$1024
	pushl	$root+5144
	pushl	-4(%ebp)
	call	memcpy
	addl	$12, %esp
.L311:
	pushl	$1024
	pushl	$root+6172
	pushl	-4(%ebp)
	call	memcpy
	addl	$12, %esp
.L310:
	pushl	$1024
	pushl	$root+7200
	pushl	-4(%ebp)
	call	memcpy
	addl	$12, %esp
.L309:
	pushl	$1024
	pushl	$root+8228
	pushl	-4(%ebp)
	call	memcpy
	addl	$12, %esp
.L307:
	pushl	$1024
	pushl	$root+9256
	pushl	-4(%ebp)
	call	memcpy
	addl	$12, %esp
.L306:
	movl	-4(%ebp), %eax
	leave
	ret
	.size	readfs, .-readfs
	.section	.rodata
.LC163:
	.string	"Contents of journal 0: "
.LC164:
	.string	"\nContents of journal 1: "
.LC165:
	.string	"\nContents of journal 2: "
.LC166:
	.string	"\nContents of journal 3: "
.LC167:
	.string	"\nContents of journal 4: "
.LC168:
	.string	"\nContents of journal 5: "
.LC169:
	.string	"\nContents of journal 6: "
.LC170:
	.string	"\nContents of journal 7: "
.LC171:
	.string	"\nContents of journal 8: "
.LC172:
	.string	"\nContents of journal 9: "
.LC173:
	.string	"\nContents of EAX: "
.LC174:
	.string	"\nContents of EBX: "
.LC175:
	.string	"\nContents of ECX: "
.LC176:
	.string	"\nContents of EDX: "
.LC177:
	.string	"\nContents of stack pointer: "
	.align 4
.LC178:
	.string	"\nContents of stack base pointer: "
.LC179:
	.string	"\nContents of source: "
.LC180:
	.string	"\nContents of destination: "
	.align 4
.LC181:
	.string	"\nTry restarting your computer\n"
	.align 4
.LC182:
	.string	"_   _              _ _____ _____  ______ _____ ___________ _ "
	.align 4
.LC183:
	.string	"\n| \\ | |            | |  _  /  ___| | ___ /  ___|  _  |  _  | |"
	.align 4
.LC184:
	.string	"\n|  \\| | ___ _ __ __| | | | \\ `--.  | |_/ \\ `--.| | | | | | | |"
	.align 4
.LC185:
	.string	"\n| . ` |/ _ | '__/ _` | | | |`--. \\ | ___ \\`--. | | | | | | | |"
	.align 4
.LC186:
	.string	"\n| |\\  |  __| | | (_| \\ \\_/ /\\__/ / | |_/ /\\__/ \\ \\_/ | |/ /|_|"
	.align 4
.LC187:
	.string	"\n\\_| \\_/\\___|_|  \\__,_|\\___/\\____/  \\____/\\____/ \\___/|___/ (_)"
	.text
	.globl	dump
	.type	dump, @function
dump:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$28, %esp
	movl	$0, terminal_row
	movl	$0, terminal_column
	pushl	$9
	pushl	$15
	call	vga_entry_color
	addl	$8, %esp
	movb	%al, terminal_color
	movl	$753664, terminal_buffer
	movl	$0, -28(%ebp)
	jmp	.L320
.L323:
	movl	$0, -32(%ebp)
	jmp	.L321
.L322:
	movl	$80, %eax
	imull	-28(%ebp), %eax
	movl	%eax, %edx
	movl	-32(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -36(%ebp)
	movzbl	terminal_color, %eax
	movzbl	%al, %eax
	movl	terminal_buffer, %edx
	movl	-36(%ebp), %ecx
	addl	%ecx, %ecx
	leal	(%edx,%ecx), %ebx
	pushl	%eax
	pushl	$32
	call	vga_entry
	addl	$8, %esp
	movw	%ax, (%ebx)
	addl	$1, -32(%ebp)
.L321:
	movl	$80, %eax
	cmpl	%eax, -32(%ebp)
	jb	.L322
	addl	$1, -28(%ebp)
.L320:
	movl	$25, %eax
	cmpl	%eax, -28(%ebp)
	jb	.L323
	subl	$12, %esp
	pushl	$.LC163
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+4
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC164
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+1032
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC165
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+2060
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC166
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+3088
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC167
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+4116
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC168
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+5144
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC169
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+6172
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC170
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+7200
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC171
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+8228
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC172
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+9256
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC173
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	%eax
	call	printh
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC174
	call	printf
	addl	$16, %esp
	movl	%ecx, %eax
	subl	$12, %esp
	pushl	%eax
	call	printh
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC175
	call	printf
	addl	$16, %esp
	movl	%ecx, %eax
	subl	$12, %esp
	pushl	%eax
	call	printh
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC176
	call	printf
	addl	$16, %esp
	movl	%edx, %eax
	subl	$12, %esp
	pushl	%eax
	call	printh
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC177
	call	printf
	addl	$16, %esp
	movl	%esp, %eax
	subl	$12, %esp
	pushl	%eax
	call	printh
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC178
	call	printf
	addl	$16, %esp
	movl	%ebp, %eax
	subl	$12, %esp
	pushl	%eax
	call	printh
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC179
	call	printf
	addl	$16, %esp
	movl	%esi, %eax
	subl	$12, %esp
	pushl	%eax
	call	printh
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC180
	call	printf
	addl	$16, %esp
	movl	%edi, %eax
	subl	$12, %esp
	pushl	%eax
	call	printh
	addl	$16, %esp
	subl	$8, %esp
	pushl	$9
	pushl	$4
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC181
	call	printf
	addl	$16, %esp
	subl	$8, %esp
	pushl	$9
	pushl	$15
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC182
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC183
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC184
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC185
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC186
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC187
	call	printf
	addl	$16, %esp
	nop
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	dump, .-dump
	.globl	currentnode
	.section	.bss
	.align 4
	.type	currentnode, @object
	.size	currentnode, 4
currentnode:
	.zero	4
	.section	.rodata
	.align 4
.LC188:
	.string	"Warning: Overwriting data in node 0 due to overflow\n"
	.text
	.globl	log
	.type	log, @function
log:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	currentnode, %eax
	cmpl	$9, %eax
	jne	.L325
	movl	$0, currentnode
	subl	$12, %esp
	pushl	$.LC188
	call	printf
	addl	$16, %esp
	call	mse_nl
.L325:
	movl	currentnode, %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$119
	pushl	8(%ebp)
	call	writefs
	addl	$16, %esp
	movl	currentnode, %eax
	addl	$1, %eax
	movl	%eax, currentnode
	nop
	leave
	ret
	.size	log, .-log
	.section	.rodata
.LC189:
	.string	":"
	.text
	.globl	printtime
	.type	printtime, @function
printtime:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	8(%ebp), %eax
	movb	%al, -28(%ebp)
	subl	$8, %esp
	pushl	$4
	pushl	$112
	call	write_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	read_port
	addl	$16, %esp
	movsbl	%al, %eax
	movl	%eax, -12(%ebp)
	cmpl	$9, -12(%ebp)
	jg	.L327
	subl	$12, %esp
	pushl	$.LC1
	call	printf
	addl	$16, %esp
.L327:
	subl	$12, %esp
	pushl	-12(%ebp)
	call	printhx
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC189
	call	printf
	addl	$16, %esp
	subl	$8, %esp
	pushl	$2
	pushl	$112
	call	write_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	read_port
	addl	$16, %esp
	movsbl	%al, %eax
	movl	%eax, -12(%ebp)
	cmpl	$9, -12(%ebp)
	jg	.L328
	subl	$12, %esp
	pushl	$.LC1
	call	printf
	addl	$16, %esp
.L328:
	subl	$12, %esp
	pushl	-12(%ebp)
	call	printhx
	addl	$16, %esp
	cmpb	$0, -28(%ebp)
	je	.L331
	subl	$12, %esp
	pushl	$.LC189
	call	printf
	addl	$16, %esp
	subl	$8, %esp
	pushl	$0
	pushl	$112
	call	write_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	read_port
	addl	$16, %esp
	movsbl	%al, %eax
	movl	%eax, -12(%ebp)
	cmpl	$9, -12(%ebp)
	jg	.L330
	subl	$12, %esp
	pushl	$.LC1
	call	printf
	addl	$16, %esp
.L330:
	subl	$12, %esp
	pushl	-12(%ebp)
	call	printhx
	addl	$16, %esp
.L331:
	nop
	leave
	ret
	.size	printtime, .-printtime
	.section	.rodata
.LC190:
	.string	" - "
.LC191:
	.string	"Monday"
.LC192:
	.string	"Tuesday"
.LC193:
	.string	"Wednesday"
.LC194:
	.string	"Thursday"
.LC195:
	.string	"Friday"
.LC196:
	.string	"Saturday"
.LC197:
	.string	"Sunday"
.LC198:
	.string	"January"
.LC199:
	.string	"February"
.LC200:
	.string	"March"
.LC201:
	.string	"April"
.LC202:
	.string	"May"
.LC203:
	.string	"June"
.LC204:
	.string	"July"
.LC205:
	.string	"August"
.LC206:
	.string	"September"
.LC207:
	.string	"October"
.LC208:
	.string	"November"
.LC209:
	.string	"December"
	.text
	.globl	printdate
	.type	printdate, @function
printdate:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	subl	$12, %esp
	pushl	$1
	call	printtime
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC190
	call	printf
	addl	$16, %esp
	subl	$8, %esp
	pushl	$6
	pushl	$112
	call	write_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	read_port
	addl	$16, %esp
	movsbl	%al, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	subl	$1, %eax
	cmpl	$6, %eax
	ja	.L333
	movl	.L335(,%eax,4), %eax
	jmp	*%eax
	.section	.rodata
	.align 4
	.align 4
.L335:
	.long	.L341
	.long	.L340
	.long	.L339
	.long	.L338
	.long	.L337
	.long	.L336
	.long	.L334
	.text
.L340:
	subl	$12, %esp
	pushl	$.LC191
	call	printf
	addl	$16, %esp
	jmp	.L333
.L339:
	subl	$12, %esp
	pushl	$.LC192
	call	printf
	addl	$16, %esp
	jmp	.L333
.L338:
	subl	$12, %esp
	pushl	$.LC193
	call	printf
	addl	$16, %esp
	jmp	.L333
.L337:
	subl	$12, %esp
	pushl	$.LC194
	call	printf
	addl	$16, %esp
	jmp	.L333
.L336:
	subl	$12, %esp
	pushl	$.LC195
	call	printf
	addl	$16, %esp
	jmp	.L333
.L334:
	subl	$12, %esp
	pushl	$.LC196
	call	printf
	addl	$16, %esp
	jmp	.L333
.L341:
	subl	$12, %esp
	pushl	$.LC197
	call	printf
	addl	$16, %esp
	nop
.L333:
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$8, %esp
	pushl	$7
	pushl	$112
	call	write_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	read_port
	addl	$16, %esp
	movsbl	%al, %eax
	movl	%eax, -12(%ebp)
	subl	$12, %esp
	pushl	-12(%ebp)
	call	printhx
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$8, %esp
	pushl	$8
	pushl	$112
	call	write_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	read_port
	addl	$16, %esp
	movsbl	%al, %eax
	movl	%eax, -12(%ebp)
	cmpl	$12, -12(%ebp)
	ja	.L342
	movl	-12(%ebp), %eax
	sall	$2, %eax
	addl	$.L344, %eax
	movl	(%eax), %eax
	jmp	*%eax
	.section	.rodata
	.align 4
	.align 4
.L344:
	.long	.L342
	.long	.L355
	.long	.L354
	.long	.L353
	.long	.L352
	.long	.L351
	.long	.L350
	.long	.L349
	.long	.L348
	.long	.L347
	.long	.L346
	.long	.L345
	.long	.L343
	.text
.L355:
	subl	$12, %esp
	pushl	$.LC198
	call	printf
	addl	$16, %esp
	jmp	.L342
.L354:
	subl	$12, %esp
	pushl	$.LC199
	call	printf
	addl	$16, %esp
	jmp	.L342
.L353:
	subl	$12, %esp
	pushl	$.LC200
	call	printf
	addl	$16, %esp
	jmp	.L342
.L352:
	subl	$12, %esp
	pushl	$.LC201
	call	printf
	addl	$16, %esp
	jmp	.L342
.L351:
	subl	$12, %esp
	pushl	$.LC202
	call	printf
	addl	$16, %esp
	jmp	.L342
.L350:
	subl	$12, %esp
	pushl	$.LC203
	call	printf
	addl	$16, %esp
	jmp	.L342
.L349:
	subl	$12, %esp
	pushl	$.LC204
	call	printf
	addl	$16, %esp
	jmp	.L342
.L348:
	subl	$12, %esp
	pushl	$.LC205
	call	printf
	addl	$16, %esp
	jmp	.L342
.L347:
	subl	$12, %esp
	pushl	$.LC206
	call	printf
	addl	$16, %esp
	jmp	.L342
.L346:
	subl	$12, %esp
	pushl	$.LC207
	call	printf
	addl	$16, %esp
	jmp	.L342
.L345:
	subl	$12, %esp
	pushl	$.LC208
	call	printf
	addl	$16, %esp
	jmp	.L342
.L343:
	subl	$12, %esp
	pushl	$.LC209
	call	printf
	addl	$16, %esp
	nop
.L342:
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$8, %esp
	pushl	$50
	pushl	$112
	call	write_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	read_port
	addl	$16, %esp
	movsbl	%al, %eax
	movl	%eax, -12(%ebp)
	subl	$12, %esp
	pushl	-12(%ebp)
	call	printhx
	addl	$16, %esp
	subl	$8, %esp
	pushl	$9
	pushl	$112
	call	write_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	read_port
	addl	$16, %esp
	movsbl	%al, %eax
	movl	%eax, -12(%ebp)
	subl	$12, %esp
	pushl	-12(%ebp)
	call	printhx
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	call	mse_nl
	nop
	leave
	ret
	.size	printdate, .-printdate
	.globl	sleep
	.type	sleep, @function
sleep:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	subl	$8, %esp
	pushl	$0
	pushl	$112
	call	write_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	read_port
	addl	$16, %esp
	movsbl	%al, %eax
	movl	%eax, -12(%ebp)
.L359:
	subl	$8, %esp
	pushl	$0
	pushl	$112
	call	write_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	read_port
	addl	$16, %esp
	movsbl	%al, %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	subl	-12(%ebp), %eax
	cmpl	%eax, 8(%ebp)
	jle	.L361
	jmp	.L359
.L361:
	nop
	nop
	leave
	ret
	.size	sleep, .-sleep
	.globl	time
	.type	time, @function
time:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$10136, %esp
	subl	$8, %esp
	pushl	$0
	pushl	$112
	call	write_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	read_port
	addl	$16, %esp
	movsbl	%al, %eax
	movl	%eax, -12(%ebp)
	subl	$4, %esp
	pushl	$16
	leal	-31(%ebp), %eax
	pushl	%eax
	pushl	-12(%ebp)
	call	itoa
	addl	$16, %esp
	subl	$12, %esp
	leal	-31(%ebp), %eax
	pushl	%eax
	call	atoi
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	addl	%eax, -16(%ebp)
	subl	$8, %esp
	pushl	$2
	pushl	$112
	call	write_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	read_port
	addl	$16, %esp
	movsbl	%al, %eax
	movl	%eax, -12(%ebp)
	subl	$4, %esp
	pushl	$16
	leal	-131(%ebp), %eax
	pushl	%eax
	pushl	-12(%ebp)
	call	itoa
	addl	$16, %esp
	subl	$12, %esp
	leal	-131(%ebp), %eax
	pushl	%eax
	call	atoi
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	imull	$60, %eax, %eax
	addl	%eax, -16(%ebp)
	subl	$8, %esp
	pushl	$4
	pushl	$112
	call	write_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	read_port
	addl	$16, %esp
	movsbl	%al, %eax
	movl	%eax, -12(%ebp)
	subl	$4, %esp
	pushl	$16
	leal	-10131(%ebp), %eax
	pushl	%eax
	pushl	-12(%ebp)
	call	itoa
	addl	$16, %esp
	subl	$12, %esp
	leal	-10131(%ebp), %eax
	pushl	%eax
	call	atoi
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	imull	$3600, %eax, %eax
	addl	%eax, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	printn
	addl	$16, %esp
	nop
	leave
	ret
	.size	time, .-time
	.globl	placement_addr
	.data
	.align 4
	.type	placement_addr, @object
	.size	placement_addr, 4
placement_addr:
	.long	end
	.text
	.globl	kmalloc_internal
	.type	kmalloc_internal, @function
kmalloc_internal:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	cmpl	$1, 12(%ebp)
	jne	.L364
	movl	placement_addr, %eax
	cmpl	$4095, %eax
	jbe	.L364
	movl	placement_addr, %eax
	andl	$-4096, %eax
	movl	%eax, placement_addr
	movl	placement_addr, %eax
	addl	$4096, %eax
	movl	%eax, placement_addr
.L364:
	cmpl	$0, 16(%ebp)
	je	.L365
	movl	placement_addr, %edx
	movl	16(%ebp), %eax
	movl	%edx, (%eax)
.L365:
	movl	placement_addr, %eax
	movl	%eax, -4(%ebp)
	movl	placement_addr, %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, placement_addr
	movl	-4(%ebp), %eax
	leave
	ret
	.size	kmalloc_internal, .-kmalloc_internal
	.globl	kmalloc_a
	.type	kmalloc_a, @function
kmalloc_a:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	$0
	pushl	$1
	pushl	8(%ebp)
	call	kmalloc_internal
	addl	$12, %esp
	leave
	ret
	.size	kmalloc_a, .-kmalloc_a
	.globl	kmalloc_p
	.type	kmalloc_p, @function
kmalloc_p:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	12(%ebp)
	pushl	$0
	pushl	8(%ebp)
	call	kmalloc_internal
	addl	$12, %esp
	leave
	ret
	.size	kmalloc_p, .-kmalloc_p
	.globl	kmalloc_ap
	.type	kmalloc_ap, @function
kmalloc_ap:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	12(%ebp)
	pushl	$1
	pushl	8(%ebp)
	call	kmalloc_internal
	addl	$12, %esp
	leave
	ret
	.size	kmalloc_ap, .-kmalloc_ap
	.globl	kmalloc
	.type	kmalloc, @function
kmalloc:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	$0
	pushl	$0
	pushl	8(%ebp)
	call	kmalloc_internal
	addl	$12, %esp
	leave
	ret
	.size	kmalloc, .-kmalloc
	.globl	memcmp
	.type	memcmp, @function
memcmp:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	8(%ebp), %eax
	movl	%eax, -8(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	$0, -4(%ebp)
	jmp	.L376
.L380:
	movl	-8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %edx
	movl	-12(%ebp), %ecx
	movl	-4(%ebp), %eax
	addl	%ecx, %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	jnb	.L377
	movl	$-1, %eax
	jmp	.L378
.L377:
	movl	-12(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %edx
	movl	-8(%ebp), %ecx
	movl	-4(%ebp), %eax
	addl	%ecx, %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	jnb	.L379
	movl	$1, %eax
	jmp	.L378
.L379:
	addl	$1, -4(%ebp)
.L376:
	movl	-4(%ebp), %eax
	cmpl	16(%ebp), %eax
	jb	.L380
	movl	$0, %eax
.L378:
	leave
	ret
	.size	memcmp, .-memcmp
	.section	.rodata
.LC210:
	.string	"Maximum file length exceeded"
.LC211:
	.string	"content > FILE_MAX"
	.text
	.globl	create_readonly
	.type	create_readonly, @function
create_readonly:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	pushl	8(%ebp)
	call	strlen
	addl	$4, %esp
	cmpl	$65535, %eax
	jbe	.L382
	subl	$4, %esp
	pushl	$0
	pushl	$.LC210
	pushl	$.LC211
	call	panic
	addl	$16, %esp
.L382:
	subl	$12, %esp
	pushl	12(%ebp)
	call	strlen
	addl	$16, %esp
	cmpl	$16383, %eax
	jbe	.L383
	subl	$4, %esp
	pushl	$0
	pushl	$.LC210
	pushl	$.LC211
	call	panic
	addl	$16, %esp
.L383:
	movl	16(%ebp), %eax
	movb	$1, (%eax)
	movl	16(%ebp), %eax
	movb	$0, 1(%eax)
	movl	16(%ebp), %eax
	movb	$0, 2(%eax)
	movl	16(%ebp), %eax
	movl	$0, 4(%eax)
	movl	16(%ebp), %eax
	movl	$1, 8(%eax)
	movl	16(%ebp), %eax
	movb	$0, 12(%eax)
	movl	16(%ebp), %eax
	movb	$0, 13(%eax)
	movl	16(%ebp), %eax
	movl	$65535, 16(%eax)
	movl	16(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, 20(%eax)
	movl	16(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, 24(%eax)
	movl	$0, %eax
	leave
	ret
	.size	create_readonly, .-create_readonly
	.globl	head
	.section	.bss
	.align 4
	.type	head, @object
	.size	head, 4
head:
	.zero	4
	.globl	current
	.align 4
	.type	current, @object
	.size	current, 4
current:
	.zero	4
	.section	.rodata
.LC212:
	.string	"=>"
	.text
	.globl	printlist
	.type	printlist, @function
printlist:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	head, %eax
	movl	%eax, -12(%ebp)
	jmp	.L386
.L387:
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	movl	-12(%ebp), %eax
	movl	24(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC212
	call	printf
	addl	$16, %esp
	movl	-12(%ebp), %eax
	movl	20(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	printf
	addl	$16, %esp
	movl	-12(%ebp), %eax
	movl	28(%eax), %eax
	movl	%eax, -12(%ebp)
.L386:
	cmpl	$0, -12(%ebp)
	jne	.L387
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	nop
	leave
	ret
	.size	printlist, .-printlist
	.section	.rodata
.LC213:
	.string	"Not found"
	.text
	.globl	search
	.type	search, @function
search:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	head, %eax
	movl	%eax, -4(%ebp)
	jmp	.L389
.L392:
	pushl	8(%ebp)
	call	strlen
	addl	$4, %esp
	movl	-4(%ebp), %edx
	movl	24(%edx), %edx
	pushl	%eax
	pushl	8(%ebp)
	pushl	%edx
	call	memcmp
	addl	$12, %esp
	testl	%eax, %eax
	jne	.L390
	movl	-4(%ebp), %eax
	movl	20(%eax), %eax
	jmp	.L391
.L390:
	movl	-4(%ebp), %eax
	movl	28(%eax), %eax
	movl	%eax, -4(%ebp)
.L389:
	cmpl	$0, -4(%ebp)
	jne	.L392
	movl	$.LC213, %eax
.L391:
	leave
	ret
	.size	search, .-search
	.globl	insert
	.type	insert, @function
insert:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	pushl	$32
	call	kmalloc
	addl	$4, %esp
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, (%eax)
	movl	12(%ebp), %edx
	movl	%edx, 4(%eax)
	movl	16(%ebp), %edx
	movl	%edx, 8(%eax)
	movl	20(%ebp), %edx
	movl	%edx, 12(%eax)
	movl	24(%ebp), %edx
	movl	%edx, 16(%eax)
	movl	28(%ebp), %edx
	movl	%edx, 20(%eax)
	movl	32(%ebp), %edx
	movl	%edx, 24(%eax)
	movl	head, %edx
	movl	-4(%ebp), %eax
	movl	%edx, 28(%eax)
	movl	-4(%ebp), %eax
	movl	%eax, head
	nop
	leave
	ret
	.size	insert, .-insert
	.globl	fil_test1txt
	.section	.bss
	.align 4
	.type	fil_test1txt, @object
	.size	fil_test1txt, 28
fil_test1txt:
	.zero	28
	.globl	fil_colorconf
	.align 4
	.type	fil_colorconf, @object
	.size	fil_colorconf, 28
fil_colorconf:
	.zero	28
	.globl	fil_test2txt
	.align 4
	.type	fil_test2txt, @object
	.size	fil_test2txt, 28
fil_test2txt:
	.zero	28
	.section	.rodata
.LC214:
	.string	"test1.txt"
.LC215:
	.string	"hellO!\n hi"
.LC216:
	.string	"color.conf"
.LC217:
	.string	"BW"
.LC218:
	.string	"test2.txt"
.LC219:
	.string	"bjasbj"
	.text
	.globl	createfiles
	.type	createfiles, @function
createfiles:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	subl	$4, %esp
	pushl	$fil_test1txt
	pushl	$.LC214
	pushl	$.LC215
	call	create_readonly
	addl	$16, %esp
	subl	$4, %esp
	pushl	fil_test1txt+24
	pushl	fil_test1txt+20
	pushl	fil_test1txt+16
	pushl	fil_test1txt+12
	pushl	fil_test1txt+8
	pushl	fil_test1txt+4
	pushl	fil_test1txt
	call	insert
	addl	$32, %esp
	subl	$4, %esp
	pushl	$fil_colorconf
	pushl	$.LC216
	pushl	$.LC217
	call	create_readonly
	addl	$16, %esp
	subl	$4, %esp
	pushl	fil_colorconf+24
	pushl	fil_colorconf+20
	pushl	fil_colorconf+16
	pushl	fil_colorconf+12
	pushl	fil_colorconf+8
	pushl	fil_colorconf+4
	pushl	fil_colorconf
	call	insert
	addl	$32, %esp
	subl	$4, %esp
	pushl	$fil_test2txt
	pushl	$.LC218
	pushl	$.LC219
	call	create_readonly
	addl	$16, %esp
	subl	$4, %esp
	pushl	fil_test2txt+24
	pushl	fil_test2txt+20
	pushl	fil_test2txt+16
	pushl	fil_test2txt+12
	pushl	fil_test2txt+8
	pushl	fil_test2txt+4
	pushl	fil_test2txt
	call	insert
	addl	$32, %esp
	nop
	leave
	ret
	.size	createfiles, .-createfiles
	.globl	DEFTYPE
	.data
	.align 4
	.type	DEFTYPE, @object
	.size	DEFTYPE, 4
DEFTYPE:
	.long	10
	.globl	DEFCOL
	.align 4
	.type	DEFCOL, @object
	.size	DEFCOL, 4
DEFCOL:
	.long	2
	.globl	history
	.section	.bss
	.align 4
	.type	history, @object
	.size	history, 4
history:
	.zero	4
	.globl	counter
	.align 4
	.type	counter, @object
	.size	counter, 4
counter:
	.zero	4
	.globl	printrn
	.type	printrn, @object
	.size	printrn, 1
printrn:
	.zero	1
	.globl	debug
	.data
	.type	debug, @object
	.size	debug, 1
debug:
	.byte	1
	.globl	x_gui
	.section	.bss
	.align 4
	.type	x_gui, @object
	.size	x_gui, 4
x_gui:
	.zero	4
	.globl	y_gui
	.align 4
	.type	y_gui, @object
	.size	y_gui, 4
y_gui:
	.zero	4
	.globl	cmdstyped
	.align 4
	.type	cmdstyped, @object
	.size	cmdstyped, 4
cmdstyped:
	.zero	4
	.globl	typed
	.align 32
	.type	typed, @object
	.size	typed, 4096
typed:
	.zero	4096
	.globl	typed2
	.align 32
	.type	typed2, @object
	.size	typed2, 1024
typed2:
	.zero	1024
	.globl	position
	.section	.rodata
.LC220:
	.string	"0,0"
.LC221:
	.string	"1,0"
.LC222:
	.string	"2,0"
.LC223:
	.string	"0,1"
.LC224:
	.string	"1,1"
.LC225:
	.string	"2,1"
.LC226:
	.string	"0,2"
.LC227:
	.string	"1,2"
.LC228:
	.string	"2,2"
	.data
	.align 32
	.type	position, @object
	.size	position, 36
position:
	.long	.LC220
	.long	.LC221
	.long	.LC222
	.long	.LC223
	.long	.LC224
	.long	.LC225
	.long	.LC226
	.long	.LC227
	.long	.LC228
	.text
	.globl	checkclr
	.type	checkclr, @function
checkclr:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	pushl	8(%ebp)
	call	strlen
	addl	$4, %esp
	movl	%eax, %ebx
	pushl	$.LC216
	call	search
	addl	$4, %esp
	pushl	%ebx
	pushl	8(%ebp)
	pushl	%eax
	call	memcmp
	addl	$12, %esp
	testl	%eax, %eax
	setne	%al
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	checkclr, .-checkclr
	.section	.rodata
.LC229:
	.string	"HEY"
	.align 4
.LC230:
	.string	"Warning: Journal entries being overwritten\n"
.LC231:
	.string	"ENTER"
.LC232:
	.string	""
.LC233:
	.string	" - hex value - 0x"
	.text
	.globl	keyboard_handler_main
	.type	keyboard_handler_main, @function
keyboard_handler_main:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	call	createfiles
	subl	$12, %esp
	pushl	$.LC217
	call	checkclr
	addl	$16, %esp
	testb	%al, %al
	je	.L398
	subl	$12, %esp
	pushl	$.LC229
	call	printf
	addl	$16, %esp
.L398:
	movl	$8, DEFTYPE
	movl	$7, DEFCOL
	subl	$8, %esp
	pushl	$32
	pushl	$32
	call	write_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$100
	call	read_port
	addl	$16, %esp
	movb	%al, -13(%ebp)
	movzbl	-13(%ebp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L397
	subl	$12, %esp
	pushl	$96
	call	read_port
	addl	$16, %esp
	movb	%al, -14(%ebp)
	cmpb	$0, -14(%ebp)
	js	.L410
	cmpb	$28, -14(%ebp)
	jne	.L401
	call	mse_nl
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	movl	currentnode, %eax
	cmpl	$9, %eax
	jne	.L402
	movzbl	debug, %eax
	testb	%al, %al
	je	.L403
	subl	$12, %esp
	pushl	$.LC230
	call	printf
	addl	$16, %esp
.L403:
	movl	$0, currentnode
	jmp	.L404
.L402:
	movl	currentnode, %eax
	addl	$1, %eax
	movl	%eax, currentnode
.L404:
	movl	cmdstyped, %eax
	addl	$1, %eax
	movl	%eax, cmdstyped
	movl	counter, %eax
	movl	$.LC231, typed(,%eax,4)
	movl	$0, counter
	jmp	.L397
.L401:
	movsbl	-14(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	keys
	addl	$16, %esp
	cmpl	$.LC30, %eax
	jne	.L405
	movl	$0, -12(%ebp)
	jmp	.L406
.L407:
	movl	-12(%ebp), %eax
	movl	$.LC232, typed(,%eax,4)
	addl	$1, -12(%ebp)
.L406:
	cmpl	$1023, -12(%ebp)
	jle	.L407
	jmp	.L397
.L405:
	movsbl	-14(%ebp), %eax
	movl	counter, %ebx
	subl	$12, %esp
	pushl	%eax
	call	keys
	addl	$16, %esp
	movl	%eax, typed(,%ebx,4)
	movl	counter, %eax
	addl	$1, %eax
	movl	%eax, counter
	movsbl	-14(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	keys
	addl	$16, %esp
	movl	%eax, -20(%ebp)
	movl	currentnode, %ebx
	movsbl	-14(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	keys
	addl	$16, %esp
	subl	$4, %esp
	pushl	%ebx
	pushl	$97
	pushl	%eax
	call	writefs
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	move
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L408
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	movl	x_gui, %eax
	subl	$12, %esp
	pushl	%eax
	call	prnt
	addl	$16, %esp
	subl	$12, %esp
	pushl	%eax
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC67
	call	printf
	addl	$16, %esp
	movl	y_gui, %eax
	subl	$12, %esp
	pushl	%eax
	call	prnt
	addl	$16, %esp
	subl	$12, %esp
	pushl	%eax
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	movl	y_gui, %edx
	movl	x_gui, %ecx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	addl	%ecx, %eax
	movl	position(,%eax,4), %eax
	subl	$12, %esp
	pushl	%eax
	call	printf
	addl	$16, %esp
	call	mse_nl
	call	mse_nl
	call	mse_nl
.L408:
	movzbl	printrn, %eax
	testb	%al, %al
	je	.L409
	movsbl	-14(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	keys
	addl	$16, %esp
	subl	$12, %esp
	pushl	%eax
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC233
	call	printf
	addl	$16, %esp
	movsbl	-14(%ebp), %eax
	subl	$4, %esp
	pushl	$10
	leal	-35(%ebp), %edx
	pushl	%edx
	pushl	%eax
	call	itoa
	addl	$16, %esp
	subl	$12, %esp
	leal	-35(%ebp), %eax
	pushl	%eax
	call	printf
	addl	$16, %esp
.L409:
	movl	DEFTYPE, %eax
	subl	$8, %esp
	pushl	$0
	pushl	%eax
	call	setclr
	addl	$16, %esp
	movsbl	-14(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	keys
	addl	$16, %esp
	subl	$12, %esp
	pushl	%eax
	call	printf
	addl	$16, %esp
	movl	DEFCOL, %eax
	subl	$8, %esp
	pushl	$0
	pushl	%eax
	call	setclr
	addl	$16, %esp
	jmp	.L397
.L410:
	nop
.L397:
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	keyboard_handler_main, .-keyboard_handler_main
	.globl	dellast
	.type	dellast, @function
dellast:
	pushl	%ebp
	movl	%esp, %ebp
	movl	counter, %eax
	movl	$.LC23, typed(,%eax,4)
	movl	counter, %eax
	subl	$1, %eax
	movl	%eax, counter
	nop
	popl	%ebp
	ret
	.size	dellast, .-dellast
	.globl	move
	.type	move, @function
move:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movb	$0, -1(%ebp)
	movb	$1, -2(%ebp)
	movb	$1, -3(%ebp)
	movb	$1, -4(%ebp)
	movb	$1, -5(%ebp)
	movl	y_gui, %eax
	movl	%eax, -12(%ebp)
	movl	x_gui, %eax
	movl	%eax, -16(%ebp)
	movl	y_gui, %eax
	cmpl	$1, %eax
	jle	.L413
	movb	$0, -2(%ebp)
	jmp	.L414
.L413:
	movl	y_gui, %eax
	testl	%eax, %eax
	jg	.L414
	movb	$0, -3(%ebp)
.L414:
	movl	x_gui, %eax
	cmpl	$1, %eax
	jle	.L415
	movb	$0, -5(%ebp)
	jmp	.L416
.L415:
	movl	x_gui, %eax
	testl	%eax, %eax
	jg	.L416
	movb	$0, -4(%ebp)
.L416:
	cmpl	$.LC85, 8(%ebp)
	jne	.L417
	cmpb	$0, -2(%ebp)
	je	.L417
	movl	y_gui, %eax
	addl	$1, %eax
	movl	%eax, y_gui
	jmp	.L418
.L417:
	cmpl	$.LC88, 8(%ebp)
	jne	.L419
	cmpb	$0, -3(%ebp)
	je	.L419
	movl	y_gui, %eax
	subl	$1, %eax
	movl	%eax, y_gui
	jmp	.L418
.L419:
	cmpl	$.LC87, 8(%ebp)
	jne	.L420
	cmpb	$0, -5(%ebp)
	je	.L420
	movl	x_gui, %eax
	addl	$1, %eax
	movl	%eax, x_gui
	jmp	.L418
.L420:
	cmpl	$.LC86, 8(%ebp)
	jne	.L421
	cmpb	$0, -4(%ebp)
	je	.L421
	movl	x_gui, %eax
	subl	$1, %eax
	movl	%eax, x_gui
	jmp	.L418
.L421:
	movb	$1, -1(%ebp)
.L418:
	movzbl	-1(%ebp), %eax
	negl	%eax
	leave
	ret
	.size	move, .-move
	.globl	sudo
	.section	.bss
	.type	sudo, @object
	.size	sudo, 1
sudo:
	.zero	1
	.globl	quitgui
	.type	quitgui, @object
	.size	quitgui, 1
quitgui:
	.zero	1
	.section	.rodata
	.align 4
.LC234:
	.ascii	" _   _                  _  _____  _____           \n| \\ | |"
	.ascii	"                | ||  _  |/  ___|          \n"
	.string	"|  \\| |  ___  _ __   __| || | | |\\ `--.           \n| . ` | / _ \\| '__| / _` || | | | `--. \\          \n| |\\  ||  __/| |   | (_| |\\ \\_/ //\\__/ /          \n\\_| \\_/ \\___||_|    \\__,_| \\___/ \\____/           \n\n\n  ___                 _____   ____   _____  _____ "
	.align 4
.LC235:
	.string	"\n / _ \\               |  _  | / ___| |  _  |/  ___|\n/ /_\\ \\ _ __   __  __ \\ V / / /___  | | | |\\ `--. \n|  _  || '_ \\  \\ \\/ / / _ \\ | ___ \\ | | | | `--. \n| | | || | | |  >  < | |_| || \\_/ | \\\\_/ //\\__/ /\n\\_| |_/|_| |_| /_/\\_\\_____/\\_____/  \\___/ \\____/ "
	.align 4
.LC236:
	.string	"\n\n\n Welcome to NerdOS. Enjoy your stay :)"
	.align 4
.LC237:
	.string	"     Caution: you are running as root.\n"
	.align 4
.LC238:
	.string	"Please ignore slow boot time, it hangs on a while loop! It may be due to the \nspeed of your computer\n"
.LC239:
	.string	"Boot into kernel: "
	.align 4
.LC240:
	.string	"Initialise IDT and keyboard input: "
.LC241:
	.string	"Initialise journaling: "
.LC242:
	.string	"Type your commands below.\n"
.LC243:
	.string	"Logged in as "
.LC244:
	.string	"root"
.LC245:
	.string	"\nDebugging ON, OFF or SOME?\n"
.LC246:
	.string	"Ok, debugging on!\n"
.LC247:
	.string	"Ok, no debugging\n"
.LC248:
	.string	"Ok, some debugging on!\n"
.LC249:
	.string	"HI!"
.LC250:
	.string	"Logged in as sudo\n"
.LC251:
	.string	"HALTING"
.LC252:
	.string	"hlt"
.LC253:
	.string	"processes halted by sudo"
.LC254:
	.string	"You no sudo...\n"
.LC255:
	.string	"Boot into text based GUI"
.LC256:
	.string	"\n\n"
.LC257:
	.string	"end"
.LC258:
	.string	"Enter your number (0 or 1)\n"
.LC259:
	.string	"toss was....\n"
.LC260:
	.string	"You win! Good job!\n"
.LC261:
	.string	"Not this time...\n"
.LC262:
	.string	"hmm"
.LC263:
	.string	"Done!"
.LC264:
	.string	"Initiated by user"
.LC265:
	.string	"Testing purposes."
	.text
	.globl	kmain
	.type	kmain, @function
kmain:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$1144, %esp
	call	createfiles
	movb	$1, sudo
	movl	$0, -12(%ebp)
	jmp	.L424
.L425:
	movl	-12(%ebp), %eax
	movl	$.LC232, typed(,%eax,4)
	addl	$1, -12(%ebp)
.L424:
	cmpl	$1023, -12(%ebp)
	jle	.L425
	call	term_init
	subl	$8, %esp
	pushl	$0
	pushl	$2
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC234
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC235
	call	printf
	addl	$16, %esp
	subl	$8, %esp
	pushl	$0
	pushl	$13
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC236
	call	printf
	addl	$16, %esp
	movzbl	sudo, %eax
	testb	%al, %al
	je	.L426
	subl	$8, %esp
	pushl	$0
	pushl	$12
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC237
	call	printf
	addl	$16, %esp
	jmp	.L427
.L426:
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
.L427:
	subl	$8, %esp
	pushl	$0
	pushl	$11
	call	setclr
	addl	$16, %esp
	call	printdate
	movl	DEFCOL, %eax
	subl	$8, %esp
	pushl	$0
	pushl	%eax
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC238
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$info+4
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$5
	call	sleep
	addl	$16, %esp
	call	clear
	subl	$8, %esp
	pushl	$1
	pushl	$.LC239
	call	kprintd
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	call	idt_init
	call	kb_init
	subl	$8, %esp
	pushl	$1
	pushl	$.LC240
	call	kprintd
	addl	$16, %esp
	call	mse_nl
	call	mse_nl
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	call	fsinit
	subl	$8, %esp
	pushl	$1
	pushl	$.LC241
	call	kprintd
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	call	mse_nl
	subl	$8, %esp
	pushl	$0
	pushl	$10
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC242
	call	printf
	addl	$16, %esp
	call	mse_nl
	movl	DEFCOL, %eax
	subl	$8, %esp
	pushl	$0
	pushl	%eax
	call	setclr
	addl	$16, %esp
	movb	$0, printrn
	movb	$0, debug
	movb	$0, -13(%ebp)
	subl	$12, %esp
	pushl	$.LC243
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC244
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	movl	rnd, %eax
	subl	$12, %esp
	pushl	%eax
	call	srand
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC214
	call	search
	addl	$16, %esp
	subl	$12, %esp
	pushl	%eax
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC245
	call	printf
	addl	$16, %esp
	movb	$1, -14(%ebp)
	movb	$0, -15(%ebp)
	movl	$0, -72(%ebp)
	subl	$4, %esp
	pushl	$0
	pushl	$119
	pushl	$.LC232
	call	writefs
	addl	$16, %esp
	subl	$4, %esp
	pushl	$1
	pushl	$119
	pushl	$.LC232
	call	writefs
	addl	$16, %esp
	subl	$4, %esp
	pushl	$2
	pushl	$119
	pushl	$.LC232
	call	writefs
	addl	$16, %esp
	subl	$4, %esp
	pushl	$3
	pushl	$119
	pushl	$.LC232
	call	writefs
	addl	$16, %esp
	subl	$4, %esp
	pushl	$4
	pushl	$119
	pushl	$.LC232
	call	writefs
	addl	$16, %esp
	subl	$4, %esp
	pushl	$5
	pushl	$119
	pushl	$.LC232
	call	writefs
	addl	$16, %esp
	subl	$4, %esp
	pushl	$6
	pushl	$119
	pushl	$.LC232
	call	writefs
	addl	$16, %esp
	subl	$4, %esp
	pushl	$7
	pushl	$119
	pushl	$.LC232
	call	writefs
	addl	$16, %esp
	subl	$4, %esp
	pushl	$8
	pushl	$119
	pushl	$.LC232
	call	writefs
	addl	$16, %esp
	subl	$4, %esp
	pushl	$9
	pushl	$119
	pushl	$.LC232
	call	writefs
	addl	$16, %esp
.L505:
	movl	typed, %eax
	cmpl	$.LC40, %eax
	jne	.L428
	movl	typed+4, %eax
	cmpl	$.LC65, %eax
	jne	.L428
	cmpb	$0, -14(%ebp)
	je	.L428
	movl	typed+8, %eax
	cmpl	$.LC231, %eax
	jne	.L428
	movb	$0, -14(%ebp)
	movb	$1, printrn
	movb	$1, debug
	subl	$12, %esp
	pushl	$.LC246
	call	printf
	addl	$16, %esp
	call	mse_nl
	movb	$1, -13(%ebp)
	jmp	.L429
.L428:
	movl	typed, %eax
	cmpl	$.LC40, %eax
	jne	.L430
	movl	typed+4, %eax
	cmpl	$.LC49, %eax
	jne	.L430
	movl	typed+8, %eax
	cmpl	$.LC49, %eax
	jne	.L430
	movl	typed+12, %eax
	cmpl	$.LC231, %eax
	jne	.L430
	cmpb	$0, -14(%ebp)
	je	.L430
	movb	$0, -14(%ebp)
	subl	$12, %esp
	pushl	$.LC247
	call	printf
	addl	$16, %esp
	call	mse_nl
	movb	$1, -13(%ebp)
	jmp	.L429
.L430:
	movl	typed, %eax
	cmpl	$.LC47, %eax
	jne	.L429
	movl	typed+4, %eax
	cmpl	$.LC40, %eax
	jne	.L429
	movl	typed+8, %eax
	cmpl	$.LC66, %eax
	jne	.L429
	movl	typed+12, %eax
	cmpl	$.LC34, %eax
	jne	.L429
	movl	typed+16, %eax
	cmpl	$.LC231, %eax
	jne	.L429
	cmpb	$0, -14(%ebp)
	je	.L429
	subl	$12, %esp
	pushl	$.LC248
	call	printf
	addl	$16, %esp
	call	mse_nl
	movb	$0, -14(%ebp)
	movb	$1, debug
.L429:
	movl	typed, %eax
	cmpl	$.LC34, %eax
	jne	.L431
	movl	typed+4, %eax
	cmpl	$.LC62, %eax
	jne	.L431
	movl	typed+8, %eax
	cmpl	$.LC231, %eax
	jne	.L431
	subl	$12, %esp
	pushl	$.LC249
	call	printf
	addl	$16, %esp
	call	mse_nl
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	movl	$0, counter
	movb	$1, -13(%ebp)
	jmp	.L432
.L431:
	movl	typed, %eax
	cmpl	$.LC34, %eax
	jne	.L433
	movl	typed+4, %eax
	cmpl	$.LC62, %eax
	jne	.L433
	movl	typed+8, %eax
	cmpl	$.LC51, %eax
	jne	.L433
	movl	typed+12, %eax
	cmpl	$.LC40, %eax
	jne	.L433
	movl	typed+16, %eax
	cmpl	$.LC231, %eax
	jne	.L433
	movl	$5, -24(%ebp)
	jmp	.L434
.L436:
	movl	-24(%ebp), %eax
	movl	typed(,%eax,4), %eax
	subl	$12, %esp
	pushl	%eax
	call	printf
	addl	$16, %esp
	addl	$1, -24(%ebp)
.L434:
	movl	-24(%ebp), %eax
	movl	typed(,%eax,4), %eax
	cmpl	$.LC23, %eax
	je	.L435
	movl	-24(%ebp), %eax
	movl	typed(,%eax,4), %eax
	cmpl	$.LC231, %eax
	jne	.L436
.L435:
	call	mse_nl
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	movl	$0, counter
	movb	$1, -13(%ebp)
	jmp	.L432
.L433:
	movl	typed, %eax
	cmpl	$.LC54, %eax
	jne	.L437
	movl	typed+4, %eax
	cmpl	$.LC40, %eax
	jne	.L437
	movl	typed+8, %eax
	cmpl	$.LC50, %eax
	jne	.L437
	movl	typed+12, %eax
	cmpl	$.LC39, %eax
	jne	.L437
	movl	typed+16, %eax
	cmpl	$.LC65, %eax
	jne	.L437
	movl	typed+20, %eax
	cmpl	$.LC0, %eax
	jne	.L437
	movl	typed+24, %eax
	cmpl	$.LC41, %eax
	jne	.L437
	movl	typed+28, %eax
	cmpl	$.LC46, %eax
	jne	.L437
	movl	typed+32, %eax
	cmpl	$.LC47, %eax
	jne	.L437
	movl	typed+36, %eax
	cmpl	$.LC47, %eax
	jne	.L437
	movl	typed+40, %eax
	cmpl	$.LC231, %eax
	jne	.L437
	subl	$12, %esp
	pushl	$.LC250
	call	printf
	addl	$16, %esp
	call	mse_nl
	movb	$1, sudo
	movb	$1, -13(%ebp)
	jmp	.L432
.L437:
	movl	typed, %eax
	cmpl	$.LC51, %eax
	jne	.L438
	movl	typed+4, %eax
	cmpl	$.LC54, %eax
	jne	.L438
	movl	typed+8, %eax
	cmpl	$.LC36, %eax
	jne	.L438
	movl	typed+12, %eax
	cmpl	$.LC231, %eax
	jne	.L438
	movzbl	sudo, %eax
	testb	%al, %al
	je	.L439
	subl	$12, %esp
	pushl	$.LC251
	call	printf
	addl	$16, %esp
	subl	$4, %esp
	pushl	$1
	pushl	$.LC252
	pushl	$.LC253
	call	panic
	addl	$16, %esp
	jmp	.L440
.L439:
	subl	$12, %esp
	pushl	$.LC254
	call	printf
	addl	$16, %esp
	movb	$1, -13(%ebp)
	jmp	.L432
.L438:
	movl	typed, %eax
	cmpl	$.LC50, %eax
	jne	.L441
	movl	typed+4, %eax
	cmpl	$.LC38, %eax
	jne	.L441
	movl	typed+8, %eax
	cmpl	$.LC39, %eax
	jne	.L441
	movl	typed+12, %eax
	cmpl	$.LC231, %eax
	jne	.L441
	subl	$12, %esp
	pushl	$.LC255
	call	printf
	addl	$16, %esp
	movb	$1, -13(%ebp)
	call	gui
	jmp	.L432
.L441:
	movl	typed, %eax
	cmpl	$.LC32, %eax
	jne	.L442
	movl	typed+4, %eax
	cmpl	$.LC231, %eax
	jne	.L442
	movb	$1, quitgui
	movb	$1, -13(%ebp)
	jmp	.L432
.L442:
	movl	typed, %eax
	cmpl	$.LC34, %eax
	jne	.L443
	movl	typed+4, %eax
	cmpl	$.LC48, %eax
	jne	.L443
	movl	typed+8, %eax
	cmpl	$.LC39, %eax
	jne	.L443
	movl	typed+12, %eax
	cmpl	$.LC36, %eax
	jne	.L443
	movl	typed+16, %eax
	cmpl	$.LC231, %eax
	jne	.L443
	call	text_edit
	movb	$1, -13(%ebp)
	jmp	.L432
.L443:
	movl	typed, %eax
	cmpl	$.LC36, %eax
	jne	.L444
	movl	typed+4, %eax
	cmpl	$.LC39, %eax
	jne	.L444
	movl	typed+8, %eax
	cmpl	$.LC62, %eax
	jne	.L444
	movl	typed+12, %eax
	cmpl	$.LC231, %eax
	jne	.L444
	call	tic
	movb	$1, -13(%ebp)
	subl	$12, %esp
	pushl	$.LC256
	call	printf
	addl	$16, %esp
	subl	$8, %esp
	pushl	$0
	pushl	$10
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC242
	call	printf
	addl	$16, %esp
	call	mse_nl
	movl	DEFCOL, %eax
	subl	$8, %esp
	pushl	$0
	pushl	%eax
	call	setclr
	addl	$16, %esp
	jmp	.L432
.L444:
	movl	typed, %eax
	cmpl	$.LC45, %eax
	jne	.L445
	movl	typed+4, %eax
	cmpl	$.LC71, %eax
	jne	.L445
	movl	typed+8, %eax
	cmpl	$.LC36, %eax
	jne	.L445
	subl	$4, %esp
	pushl	$1
	pushl	$.LC252
	pushl	$.LC257
	call	panic
	addl	$16, %esp
	jmp	.L440
.L445:
	movl	typed, %eax
	cmpl	$.LC35, %eax
	jne	.L446
	movl	typed+4, %eax
	cmpl	$.LC46, %eax
	jne	.L446
	movl	typed+8, %eax
	cmpl	$.LC65, %eax
	jne	.L446
	movl	typed+12, %eax
	cmpl	$.LC48, %eax
	jne	.L446
	movl	typed+16, %eax
	cmpl	$.LC231, %eax
	jne	.L446
	call	rand
	subl	$4, %esp
	pushl	$10
	leal	-95(%ebp), %edx
	pushl	%edx
	pushl	%eax
	call	itoa
	addl	$16, %esp
	subl	$12, %esp
	leal	-95(%ebp), %eax
	pushl	%eax
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	movb	$1, -13(%ebp)
	jmp	.L432
.L446:
	movl	typed, %eax
	cmpl	$.LC62, %eax
	jne	.L447
	movl	typed+4, %eax
	cmpl	$.LC40, %eax
	jne	.L447
	movl	typed+8, %eax
	cmpl	$.LC39, %eax
	jne	.L447
	movl	typed+12, %eax
	cmpl	$.LC65, %eax
	jne	.L447
	movl	typed+16, %eax
	cmpl	$.LC231, %eax
	jne	.L447
	movb	$1, -15(%ebp)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$31, %eax
	addl	%eax, %edx
	andl	$1, %edx
	subl	%eax, %edx
	movl	%edx, -20(%ebp)
	subl	$12, %esp
	pushl	$.LC258
	call	printf
	addl	$16, %esp
	movb	$1, -13(%ebp)
	jmp	.L432
.L447:
	movl	typed, %eax
	cmpl	$.LC1, %eax
	jne	.L448
	movl	typed+4, %eax
	cmpl	$.LC231, %eax
	jne	.L448
	cmpb	$0, -15(%ebp)
	je	.L448
	subl	$8, %esp
	pushl	$0
	pushl	$5
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC259
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	printn
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	movl	DEFCOL, %eax
	subl	$8, %esp
	pushl	$0
	pushl	%eax
	call	setclr
	addl	$16, %esp
	cmpl	$0, -20(%ebp)
	jne	.L449
	subl	$12, %esp
	pushl	$.LC260
	call	printf
	addl	$16, %esp
	movb	$0, -15(%ebp)
	jmp	.L450
.L449:
	subl	$12, %esp
	pushl	$.LC261
	call	printf
	addl	$16, %esp
	movb	$0, -15(%ebp)
.L450:
	movb	$1, -13(%ebp)
	jmp	.L432
.L448:
	movl	typed, %eax
	cmpl	$.LC2, %eax
	jne	.L451
	movl	typed+4, %eax
	cmpl	$.LC231, %eax
	jne	.L451
	cmpb	$0, -15(%ebp)
	je	.L451
	subl	$8, %esp
	pushl	$0
	pushl	$5
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC259
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	printn
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	movl	DEFCOL, %eax
	subl	$8, %esp
	pushl	$0
	pushl	%eax
	call	setclr
	addl	$16, %esp
	cmpl	$1, -20(%ebp)
	jne	.L452
	subl	$12, %esp
	pushl	$.LC260
	call	printf
	addl	$16, %esp
	movb	$0, -15(%ebp)
	jmp	.L453
.L452:
	subl	$12, %esp
	pushl	$.LC261
	call	printf
	addl	$16, %esp
	movb	$0, -15(%ebp)
.L453:
	movb	$1, -13(%ebp)
	jmp	.L432
.L451:
	movl	typed, %eax
	cmpl	$.LC51, %eax
	jne	.L454
	movl	typed+4, %eax
	cmpl	$.LC39, %eax
	jne	.L454
	movl	typed+8, %eax
	cmpl	$.LC47, %eax
	jne	.L454
	movl	typed+12, %eax
	cmpl	$.LC231, %eax
	jne	.L454
	subl	$12, %esp
	pushl	$root+4
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+1032
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+2060
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+3088
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+4116
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+5144
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+6172
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+7200
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+8228
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$root+9256
	call	printf
	addl	$16, %esp
	movb	$1, -13(%ebp)
	jmp	.L432
.L454:
	movl	typed, %eax
	cmpl	$.LC3, %eax
	jne	.L455
	movl	typed+4, %eax
	cmpl	$.LC2, %eax
	jne	.L455
	movl	typed+8, %eax
	cmpl	$.LC231, %eax
	jne	.L455
	subl	$12, %esp
	pushl	$0
	call	comp
	addl	$16, %esp
	movl	%eax, -28(%ebp)
	movl	$0, -32(%ebp)
	jmp	.L456
.L457:
	movl	-32(%ebp), %eax
	movl	$.LC23, typed(,%eax,4)
	addl	$1, -32(%ebp)
.L456:
	cmpl	$1023, -32(%ebp)
	jle	.L457
	movl	$0, -36(%ebp)
.L464:
	movl	typed, %eax
	cmpl	$.LC1, %eax
	je	.L506
	movl	typed, %eax
	cmpl	$.LC23, %eax
	je	.L460
	addl	$1, -36(%ebp)
	addl	$1, -28(%ebp)
	movl	$0, -40(%ebp)
	jmp	.L461
.L462:
	movl	-40(%ebp), %eax
	movl	$.LC23, typed(,%eax,4)
	addl	$1, -40(%ebp)
.L461:
	cmpl	$1023, -40(%ebp)
	jle	.L462
.L460:
	cmpl	$2, -36(%ebp)
	jle	.L464
	movl	$0, -36(%ebp)
	jmp	.L459
.L506:
	nop
.L459:
	nop
	cmpl	$20, -28(%ebp)
	jg	.L473
	subl	$12, %esp
	pushl	-28(%ebp)
	call	comp
	addl	$16, %esp
	movl	%eax, -28(%ebp)
.L472:
	movl	typed, %eax
	cmpl	$.LC1, %eax
	je	.L507
	movl	typed, %eax
	cmpl	$.LC23, %eax
	je	.L468
	addl	$1, -36(%ebp)
	addl	$1, -28(%ebp)
	movl	$0, -44(%ebp)
	jmp	.L469
.L470:
	movl	-44(%ebp), %eax
	movl	$.LC23, typed(,%eax,4)
	addl	$1, -44(%ebp)
.L469:
	cmpl	$1023, -44(%ebp)
	jle	.L470
.L468:
	cmpl	$2, -36(%ebp)
	jle	.L472
	movl	$0, -36(%ebp)
	jmp	.L467
.L507:
	nop
.L467:
	subl	$12, %esp
	pushl	-28(%ebp)
	call	printn
	addl	$16, %esp
	nop
.L473:
	subl	$12, %esp
	pushl	$.LC262
	call	printf
	addl	$16, %esp
	movb	$1, -13(%ebp)
	movb	$1, -13(%ebp)
	jmp	.L432
.L455:
	movl	typed, %eax
	cmpl	$.LC39, %eax
	jne	.L475
	movl	typed+4, %eax
	cmpl	$.LC65, %eax
	jne	.L475
	movl	typed+8, %eax
	cmpl	$.LC49, %eax
	jne	.L475
	movl	typed+12, %eax
	cmpl	$.LC40, %eax
	jne	.L475
	movl	typed+16, %eax
	cmpl	$.LC231, %eax
	jne	.L475
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$info+4
	call	printf
	addl	$16, %esp
	movb	$1, -13(%ebp)
	jmp	.L432
.L475:
	movl	typed, %eax
	cmpl	$.LC33, %eax
	jne	.L476
	movl	typed+4, %eax
	cmpl	$.LC35, %eax
	jne	.L476
	movl	typed+8, %eax
	cmpl	$.LC39, %eax
	jne	.L476
	movl	typed+12, %eax
	cmpl	$.LC36, %eax
	jne	.L476
	movl	typed+16, %eax
	cmpl	$.LC231, %eax
	jne	.L476
	movl	typed+20, %eax
	subl	$12, %esp
	pushl	%eax
	call	strnum
	addl	$16, %esp
	movl	%eax, -76(%ebp)
	subl	$4, %esp
	pushl	-76(%ebp)
	pushl	$97
	pushl	$.LC232
	call	writefs
	addl	$16, %esp
	movl	$6, -48(%ebp)
	jmp	.L477
.L479:
	movl	-48(%ebp), %eax
	movl	typed(,%eax,4), %eax
	subl	$4, %esp
	pushl	-76(%ebp)
	pushl	$97
	pushl	%eax
	call	writefs
	addl	$16, %esp
	addl	$1, -48(%ebp)
.L477:
	movl	-48(%ebp), %eax
	movl	typed(,%eax,4), %eax
	cmpl	$.LC23, %eax
	je	.L478
	movl	-48(%ebp), %eax
	movl	typed(,%eax,4), %eax
	cmpl	$.LC231, %eax
	jne	.L479
.L478:
	subl	$12, %esp
	pushl	$.LC263
	call	printf
	addl	$16, %esp
	call	mse_nl
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
	movb	$1, -13(%ebp)
	jmp	.L432
.L476:
	movl	typed, %eax
	cmpl	$.LC35, %eax
	jne	.L480
	movl	typed+4, %eax
	cmpl	$.LC34, %eax
	jne	.L480
	movl	typed+8, %eax
	cmpl	$.LC46, %eax
	jne	.L480
	movl	typed+12, %eax
	cmpl	$.LC48, %eax
	jne	.L480
	movl	typed+20, %eax
	cmpl	$.LC231, %eax
	jne	.L480
	movb	$1, -49(%ebp)
	movl	typed+16, %eax
	cmpl	$.LC1, %eax
	jne	.L481
	subl	$12, %esp
	pushl	$root+4
	call	printf
	addl	$16, %esp
	jmp	.L482
.L481:
	movl	typed+16, %eax
	cmpl	$.LC2, %eax
	jne	.L483
	subl	$12, %esp
	pushl	$root+1032
	call	printf
	addl	$16, %esp
	jmp	.L482
.L483:
	movl	typed+16, %eax
	cmpl	$.LC3, %eax
	jne	.L484
	subl	$12, %esp
	pushl	$root+2060
	call	printf
	addl	$16, %esp
	jmp	.L482
.L484:
	movl	typed+16, %eax
	cmpl	$.LC7, %eax
	jne	.L485
	subl	$12, %esp
	pushl	$root+3088
	call	printf
	addl	$16, %esp
	jmp	.L482
.L485:
	movl	typed+16, %eax
	cmpl	$.LC8, %eax
	jne	.L486
	subl	$12, %esp
	pushl	$root+4116
	call	printf
	addl	$16, %esp
	jmp	.L482
.L486:
	movl	typed+16, %eax
	cmpl	$.LC9, %eax
	jne	.L487
	subl	$12, %esp
	pushl	$root+5144
	call	printf
	addl	$16, %esp
	jmp	.L482
.L487:
	movl	typed+16, %eax
	cmpl	$.LC10, %eax
	jne	.L488
	subl	$12, %esp
	pushl	$root+6172
	call	printf
	addl	$16, %esp
	jmp	.L482
.L488:
	movl	typed+16, %eax
	cmpl	$.LC11, %eax
	jne	.L489
	subl	$12, %esp
	pushl	$root+7200
	call	printf
	addl	$16, %esp
	jmp	.L482
.L489:
	movl	typed+16, %eax
	cmpl	$.LC12, %eax
	jne	.L490
	subl	$12, %esp
	pushl	$root+8228
	call	printf
	addl	$16, %esp
	jmp	.L482
.L490:
	movl	typed+16, %eax
	cmpl	$.LC13, %eax
	jne	.L491
	subl	$12, %esp
	pushl	$root+9256
	call	printf
	addl	$16, %esp
	jmp	.L482
.L491:
	movb	$0, -49(%ebp)
.L482:
	cmpb	$0, -49(%ebp)
	je	.L492
	subl	$12, %esp
	pushl	$.LC44
	call	printf
	addl	$16, %esp
.L492:
	movb	$1, -13(%ebp)
	jmp	.L432
.L480:
	movl	typed, %eax
	cmpl	$.LC48, %eax
	jne	.L493
	movl	typed+4, %eax
	cmpl	$.LC38, %eax
	jne	.L493
	movl	typed+8, %eax
	cmpl	$.LC66, %eax
	jne	.L493
	movl	typed+12, %eax
	cmpl	$.LC41, %eax
	jne	.L493
	movl	typed+16, %eax
	cmpl	$.LC231, %eax
	jne	.L493
	call	dump
	movb	$1, -13(%ebp)
	jmp	.L432
.L493:
	movl	typed, %eax
	cmpl	$.LC41, %eax
	jne	.L494
	movl	typed+4, %eax
	cmpl	$.LC46, %eax
	jne	.L494
	movl	typed+8, %eax
	cmpl	$.LC65, %eax
	jne	.L494
	movl	typed+12, %eax
	cmpl	$.LC39, %eax
	jne	.L494
	movl	typed+16, %eax
	cmpl	$.LC62, %eax
	jne	.L494
	movl	typed+20, %eax
	cmpl	$.LC231, %eax
	jne	.L494
	subl	$4, %esp
	pushl	$1
	pushl	$.LC264
	pushl	$.LC265
	call	panic
	addl	$16, %esp
	jmp	.L432
.L494:
	movl	typed, %eax
	cmpl	$.LC36, %eax
	jne	.L495
	movl	typed+4, %eax
	cmpl	$.LC39, %eax
	jne	.L495
	movl	typed+8, %eax
	cmpl	$.LC66, %eax
	jne	.L495
	movl	typed+12, %eax
	cmpl	$.LC34, %eax
	jne	.L495
	movl	typed+16, %eax
	cmpl	$.LC231, %eax
	jne	.L495
	call	printdate
	movb	$1, -13(%ebp)
	jmp	.L432
.L495:
	movl	typed, %eax
	cmpl	$.LC47, %eax
	jne	.L496
	movl	typed+4, %eax
	cmpl	$.LC54, %eax
	jne	.L496
	movl	typed+8, %eax
	cmpl	$.LC34, %eax
	jne	.L496
	movl	typed+12, %eax
	cmpl	$.LC34, %eax
	jne	.L496
	movl	typed+16, %eax
	cmpl	$.LC41, %eax
	jne	.L496
	movl	typed+28, %eax
	cmpl	$.LC231, %eax
	je	.L497
	movl	typed+32, %eax
	cmpl	$.LC231, %eax
	jne	.L496
.L497:
	movl	typed+24, %eax
	subl	$4, %esp
	pushl	$3
	pushl	%eax
	leal	-105(%ebp), %eax
	pushl	%eax
	call	memcpy
	addl	$16, %esp
	movl	$0, -56(%ebp)
	movl	typed+24, %eax
	subl	$12, %esp
	pushl	%eax
	call	atoi
	addl	$16, %esp
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	movl	%eax, -60(%ebp)
	movl	typed+28, %eax
	cmpl	$.LC231, %eax
	je	.L498
	movl	typed+28, %eax
	subl	$12, %esp
	pushl	%eax
	call	atoi
	addl	$16, %esp
	movl	%eax, -56(%ebp)
	jmp	.L499
.L498:
	movl	typed+24, %eax
	subl	$12, %esp
	pushl	%eax
	call	atoi
	addl	$16, %esp
	movl	%eax, -60(%ebp)
.L499:
	movl	-60(%ebp), %edx
	movl	-56(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -80(%ebp)
	subl	$12, %esp
	pushl	-80(%ebp)
	call	printn
	addl	$16, %esp
	movl	-80(%ebp), %eax
	subl	$1, %eax
	movl	%eax, -64(%ebp)
	jmp	.L500
.L501:
	subl	$12, %esp
	pushl	$1
	call	sleep
	addl	$16, %esp
	subl	$12, %esp
	pushl	-64(%ebp)
	call	printn
	addl	$16, %esp
	subl	$1, -64(%ebp)
.L500:
	cmpl	$0, -64(%ebp)
	jg	.L501
	movb	$1, -13(%ebp)
	jmp	.L432
.L496:
	movl	typed, %eax
	cmpl	$.LC54, %eax
	jne	.L432
	movl	typed+4, %eax
	cmpl	$.LC47, %eax
	jne	.L432
	movl	typed+8, %eax
	cmpl	$.LC231, %eax
	jne	.L432
	call	printlist
	movb	$1, -13(%ebp)
.L432:
	cmpb	$0, -13(%ebp)
	je	.L505
	movb	$0, -13(%ebp)
	movl	$0, -68(%ebp)
	jmp	.L503
.L504:
	movl	-68(%ebp), %eax
	movl	$.LC23, typed(,%eax,4)
	addl	$1, -68(%ebp)
.L503:
	cmpl	$1023, -68(%ebp)
	jle	.L504
	jmp	.L505
.L440:
	nop
	leave
	ret
	.size	kmain, .-kmain
	.section	.rodata
	.align 4
.LC266:
	.string	"HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"
	.align 4
.LC267:
	.string	"HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"
.LC268:
	.string	"hi"
	.align 4
.LC269:
	.string	"HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"
	.text
	.globl	gui
	.type	gui, @function
gui:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	call	clear_screen
	call	clear
	movl	DEFCOL, %eax
	subl	$8, %esp
	pushl	$15
	pushl	%eax
	call	setclr
	addl	$16, %esp
	movl	$0, -12(%ebp)
	jmp	.L509
.L510:
	movl	DEFCOL, %eax
	subl	$8, %esp
	pushl	$15
	pushl	%eax
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC266
	call	printf
	addl	$16, %esp
	addl	$1, -12(%ebp)
.L509:
	cmpl	$11, -12(%ebp)
	jle	.L510
	subl	$12, %esp
	pushl	$.LC267
	call	printf
	addl	$16, %esp
	movl	DEFCOL, %eax
	subl	$8, %esp
	pushl	$0
	pushl	%eax
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC268
	call	printf
	addl	$16, %esp
	movl	DEFCOL, %eax
	subl	$8, %esp
	pushl	$15
	pushl	%eax
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC269
	call	printf
	addl	$16, %esp
	movl	$0, -16(%ebp)
	jmp	.L511
.L512:
	movl	DEFCOL, %eax
	subl	$8, %esp
	pushl	$15
	pushl	%eax
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC266
	call	printf
	addl	$16, %esp
	addl	$1, -16(%ebp)
.L511:
	cmpl	$12, -16(%ebp)
	jle	.L512
	movzbl	quitgui, %eax
	testb	%al, %al
	je	.L513
	call	clear
	call	clear_screen
	movl	$0, %eax
	jmp	.L508
.L513:
.L508:
	leave
	ret
	.size	gui, .-gui
	.section	.rodata
.LC270:
	.string	" ~\n"
	.text
	.globl	text_edit
	.type	text_edit, @function
text_edit:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	call	clear_screen
	call	clear
	subl	$8, %esp
	pushl	$0
	pushl	$10
	call	setclr
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC270
	call	printf
	addl	$16, %esp
	call	mse_nl
	movl	DEFCOL, %eax
	subl	$8, %esp
	pushl	$0
	pushl	%eax
	call	setclr
	addl	$16, %esp
	nop
	leave
	ret
	.size	text_edit, .-text_edit
	.ident	"GCC: (GNU) 12.2.0"

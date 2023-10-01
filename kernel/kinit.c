int kinit(void) {
    term_init();
    idt_init();
    kb_init();
    setclr(defcol(),0);
}
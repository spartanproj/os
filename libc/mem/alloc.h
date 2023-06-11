extern int end;
int placement_addr=(int)&end;
int kmalloc_internal(int sz, int align, int * phys) {
    if (align==1 && (placement_addr & 0xFFFFF000)) {
        placement_addr&=0xFFFFF000;
        placement_addr+=0x1000;
    }
    if (phys) {
        *phys=placement_addr;
    }
    int temp=placement_addr;
    placement_addr+=sz;
    return temp;
}
int kmalloc_a(int sz) { // page aligned
    return kmalloc_internal(sz,1,0);
}
int kmalloc_p(int sz, int *phys) { // physical address
    return kmalloc_internal(sz,0,phys);
}
int kmalloc_ap(int sz, int * phys) { // page aligned + phys
    return kmalloc_internal(sz,1,phys);
}
int kmalloc(int sz) { // common or garden malloc()
    return kmalloc_internal(sz,0,0);
}
;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _rand
	.globl _Pset
	.globl _Itoa
	.globl _WaitKey
	.globl _PutText
	.globl _SetBorderColor
	.globl _SetColors
	.globl _Screen
	.globl _Cls
	.globl _num_entities
	.globl _next_free_entity
	.globl _zero_type_at_the_end
	.globl _array_structs_entities
	.globl _init_entity
	.globl _man_entities_init
	.globl _man_create_entities
	.globl _man_entity_destroy
	.globl _man_entity_set4destruction
	.globl _man_entity_update
	.globl _man_entity_for_all
	.globl _man_entity_freeSpace
	.globl _generar_numero_aleatorio
	.globl _gui
	.globl _sys_physics_update_one_entity
	.globl _sys_physics_init
	.globl _sys_physics_update
	.globl _sys_render_update_one_entity
	.globl _sys_render_init
	.globl _sys_render_update
	.globl _generator_new_star
	.globl _sys_generator_update
	.globl _wait
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_array_structs_entities::
	.ds 16000
_zero_type_at_the_end::
	.ds 1
_next_free_entity::
	.ds 2
_num_entities::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/man/entity.c:67: void man_entities_init(){
;	---------------------------------
; Function man_entities_init
; ---------------------------------
_man_entities_init::
;src/man/entity.c:69: memset ( array_structs_entities, 0x00,sizeof(array_structs_entities));
	ld	bc, #_array_structs_entities+0
	ld	l, c
	ld	h, b
	push	bc
	ld	(hl), #0x00
	ld	e, l
	ld	d, h
	inc	de
	ld	bc, #0x3e7f
	ldir
	pop	bc
;src/man/entity.c:71: next_free_entity=array_structs_entities;
	ld	(_next_free_entity), bc
;src/man/entity.c:72: zero_type_at_the_end=entity_type_invalid;
	ld	hl,#_zero_type_at_the_end + 0
	ld	(hl), #0x00
;src/man/entity.c:73: num_entities=0;
	ld	hl,#_num_entities + 0
	ld	(hl), #0x00
;src/man/entity.c:74: }
	ret
_Done_Version:
	.ascii "Made with FUSION-C 1.2 (ebsoft)"
	.db 0x00
;src/man/entity.c:77: TEntity* man_create_entities(){
;	---------------------------------
; Function man_create_entities
; ---------------------------------
_man_create_entities::
;src/man/entity.c:78: TEntity* entity=next_free_entity;
	ld	bc, (_next_free_entity)
;src/man/entity.c:79: next_free_entity=entity+1;
	ld	hl, #0x0008
	add	hl, bc
	ld	(_next_free_entity), hl
;src/man/entity.c:80: entity->type=entity_type_default;
	ld	a, #0x7f
	ld	(bc), a
;src/man/entity.c:81: ++num_entities;
	ld	hl, #_num_entities+0
	inc	(hl)
;src/man/entity.c:82: return entity;
	ld	l, c
	ld	h, b
;src/man/entity.c:83: }
	ret
;src/man/entity.c:89: void man_entity_destroy(TEntity *deadEntity){
;	---------------------------------
; Function man_entity_destroy
; ---------------------------------
_man_entity_destroy::
	call	___sdcc_enter_ix
;src/man/entity.c:90: TEntity *last=next_free_entity-1;
	ld	iy, #_next_free_entity
	ld	a, 0 (iy)
	add	a, #0xf8
	ld	c, a
	ld	a, 1 (iy)
	adc	a, #0xff
	ld	b, a
;src/man/entity.c:92: if(deadEntity!=last){
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	cp	a, a
	sbc	hl, bc
	jr	Z,00102$
;src/man/entity.c:94: memcpy(deadEntity, last, sizeof(TEntity));
	ld	e, 4 (ix)
	ld	d, 5 (ix)
	ld	l, c
	ld	h, b
	push	bc
	ld	bc, #0x0008
	ldir
	pop	bc
00102$:
;src/man/entity.c:96: last->type=entity_type_invalid;
	xor	a, a
	ld	(bc), a
;src/man/entity.c:97: next_free_entity=last;
	ld	(_next_free_entity), bc
;src/man/entity.c:98: --num_entities;
	ld	hl, #_num_entities+0
	dec	(hl)
;src/man/entity.c:99: }
	pop	ix
	ret
;src/man/entity.c:100: void man_entity_set4destruction(TEntity *deadEntity){
;	---------------------------------
; Function man_entity_set4destruction
; ---------------------------------
_man_entity_set4destruction::
;src/man/entity.c:105: deadEntity->type=deadEntity->type | entity_type_dead;
	pop	de
	pop	bc
	push	bc
	push	de
	ld	a, (bc)
	set	7, a
	ld	(bc), a
;src/man/entity.c:107: }
	ret
;src/man/entity.c:108: void man_entity_update(){
;	---------------------------------
; Function man_entity_update
; ---------------------------------
_man_entity_update::
;src/man/entity.c:109: TEntity *entity= array_structs_entities;
	ld	hl, #_array_structs_entities+0
;src/man/entity.c:111: while(entity->type !=entity_type_invalid){
00104$:
	ld	a, (hl)
	or	a, a
	ret	Z
;src/man/entity.c:119: if (entity->type & entity_type_dead){
	rlca
	jr	NC,00102$
;src/man/entity.c:120: man_entity_destroy(entity);
	push	hl
	push	hl
	call	_man_entity_destroy
	pop	af
	pop	hl
	jr	00104$
00102$:
;src/man/entity.c:122: ++entity;
	ld	bc, #0x0008
	add	hl, bc
;src/man/entity.c:126: }
	jr	00104$
;src/man/entity.c:128: void man_entity_for_all(void (*ptrFunc)(TEntity*)){
;	---------------------------------
; Function man_entity_for_all
; ---------------------------------
_man_entity_for_all::
;src/man/entity.c:129: TEntity* entity=array_structs_entities;
	ld	de, #_array_structs_entities+0
;src/man/entity.c:131: while (entity->type!=entity_type_invalid){
00101$:
	ld	a, (de)
	or	a, a
	ret	Z
;src/man/entity.c:133: ptrFunc(entity);
	push	de
	push	de
	ld	hl, #6
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	call	___sdcc_call_hl
	pop	af
	pop	de
;src/man/entity.c:134: ++entity;
	ld	hl, #0x0008
	add	hl, de
	ex	de, hl
;src/man/entity.c:137: }
	jr	00101$
;src/man/entity.c:139: char man_entity_freeSpace(){
;	---------------------------------
; Function man_entity_freeSpace
; ---------------------------------
_man_entity_freeSpace::
;src/man/entity.c:140: return MAX_ENTITIES-num_entities;
	ld	hl,#_num_entities + 0
	ld	c, (hl)
	ld	a, #0xd0
	sub	a, c
	ld	l, a
;src/man/entity.c:141: }
	ret
;src/man/entity.c:143: char generar_numero_aleatorio (char a, char b){
;	---------------------------------
; Function generar_numero_aleatorio
; ---------------------------------
_generar_numero_aleatorio::
	call	___sdcc_enter_ix
;src/man/entity.c:145: random = rand()%(b-a)+a;  
	call	_rand
	ld	c, 5 (ix)
	ld	b, #0x00
	ld	e, 4 (ix)
	ld	d, #0x00
	ld	a, c
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
	push	bc
	push	hl
	call	__modsint
	pop	af
	pop	af
	ld	c, 4 (ix)
	add	hl, bc
;src/man/entity.c:146: return(random);
;src/man/entity.c:147: }
	pop	ix
	ret
;src/man/entity.c:150: void gui(){
;	---------------------------------
; Function gui
; ---------------------------------
_gui::
	call	___sdcc_enter_ix
	push	af
	dec	sp
;src/man/entity.c:151: TEntity * entity=array_structs_entities;
;src/man/entity.c:152: PutText(50,160, Itoa(man_entity_freeSpace(),"   ",10),0 );
	call	_man_entity_freeSpace
	ld	h, #0x00
	ld	bc, #0x000a
	push	bc
	ld	bc, #___str_1
	push	bc
	push	hl
	call	_Itoa
	pop	af
	pop	af
	pop	af
	xor	a, a
	push	af
	inc	sp
	push	hl
	ld	hl, #0x00a0
	push	hl
	ld	l, #0x32
	push	hl
	call	_PutText
	pop	af
	pop	af
	pop	af
	inc	sp
;src/man/entity.c:154: while(i<num_entities){
	xor	a, a
	ld	-3 (ix), a
	ld	-2 (ix), #<(_array_structs_entities)
	ld	-1 (ix), #>(_array_structs_entities)
00101$:
	ld	hl, #_num_entities
	ld	a, -3 (ix)
	sub	a, (hl)
	jp	NC, 00104$
;src/man/entity.c:155: PutText(i*50,170, Itoa(entity->type,"   ",10),0 );
	ld	bc, #___str_1
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #0x000a
	push	hl
	push	bc
	push	de
	call	_Itoa
	pop	af
	pop	af
	pop	af
	ld	c, l
	ld	b, h
	ld	e, -3 (ix)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	ex	de, hl
	push	de
	xor	a, a
	push	af
	inc	sp
	push	bc
	ld	hl, #0x00aa
	push	hl
	push	de
	call	_PutText
	pop	af
	pop	af
	pop	af
	inc	sp
	pop	de
;src/man/entity.c:156: PutText(i*50,180, Itoa(entity->x,"   ",10),0 );
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
	push	de
	ld	hl, #0x000a
	push	hl
	ld	hl, #___str_1
	push	hl
	push	bc
	call	_Itoa
	pop	af
	pop	af
	pop	af
	pop	de
	push	de
	xor	a, a
	push	af
	inc	sp
	push	hl
	ld	hl, #0x00b4
	push	hl
	push	de
	call	_PutText
	pop	af
	pop	af
	pop	af
	inc	sp
	pop	de
;src/man/entity.c:157: PutText(i*50,190, Itoa(entity->y,"   ",10),0 );
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	inc	hl
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
	push	de
	ld	hl, #0x000a
	push	hl
	ld	hl, #___str_1
	push	hl
	push	bc
	call	_Itoa
	pop	af
	pop	af
	pop	af
	pop	de
	xor	a, a
	push	af
	inc	sp
	push	hl
	ld	hl, #0x00be
	push	hl
	push	de
	call	_PutText
	pop	af
	pop	af
	pop	af
	inc	sp
;src/man/entity.c:158: ++i;
	inc	-3 (ix)
;src/man/entity.c:159: ++entity;
	ld	a, -2 (ix)
	add	a, #0x08
	ld	-2 (ix), a
	jr	NC,00117$
	inc	-1 (ix)
00117$:
;src/man/entity.c:161: PutText(50,170, "                          ",0 );
	xor	a, a
	push	af
	inc	sp
	ld	hl, #___str_2
	push	hl
	ld	hl, #0x00aa
	push	hl
	ld	l, #0x32
	push	hl
	call	_PutText
	pop	af
	pop	af
	pop	af
	inc	sp
	jp	00101$
00104$:
;src/man/entity.c:164: }
	ld	sp, ix
	pop	ix
	ret
___str_1:
	.ascii "   "
	.db 0x00
___str_2:
	.ascii "                          "
	.db 0x00
;src/sys/physics.c:8: void sys_physics_update_one_entity(TEntity *entity){
;	---------------------------------
; Function sys_physics_update_one_entity
; ---------------------------------
_sys_physics_update_one_entity::
	call	___sdcc_enter_ix
	dec	sp
;src/sys/physics.c:10: entity->x+=entity->velocidadX;
	ld	c, 4 (ix)
	ld	b, 5 (ix)
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (de)
	ld	-1 (ix), a
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	add	a, -1 (ix)
	ld	(de), a
;src/sys/physics.c:12: if (entity->x<5){
	sub	a, #0x05
	jr	NC,00103$
;src/sys/physics.c:13: man_entity_set4destruction(entity);
	push	bc
	call	_man_entity_set4destruction
	pop	af
00103$:
;src/sys/physics.c:16: }
	inc	sp
	pop	ix
	ret
;src/sys/physics.c:18: void sys_physics_init(){
;	---------------------------------
; Function sys_physics_init
; ---------------------------------
_sys_physics_init::
;src/sys/physics.c:20: }
	ret
;src/sys/physics.c:22: void sys_physics_update(){
;	---------------------------------
; Function sys_physics_update
; ---------------------------------
_sys_physics_update::
;src/sys/physics.c:23: man_entity_for_all(sys_physics_update_one_entity);
	ld	hl, #_sys_physics_update_one_entity
	push	hl
	call	_man_entity_for_all
	pop	af
;src/sys/physics.c:24: }
	ret
;src/sys/render.c:7: void sys_render_update_one_entity(TEntity *entity){
;	---------------------------------
; Function sys_render_update_one_entity
; ---------------------------------
_sys_render_update_one_entity::
	call	___sdcc_enter_ix
	push	af
	push	af
	push	af
;src/sys/render.c:11: Pset(entity->x-entity->velocidadX,entity->y,0,0);  
	ld	c, 4 (ix)
	ld	b, 5 (ix)
	ld	hl, #0x0002
	add	hl, bc
	ex	(sp), hl
	pop	hl
	push	hl
	ld	a, (hl)
	ld	-4 (ix), a
	xor	a, a
	ld	-3 (ix), a
	ld	hl, #0x0001
	add	hl, bc
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	e, (hl)
	ld	d, #0x00
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	l, (hl)
	ld	h, #0x00
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	d, a
	push	bc
	ld	hl, #0x0000
	push	hl
	ld	l, #0x00
	push	hl
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	push	hl
	push	de
	call	_Pset
	pop	af
	pop	af
	pop	af
	pop	af
	pop	bc
;src/sys/render.c:12: if (!(entity->type & entity_type_dead)){
	ld	a, (bc)
	rlca
	jr	C,00103$
;src/sys/render.c:14: Pset(entity->x,entity->y,entity->color,0);
	ld	l, c
	ld	h, b
	ld	de, #0x0007
	add	hl, de
	ld	e, (hl)
	ld	d, #0x00
	pop	hl
	push	hl
	ld	c, (hl)
	ld	b, #0x00
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, (hl)
	ld	-2 (ix), a
	xor	a, a
	ld	-1 (ix), a
	ld	hl, #0x0000
	push	hl
	push	de
	push	bc
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	push	hl
	call	_Pset
	pop	af
	pop	af
	pop	af
	pop	af
00103$:
;src/sys/render.c:16: }
	ld	sp, ix
	pop	ix
	ret
;src/sys/render.c:18: void sys_render_init(){
;	---------------------------------
; Function sys_render_init
; ---------------------------------
_sys_render_init::
;src/sys/render.c:19: SetColors(15,1,1);
	ld	de, #0x0101
	push	de
	ld	a, #0x0f
	push	af
	inc	sp
	call	_SetColors
	pop	af
	inc	sp
;src/sys/render.c:20: SetBorderColor(0x01);
	ld	a, #0x01
	push	af
	inc	sp
	call	_SetBorderColor
	inc	sp
;src/sys/render.c:21: Screen(5);
	ld	a, #0x05
	push	af
	inc	sp
	call	_Screen
	inc	sp
;src/sys/render.c:22: }
	ret
;src/sys/render.c:24: void sys_render_update(){
;	---------------------------------
; Function sys_render_update
; ---------------------------------
_sys_render_update::
;src/sys/render.c:25: man_entity_for_all(sys_render_update_one_entity);
	ld	hl, #_sys_render_update_one_entity
	push	hl
	call	_man_entity_for_all
	pop	af
;src/sys/render.c:26: }
	ret
;src/sys/generator.c:22: void generator_new_star(void){
;	---------------------------------
; Function generator_new_star
; ---------------------------------
_generator_new_star::
;src/sys/generator.c:23: TEntity* entity=man_create_entities();
	call	_man_create_entities
	ex	de,hl
;src/sys/generator.c:25: memcpy(entity, &init_entity, sizeof(init_entity));
	ld	c, e
	ld	b, d
	push	de
	ld	e, c
	ld	d, b
	ld	hl, #_init_entity
	ld	bc, #0x0008
	ldir
	pop	de
;src/sys/generator.c:26: entity->y=generar_numero_aleatorio(0,180);
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	push	bc
	push	de
	ld	a, #0xb4
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_generar_numero_aleatorio
	pop	af
	ld	a, l
	pop	de
	pop	bc
	ld	(bc), a
;src/sys/generator.c:27: entity->velocidadX=-generar_numero_aleatorio(1,10);
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	push	hl
	push	de
	ld	de, #0x0a01
	push	de
	call	_generar_numero_aleatorio
	pop	af
	ld	a, l
	pop	de
	pop	hl
	neg
	ld	b, a
	ld	(hl), b
;src/sys/generator.c:30: if(entity->velocidadX>253 ){
	ld	c, (hl)
;src/sys/generator.c:31: entity->color=8;
	ld	hl, #0x0007
	add	hl, de
;src/sys/generator.c:30: if(entity->velocidadX>253 ){
	ld	a, #0xfd
	sub	a, b
	jr	NC,00105$
;src/sys/generator.c:31: entity->color=8;
	ld	(hl), #0x08
	ret
00105$:
;src/sys/generator.c:33: } else if(entity->velocidadX>250 && entity->velocidadX<=253 ){
	ld	a, #0xfa
	sub	a, c
	ret	NC
	ld	a, #0xfd
	sub	a, c
	ret	C
;src/sys/generator.c:34: entity->color=10;
	ld	(hl), #0x0a
;src/sys/generator.c:36: }       
	ret
_init_entity:
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x64	; 100	'd'
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0xff	; 255
;src/sys/generator.c:41: void sys_generator_update(){
;	---------------------------------
; Function sys_generator_update
; ---------------------------------
_sys_generator_update::
;src/sys/generator.c:43: if (man_entity_freeSpace())
	call	_man_entity_freeSpace
	ld	a, l
	or	a, a
;src/sys/generator.c:44: generator_new_star();
	jp	NZ,_generator_new_star
;src/sys/generator.c:45: }
	ret
;main.c:26: void wait(){
;	---------------------------------
; Function wait
; ---------------------------------
_wait::
;main.c:30: __endasm;
	halt
	halt
;main.c:31: }
	ret
;main.c:33: void main(void){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:35: sys_render_init();
	call	_sys_render_init
;main.c:37: PutText(10,100, "Pulsa una tecla para comenzar la animacion",0);
	xor	a, a
	push	af
	inc	sp
	ld	hl, #___str_3
	push	hl
	ld	hl, #0x0064
	push	hl
	ld	l, #0x0a
	push	hl
	call	_PutText
	pop	af
	pop	af
	pop	af
	inc	sp
;main.c:38: WaitKey();
	call	_WaitKey
;main.c:39: Cls();
	call	_Cls
;main.c:42: man_entities_init();
	call	_man_entities_init
;main.c:44: while(1){
00102$:
;main.c:47: sys_physics_update();
	call	_sys_physics_update
;main.c:49: sys_generator_update();
	call	_sys_generator_update
;main.c:51: sys_render_update();
	call	_sys_render_update
;main.c:53: man_entity_update();
	call	_man_entity_update
;main.c:57: }
	jr	00102$
___str_3:
	.ascii "Pulsa una tecla para comenzar la animacion"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)

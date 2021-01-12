///#include "./src/man/entity.c"
//DECLARACIONES
void generator_new_star(void);
void sys_generator_update();


const TEntity init_entity={
  entity_type_star, //tipo:      7f=0111 1111=127
  255,100,             //x,y:        ff, 64
  -1,                  //vx:         ff
  3,                   //direction:  03
  4,                  //plano:      04
  5,                  //sprite      05
  0xff                //color       ff
};

///////////////////////////
//  generate new star
//  Precondition
    //-There must be memory space avaible for new entities

void generator_new_star(void){
  TEntity* entity=man_create_entities();
  //Esta función copia 2 trozos de memoria
  memcpy(entity, &init_entity, sizeof(init_entity));
  entity->y=generar_numero_aleatorio(0,180);
  entity->velocidadX=-generar_numero_aleatorio(1,10);
  // -1 en realidad es ff=255 ya que es un char o un entero de 8 bits sin signo
  //Si es mayor que 253= 254 y 255
  if(entity->velocidadX>253 ){
       entity->color=8;
    //Si es menor que -2 y mayor que -4 =-3 y -4
  } else if(entity->velocidadX>250 && entity->velocidadX<=253 ){
      entity->color=10;
  }
}       




void sys_generator_update(){
    //is there enough space?
    if (man_entity_freeSpace())
        generator_new_star();
}
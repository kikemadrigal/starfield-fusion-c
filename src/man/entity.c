
/**********************************DECLARACIONES*****************************************/
#ifndef __ENTITY_H__
#define __ENTITY_H__

//*****************PUBLIC DATA STUCTURES***************

#define entity_type_invalid 0x00  //en binario=0000 0000 
#define entity_type_star 0x01    //en binario=0000 0001
#define entity_type_dead 0x80     //en binario=1000 0000=128
#define entity_type_default 0x7f  //en binario=0111 1111=127


//VARIABLES Y ARRAYS (8 bytes)
#define MAX_ENTITIES 2000
typedef struct {
    unsigned char type;
    //Vamos a permitir los signos para que se salga de la pantalla
    unsigned char x,y;
    //char es olo 1 byte de 0 a 255 posibles valores
    unsigned char velocidadX;
    unsigned char direccion;
    unsigned char plano;
    unsigned char sprite;
    unsigned char color;
}TEntity;



//*****************PUBLIC INTERFACE***************
//FUNCIONES
void man_entities_init();
TEntity* man_create_entities();
void man_entity_destroy(TEntity *entity);
void man_entity_set4destruction(TEntity *entity);
void man_entity_update();
void man_entity_for_all(void (*ptrFunc)(TEntity*));
char man_entity_freeSpace();
char generar_numero_aleatorio (char a, char b);
void gui();
#endif
/*************************************FINAL DE DECLARACIONES******************************/















/**************************DEFINICIONES**************************************************/
//********PRIVATE DATA MEMBERS*********
TEntity array_structs_entities[MAX_ENTITIES];
char zero_type_at_the_end;
TEntity* next_free_entity;
char num_entities;



void man_entities_init(){
    //void * memset ( void * ptr, int value, size_t num );
    memset ( array_structs_entities, 0x00,sizeof(array_structs_entities));
    //Las variables globales tienen que ser inicializadas dentro de un método
    next_free_entity=array_structs_entities;
    zero_type_at_the_end=entity_type_invalid;
    num_entities=0;
}
//Como nostros vamos a gestionar la memoria 1 definimos el espacio y despues devolvemos un puntero a
//la posición del array donde está el struct
TEntity* man_create_entities(){
    TEntity* entity=next_free_entity;
    next_free_entity=entity+1;
    entity->type=entity_type_default;
    ++num_entities;
    return entity;
}





void man_entity_destroy(TEntity *deadEntity){
    TEntity *last=next_free_entity-1;
    //Si no es la última
    if(deadEntity!=last){
        //Copiamos la ultima en la posición de la que se ha salido
        memcpy(deadEntity, last, sizeof(TEntity));
    } 
    last->type=entity_type_invalid;
    next_free_entity=last;
    --num_entities;
}
void man_entity_set4destruction(TEntity *deadEntity){
    //Or 0-1=1, 1-1=1, se añaden los unos
    //star (01-1)      0000 0001
    //dead (80-128)    1000 0000
    //total or=        1000 0001 =81=129
    deadEntity->type=deadEntity->type | entity_type_dead;

}
void man_entity_update(){
    TEntity *entity= array_structs_entities;
    //SI la entiedd no es invalida
    while(entity->type !=entity_type_invalid){
        //Si la entidad está marcada para destruit
        //Como sabemos que el bit es el 8 el que tienen que star a 1
        //La operación and nos da 0 en el caso de 0-1
        //           1xxx xxxx
        //           1000 0000 de entity_type_ead
        //rotal and= 1000 0000
        //El resultado solo tiene 2 posibles resultados 1000 0000=0x80 que es true o 0000 0000=0x00 que es false
        if (entity->type & entity_type_dead){
            man_entity_destroy(entity);
        }else{
            ++entity;
        }
           
    }
}

void man_entity_for_all(void (*ptrFunc)(TEntity*)){
    TEntity* entity=array_structs_entities;
    char i=0;
    while (entity->type!=entity_type_invalid){
    //while(i<num_entities){
        ptrFunc(entity);
        ++entity;
        //++i;
    }
}

char man_entity_freeSpace(){
    return MAX_ENTITIES-num_entities;
}

char generar_numero_aleatorio (char a, char b){
    char random; 
    random = rand()%(b-a)+a;  
    return(random);
}


void gui(){
    TEntity * entity=array_structs_entities;
    PutText(50,160, Itoa(man_entity_freeSpace(),"   ",10),0 );
    char i=0;
    while(i<num_entities){
        PutText(i*50,170, Itoa(entity->type,"   ",10),0 );
        PutText(i*50,180, Itoa(entity->x,"   ",10),0 );
        PutText(i*50,190, Itoa(entity->y,"   ",10),0 );
        ++i;
        ++entity;
        //Borramos todo
        PutText(50,170, "                          ",0 );
    }
    
}
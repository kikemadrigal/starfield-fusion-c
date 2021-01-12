//
// MSX Murcia 2021
//

#include "fusion-c/header/msx_fusion.h"
//Para el Pset utilizado en el render.c
#include "fusion-c/header/vdp_graph2.h"
// Para el memset y el memcpy del entity.c
#include <string.h>
//itoa
#include <stdlib.h>
#include "src/man/entity.c"
#include "src/sys/physics.c"
#include "src/sys/render.c"
#include "src/sys/generator.c"





//DECLARACIONES
void wait();

//DEFINICIONES
//#define  HALT __asm halt __endasm; 
void wait(){
    __asm
      halt
      halt
  __endasm;
}

void main(void){
  //Inicilizar pantalla
  sys_render_init();

  PutText(10,100, "Pulsa una tecla para comenzar la animacion",0);
  WaitKey();
  Cls();
  
  //LLenará el espacio creado previamente en la RAM para las estrellas con 0 e iniciañizará puntero y contador(Hack para poner 0)
  man_entities_init();

  while(1){
    //El render solo le resta a la x la velocidad y comprueba si se ha salido de la pantalla por la izquierda
    //Si se ha salido las marcará como muertas para despues ser borradas por el man_entity_update
    sys_physics_update();
    //El generador creará stars si tiene espacio
    sys_generator_update();
    //Pintará las estrellas
    sys_render_update();
    //Destruirá las estrellas que estásn marcadas para morir
    man_entity_update();
    //gui();
    //wait();
  }
}





































































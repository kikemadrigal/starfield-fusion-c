
//DECLARACIONES
void sys_render_update_one_entity(TEntity *entity);
void sys_render_init();
void sys_render_update();

void sys_render_update_one_entity(TEntity *entity){
    //Borramos el anterior
    //void Pset(int X, int Y, int color, int OP)
    //Draws a pixel at X,Y with the defined color and logical operation OP 
    Pset(entity->x-entity->velocidadX,entity->y,0,0);  
    if (!(entity->type & entity_type_dead)){
        //Dibujamos un pixel
        Pset(entity->x,entity->y,entity->color,0);
    }
}

void sys_render_init(){
  SetColors(15,1,1);
  SetBorderColor(0x01);
  Screen(5);
}

void sys_render_update(){
    man_entity_for_all(sys_render_update_one_entity);
}
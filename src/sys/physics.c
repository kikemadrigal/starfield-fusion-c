//#include "./src/man/entity.c"
//DECLARACIONES

void sys_physics_update_one_entity(TEntity *entity);
void sys_physics_init();
void sys_physics_update();

void sys_physics_update_one_entity(TEntity *entity){
    //char newX=entity->x+entity->velocidadX;
    entity->x+=entity->velocidadX;
    //Si se sale por la derecha la marcamos como invalida para no dibujarla
    if (entity->x<5){
        man_entity_set4destruction(entity);
    }
    //entity->x=newX;
}

void sys_physics_init(){
    
}

void sys_physics_update(){
    man_entity_for_all(sys_physics_update_one_entity);
}
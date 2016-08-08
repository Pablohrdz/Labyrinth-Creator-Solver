import java.util.*;

  Laberinto maze;
  LinkedList<Celda> listaVisitados;
  LinkedList<Celda> listaBuscados;
  LinkedList <Celda> celdasDisponibles;
  HashMap<Celda, Integer> hashmapCeldas;
  Celda aux;
  Celda auxAnterior;
  Celda inicio;
  Celda fin;
  Celda temp;
  boolean hayVecinosLibres;
  boolean reseteado;
  boolean laberintoCompleto;
  int velocidadCreacion;
  int velocidadBusqueda;
  int modoBusqueda;
  int modoCreacion;
  int probabilidad;
  int delay;
  int w;
  int contador;
  short dir;
  boolean iterar;
  boolean perfectMaze;
  boolean randomMouse;
  
  public void setup2(){
    setup();
  }
  
  void setup(){
     velocidadCreacion = 1; // 1 es el más rápido
     velocidadBusqueda = 1; // 1 es el más rápido
     modoCreacion = 6;
     modoBusqueda = 1;
     probabilidad = 0;
     delay = 000;
     iterar = true;
     perfectMaze = true;
     maze = new Laberinto(15, 15);

     
     dir = 16385; //Casi la mitad del rango de positivos de short
     background(0);    //Color del fondo
     noStroke();
     listaVisitados = new LinkedList<Celda>();
     listaBuscados  = new LinkedList<Celda>();
     celdasDisponibles = new LinkedList<Celda>();
     hashmapCeldas = new HashMap<Celda, Integer>();
     for(int i = 0; i < maze.celdas[0].length; i++)//Sets de la primera fila
         hashmapCeldas.put(maze.celdas[0][i], i);
     
     temp = maze.celdas[0][0];
     celdasDisponibles.add(temp);
     aux = maze.celdas[0][0];
     auxAnterior = aux;
     inicio = maze.celdas[0][0];
     fin = maze.celdas[maze.celdas.length-1][maze.celdas[0].length-1];
     randomMouse = false;
     
     size(maze.celdas[0].length*20-10, maze.celdas.length*20+30);
     listaVisitados.add(aux);
     reseteado = false;
     laberintoCompleto = false;
     contador = 0;
     
     inicio.setPeso(0);
  }
  
/////////////////////////////////////////////////////////////////////////////////////////////////////////

  void draw(){
    println(hashmapCeldas);
//CREACIÓN
   if(!laberintoCompleto){
    if(millis() % velocidadCreacion == 0){
      switch(modoCreacion){
        
        
  //Growing Tree Algorithm
        case 1:
             if(!listaVisitados.contains(aux)){
                 listaVisitados.add(aux);//Si visitas un nodo, lo añades a la lista de nodos visitados. 
             }
             
             aux.setColorCelda(255, 255, 255);                 //Color de las paredes quitadas.
             aux.setEsLibre(false);
             hayVecinosLibres = false;
             Collections.shuffle(aux.getListaAdyacencia());    //Random pick de vecino
             
             for(int i = 0; i < aux.libres().size(); i++){                        //Checas si hay vecinos del nodo que estén libres.
                  hayVecinosLibres = true;
                  maze.removerPared(aux, aux.libres().get(i));
                  aux = aux.libres().get(i);
                  aux.setColorCelda(255, 255, 255);           //Color de las celdas "creadas"
                  aux.dibujar();                              //Marca todos los dead-ends si lo pones por sí mismo con un color diferente al del laberinto.
                  break;
             }
           
           
           
             if(!hayVecinosLibres){                           //Si ya no hay vecinos libres en el nodo seleccionado, escoger uno de los nodos de la lista.
                 listaVisitados.remove(aux);
                 if(!listaVisitados.isEmpty()){
                   Collections.shuffle(listaVisitados);
                   aux = listaVisitados.get(0);                //Si no barajeas la lista y escoges el añadido más recientemente, se vuelve una búsqueda en profundidad. Si escoges el más antiguo, resulta en un laberinto más engorroso que los obtenidos con el algoritmo de Prim. Si cambias el dominio del shuffle, de manera que no se revuelvan todos y sólo algunos, el algoritmo produce diferentes laberintos
                   aux.setColorCelda(255, 170, 50);           //Color de celdas revisitadas.
                   fill(255, 170, 50);                          //Color de paredes revisitadas.
                   maze.pintarPared(aux, aux.getListaCaminos().get(0));
                   aux.setColorCelda(255, 170, 50);
                   aux.dibujar();
               }  
             }
             if(listaVisitados.isEmpty()){
               laberintoCompleto = true;
               perfectMaze = true;
             }
       break;
       
       
       
  //Prim's Algorithm
       case 2:
       if(celdasDisponibles.size() > 0){  
         for(int i = 0; i < temp.libres().size(); i++){//Metes a los vecinos disponibles de la celda en la lista
          if(!celdasDisponibles.contains(temp.libres().get(i)))
             celdasDisponibles.add(temp.libres().get(i));
          }  
         
         temp.setColorCelda(255, 255, 255);
         temp.setEsLibre(false);
         
          if(aux != null){
           aux.setColorCelda(255, 255, 255);
           aux.dibujar();
          }
         
         Collections.shuffle(celdasDisponibles);
         temp = celdasDisponibles.get(0);
         
         Collections.shuffle(temp.getListaAdyacencia());
         
         for(int i = 0; i < temp.getListaAdyacencia().size(); i++){
           if(!temp.getListaAdyacencia().get(i).esLibre()){
             maze.removerPared(temp, temp.getListaAdyacencia().get(i));
             aux = temp.getListaAdyacencia().get(i);
             temp.getListaAdyacencia().get(i).setColorCelda(255, 255, 255);
             temp.getListaAdyacencia().get(i).setEsLibre(false);
             celdasDisponibles.remove(temp.getListaAdyacencia().get(i));
             break;
           }
         }
         celdasDisponibles.remove(temp);
       }
       else{
        laberintoCompleto = true;
        perfectMaze = true;
       }
       break;
       
       
       
       
  //Profundidad
       case 3:
         //if(!listaVisitados.isEmpty()){     
             if(!listaVisitados.contains(aux)){
                 listaVisitados.push(aux);//Si visitas un nodo, lo añades a la lista de nodos visitados.
             }
             
             aux.setColorCelda(255, 255, 255);                 //Color de las paredes quitadas.
             aux.setEsLibre(false);
             hayVecinosLibres = false;
             Collections.shuffle(aux.getListaAdyacencia());    //Random pick de vecino
             
             for(int i = 0; i < aux.libres().size(); i++){
               hayVecinosLibres = true;
               maze.removerPared(aux, aux.libres().get(i));
               aux = aux.libres().get(i);
               aux.setColorCelda(255, 255, 255);           //Color de las celdas "creadas"
               aux.dibujar();                              //Marca todos los dead-ends si lo pones por sí mismo con un color diferente al del laberinto.
               break;
             }
           
           
           
             if(!hayVecinosLibres){                           //Si ya no hay vecinos libres en el nodo seleccionado, escoger uno de los nodos de la lista.
                listaVisitados.remove(aux);
                if(!listaVisitados.isEmpty()){
                  aux = listaVisitados.pop();                 //Si no barajeas la lista y escoges el añadido más recientemente, se vuelve una búsqueda en profundidad. Si escoges el más antiguo, resulta en un laberinto más engorroso que los obtenidos con el algoritmo de Prim. Si cambias el dominio del shuffle, de manera que no se revuelvan todos y sólo algunos, el algoritmo produce diferentes laberintos
                  aux.setColorCelda(255, 170, 50);           //Color de celdas revisitadas.
                  fill(255, 170, 50);                          //Color de paredes revisitadas.
                  maze.pintarPared(aux, aux.getListaCaminos().get(0));
                  aux.setColorCelda(255, 170, 50);
                  aux.dibujar();
                }  
              }
              if(listaVisitados.isEmpty()){
                laberintoCompleto = true;
                perfectMaze = true;
              }
            break;
       
       
       
  //Anchura
           case 4:
           if(celdasDisponibles.size() > 0){
             for(int i = 0; i < temp.libres().size(); i++){//Metes a los vecinos disponibles de la celda en la lista
              if(!celdasDisponibles.contains(temp.libres().get(i)))
                 celdasDisponibles.add(temp.libres().get(i));
              }  
             
             temp.setColorCelda(255, 255, 255);
             temp.setEsLibre(false);
             
              if(aux != null){
               aux.setColorCelda(255, 255, 255);
               aux.dibujar();
              }
             
             temp = celdasDisponibles.get(0);
             
             Collections.shuffle(temp.getListaAdyacencia());
             
             for(int i = 0; i < temp.getListaAdyacencia().size(); i++){
               if(!temp.getListaAdyacencia().get(i).esLibre()){
                 maze.removerPared(temp, temp.getListaAdyacencia().get(i));
                 aux = temp.getListaAdyacencia().get(i);
                 temp.getListaAdyacencia().get(i).setColorCelda(255, 255, 255);
                 temp.getListaAdyacencia().get(i).setEsLibre(false);
                 celdasDisponibles.remove(temp.getListaAdyacencia().get(i));
                 break;
               }
             }
            
             celdasDisponibles.remove(temp);
           }
           else{
             laberintoCompleto = true;
             perfectMaze = true;
           }
           break;
       
       
       
  //G&P's Algorithm Perfect Maze
           case 5:
           if(celdasDisponibles.size() > 0){
             for(int i = 0; i < temp.libres().size(); i++){//Metes a los vecinos disponibles de la celda en la lista
              if(!celdasDisponibles.contains(temp.libres().get(i)))
                 celdasDisponibles.add(temp.libres().get(i));
              }  
             
             temp.setColorCelda(255, 255, 255);
             temp.setEsLibre(false);
             
              if(aux != null){
               aux.setColorCelda(255, 255, 255);
               aux.dibujar();
              }
             
             temp = celdasDisponibles.getLast();
             
             Collections.shuffle(temp.getListaAdyacencia());
             
             for(int i = 0; i < temp.getListaAdyacencia().size(); i++){
               if(!temp.getListaAdyacencia().get(i).esLibre()){
                 maze.removerPared(temp, temp.getListaAdyacencia().get(i));
                 aux = temp.getListaAdyacencia().get(i);
                 temp.getListaAdyacencia().get(i).setColorCelda(255, 255, 255);
                 temp.getListaAdyacencia().get(i).setEsLibre(false);
                 celdasDisponibles.remove(temp.getListaAdyacencia().get(i));
                 break;
               }
             }
            
             celdasDisponibles.remove(temp);
           }
           else{
             laberintoCompleto = true;
             perfectMaze = true;
           }
           break;
           
           
           
  //G&P's Algorithm Braid Maze
           case 0:
           if(celdasDisponibles.size() > 0){
             for(int i = 0; i < temp.libres().size(); i++){//Metes a los vecinos disponibles de la celda en la lista
                 celdasDisponibles.add(temp.libres().get(i));
              }  
             
             temp.setColorCelda(255, 255, 255);
             temp.setEsLibre(false);
             
              if(aux != null){
               aux.setColorCelda(255, 255, 255);
               aux.dibujar();
              }
             
             temp = celdasDisponibles.getLast();
             
             Collections.shuffle(temp.getListaAdyacencia());
             
             for(int i = 0; i < temp.getListaAdyacencia().size(); i++){
               if(!temp.getListaAdyacencia().get(i).esLibre()){
                 maze.removerPared(temp, temp.getListaAdyacencia().get(i));
                 aux = temp.getListaAdyacencia().get(i);
                 temp.getListaAdyacencia().get(i).setColorCelda(255, 255, 255);
                 temp.getListaAdyacencia().get(i).setEsLibre(false);
                 celdasDisponibles.remove(temp.getListaAdyacencia().get(i));
                 break;
               }
             }
            
             celdasDisponibles.remove(temp);
           }
           else{
             laberintoCompleto = true;
             perfectMaze = false;
           }
           break;
           
           case 6: //Eller's Algorithm
               pushStyle();
               noStroke();
               fill(160, 210, 255);
               text("Algoritmo de Eller", 10, 36);
               popStyle();
               if(w < maze.celdas.length - 1){
                        //Primero, unir las celdas adyacentes de diferentes conjuntos aleatoriamente
                     for(int j = 0; j < maze.celdas[w].length - 1; j++){
                         if(!hashmapCeldas.get(maze.celdas[w][j]).equals(hashmapCeldas.get(maze.celdas[w][j + 1])) && Math.random() > .18){
                              hashmapCeldas.put(maze.celdas[w][j + 1], hashmapCeldas.get(maze.celdas[w][j]));
                              maze.celdas[w][j].setColorCelda(255, 255, 255);
                              maze.celdas[w][j].setEsLibre(false);
                              maze.removerPared(maze.celdas[w][j], maze.celdas[w][j + 1]);
                              fill(255, 255, 255);
                              maze.celdas[w][j + 1].setColorCelda(255, 255, 255);
                              maze.celdas[w][j + 1].setEsLibre(false);
                         } 
                     }
                     //Después, proyectar las celdas de los conjuntos hacia abajo aleatoriamente
                     
                     LinkedList<Integer> conjuntos = new LinkedList<Integer>();
                     
                     for(int j = 0; j < maze.celdas[w].length; j++){
                        if(!conjuntos.contains(hashmapCeldas.get(maze.celdas[w][j])))
                           conjuntos.add(hashmapCeldas.get(maze.celdas[w][j])); 
                     }
                     
                     int proyecciones = 0;
                     
                    
                        for(Integer entero : conjuntos){
                          proyecciones = 0;
                          while(proyecciones == 0){
                            for(int j = 0; j < maze.celdas[w].length; j++){
                               if(!maze.celdas[w][j].esLibre() && Math.random() > .8){
                                    hashmapCeldas.put(maze.celdas[w + 1][j], hashmapCeldas.get(maze.celdas[w][j]));
                                    maze.removerPared(maze.celdas[w][j], maze.celdas[w + 1][j]); 
                                    fill(255, 255, 255);
                                    maze.celdas[w + 1][j].setColorCelda(255, 255, 255);
                                    maze.celdas[w + 1][j].setEsLibre(false);
                                    proyecciones++;  
                               }
                             }
                          } 
                     }
                   
                     //Mappear las celdas que no tienen conjunto a uno nuevo
                     for(int j = 0; j < maze.celdas[w].length; j++){
                         if(!hashmapCeldas.containsKey(maze.celdas[w + 1][j])){
                            hashmapCeldas.put(maze.celdas[w + 1][j], maze.celdas[w + 1][j].hashCode() * 15);
                         } 
                     } 
                     w++;
                }
               
               else{
                  //Conectar la última fila
                  if(w == maze.celdas.length - 1){
                       for(int i = 0; i < maze.celdas[maze.celdas.length - 1].length - 1; i++){
                          maze.celdas[maze.celdas.length - 1][i].setColorCelda(255, 255, 255);
                          maze.celdas[maze.celdas.length - 1][i].setEsLibre(false);
                          maze.removerPared(maze.celdas[maze.celdas.length - 1][i], maze.celdas[maze.celdas.length - 1][i + 1]);
                          fill(255, 255, 255);
                          maze.celdas[maze.celdas.length - 1][i + 1].setColorCelda(255, 255, 255);
                          maze.celdas[maze.celdas.length - 1][i + 1].setEsLibre(false);     
                        }
                        w++;
                        laberintoCompleto = true;
                        perfectMaze = false;
                   } 
               }
               
               break;
            /*case 0: //Eller's Algorithm
               if(w < maze.celdas.length - 1){
                        //Primero, unir las celdas adyacentes de diferentes conjuntos aleatoriamente
                     for(int j = 0; j < maze.celdas[w].length - 1; j++){
                         if(!hashmapCeldas.get(maze.celdas[w][j]).equals(hashmapCeldas.get(maze.celdas[w][j + 1])) && Math.random() > .18){
                              hashmapCeldas.put(maze.celdas[w][j + 1], hashmapCeldas.get(maze.celdas[w][j]));
                              maze.celdas[w][j].setColorCelda(255, 255, 255);
                              maze.celdas[w][j].setEsLibre(false);
                              maze.removerPared(maze.celdas[w][j], maze.celdas[w][j + 1]);
                              fill(255, 255, 255);
                              maze.celdas[w][j + 1].setColorCelda(255, 255, 255);
                              maze.celdas[w][j + 1].setEsLibre(false);
                         } 
                     }
                     //Después, proyectar las celdas de los conjuntos hacia abajo aleatoriamente
                     
                     LinkedList<Integer> conjuntos = new LinkedList<Integer>();
                     
                     for(int j = 0; j < maze.celdas[w].length; j++){
                        if(!conjuntos.contains(hashmapCeldas.get(maze.celdas[w][j])))
                           conjuntos.add(hashmapCeldas.get(maze.celdas[w][j])); 
                     }
                     
                     int proyecciones = 0;
                     
                    
                        for(Integer entero : conjuntos){
                          proyecciones = 0;
                          while(proyecciones == 0){
                            for(int j = 0; j < maze.celdas[w].length; j++){
                               if(!maze.celdas[w][j].esLibre() && Math.random() > .8){
                                    hashmapCeldas.put(maze.celdas[w + 1][j], hashmapCeldas.get(maze.celdas[w][j]));
                                    maze.removerPared(maze.celdas[w][j], maze.celdas[w + 1][j]); 
                                    fill(255, 255, 255);
                                    maze.celdas[w + 1][j].setColorCelda(255, 255, 255);
                                    maze.celdas[w + 1][j].setEsLibre(false);
                                    proyecciones++;  
                               }
                             }
                          } 
                     }
                   
                     
                     for(int j = 0; j < maze.celdas[w].length; j++){
                         if(!hashmapCeldas.containsKey(maze.celdas[w + 1][j])){
                            hashmapCeldas.put(maze.celdas[w + 1][j], maze.celdas[w + 1][j].hashCode() * 15);
                         } 
                     } 
                     w++;
                }
               
               else{
                  if(w == maze.celdas.length - 1){
                       for(int i = 0; i < maze.celdas[maze.celdas.length - 1].length - 1; i++){
                          maze.celdas[maze.celdas.length - 1][i].setColorCelda(255, 255, 255);
                          maze.celdas[maze.celdas.length - 1][i].setEsLibre(false);
                          maze.removerPared(maze.celdas[maze.celdas.length - 1][i], maze.celdas[maze.celdas.length - 1][i + 1]);
                          fill(255, 255, 255);
                          maze.celdas[maze.celdas.length - 1][i + 1].setColorCelda(255, 255, 255);
                          maze.celdas[maze.celdas.length - 1][i + 1].setEsLibre(false);     
                        }
                        w++;
                        laberintoCompleto = true;
                        perfectMaze = false;
                   } 
               }
               
               break;*/
           }
         }
       }
      
///////////////////////////////////////////////////////////////////////////////////////////////////////
      
      
     else{
       
//ROMPER PAREDES DE DEAD-ENDS
       if(!reseteado){
         if(probabilidad > 0){
           for (int i = 0; i < maze.getCeldas().length; i++){
             for(int j = 0; j < maze.getCeldas()[i].length; j++){
               Celda celda = maze.getCeldas()[i][j];
               if(celda.getListaCaminos().size() < 2 && (int)(Math.random()*100) < probabilidad){
                 for(int k = 0; k < celda.getListaAdyacencia().size(); k++){
                   if(!celda.getListaCaminos().contains(celda.getListaAdyacencia().get(k))){
                     Celda c2 = celda.getListaAdyacencia().get(k);
                     c2.setColorCelda(255, 255, 255);
                     c2.dibujar();
                     maze.removerPared(celda, c2);
                     break;
                   }
                 }
               }
             }
           }
         }


//RESET
         delay(delay);
         for(int i = 0; i < maze.celdas.length; i++){
           for(int j = 0; j < maze.celdas[i].length; j++){
             aux = maze.celdas[i][j];
             aux.resetear();
           }
         }
         reseteado = true;
         aux = inicio;
         fill(255, 240, 0);  //Color del inicio
         inicio.dibujar();
         fill(255, 0, 0);    //Color del fin
         fin.dibujar();
         listaVisitados = new LinkedList<Celda>();
         listaBuscados = new LinkedList<Celda>();
         listaBuscados.offer(inicio);
         textSize(10);
         contador = 0;
       }
         
         
         
         
         
//////////////////////////////////////////////////////////////////////////////////////////////////
         
 //BUSQUEDAS
         else{
           if (millis() % velocidadBusqueda == 0 ) {
             switch(modoBusqueda){
      //Trémaux
               case 1:
                 if(aux != fin && perfectMaze){
                   LinkedList<Celda> CSVs = aux.CSV();    //Caminos Sin Visitar
                   //aux.setEsLibre(false);
                   if (!CSVs.isEmpty()){
                     if(aux != inicio){
                       aux.setColorCelda(30,80,180);      //EL camino
                     }
                     else{
                       aux.setColorCelda(255,255,0);      //Color del Inicio
                     }
                     aux.dibujar();
                     Collections.shuffle(CSVs);
                     aux.setEsLibre(false);
                     maze.pintarPared(aux, CSVs.get(0));
                     aux = CSVs.get(0);
                     aux.dibujar();
                   }
                   else{
                     aux.setColorCelda(160, 180, 255);       //Color de caminos ya visitados
                     aux.dibujar();
                     aux.setEsLibre(false);
                     maze.pintarPared(aux, aux.getListaCaminos().get(0));
                     aux = aux.getListaCaminos().get(0);
                     //aux.setColorCelda(255,255,255);
                     aux.dibujar();
                   }
                 }
                 else{
                   reseteado = false;
                   modoBusqueda = 2;
                   delay(delay);
                   velocidadBusqueda *= 3;
                 }
               break;
                 
      //Dead-end Filling
               case 2:
                 contador++;
                 for (int i = 0; i < maze.getCeldas().length; i++){
                   for (int j = 0; j < maze.getCeldas()[i].length; j++){
                     aux = maze.getCeldas()[i][j];
                     if ((aux.CSV().size() < 2) && (aux != inicio) && (aux != fin)){
                       aux.setEsLibre(false);
                       for (int a = 0; a < aux.getListaCaminos().size(); a++){
                         maze.pintarPared(aux, aux.getListaCaminos().get(a));
                         fill(160, 180, 255);
                       }
                       aux.setColorCelda(160, 180, 255);
                       aux.dibujar();
                       redraw();
                     }
                   }
                 }
                 if(contador == maze.getCeldas().length*maze.getCeldas()[0].length/4){
                   reseteado = false;
                   modoBusqueda = 3;
                   delay(delay);
                   velocidadBusqueda = 1;
                 }
               break;
             
               
      //Random Mouse
               case 3:
               if(randomMouse){
                 int n = aux.getListaCaminos().size();
                 if (aux != fin){
                   //El siguiente if es sólo para que el inicio siga amarillo incluso si el ratón vuelve a pasar por ahí.
                   if (auxAnterior != inicio && auxAnterior != fin){
                     aux.setColorCelda(aux.getR() - 30, aux.getG() - 25, aux.getB() - 10);
                     auxAnterior.dibujar();
                     maze.pintarPared(auxAnterior, aux);
                   }
                   else{
                     auxAnterior.setColorCelda(255, 255, 0);
                     auxAnterior.dibujar();
                   }
                   
                   if (n > 1){                                     //Si el ratón aún puede continuar:
                     int i = (int)(Math.random()*n);
                     for (int c = 0; c < n; i++, c++){
                       if (aux.getListaCaminos().get(i%n) != auxAnterior){
                         auxAnterior = aux;
                         aux = aux.getListaCaminos().get(i%n);    //que siga un camino aleatorio de los posibles.
                         auxAnterior.dibujar();
                         break;
                       }
                     }
                   }
                   else{                                    //Si el ratón ya no puede continuar
                     auxAnterior = aux;                     //Que se de la vuelta.
                     aux.setColorCelda(aux.getR() - 30, aux.getG() - 25, aux.getB() - 10);
                     aux = aux.getListaCaminos().get(0);
                     auxAnterior.dibujar();
                   }
                 }
                 else{
                   auxAnterior.dibujar();
                   reseteado = false;
                   modoBusqueda = 4;
                   delay(delay);
                   velocidadBusqueda = 2;
                 }
               }
               else{
                 auxAnterior.dibujar();
                 reseteado = false;
                 modoBusqueda = 4;
                 delay(delay);
                 velocidadBusqueda = 2;
               }
               break;
               
               
     //Left Wall Follower
               case 4:
                 if(aux != fin && perfectMaze){
                   dir--;
                   for(int i = 0; i < 2; i++, dir++){
                     if(aux.caminosOrdenados()[dir%4] != null){
                       if(aux != inicio){
                         if(aux.caminosOrdenados()[dir%4].esLibre()){
                           aux.setColorCelda(30, 80, 180);
                         }
                         else{
                           aux.setColorCelda(160, 180, 255);
                         }
                       }
                       else{
                         aux.setColorCelda(255, 255, 0);
                       }
                       aux.dibujar();
                       aux.setEsLibre(false);
                       maze.pintarPared(aux, aux.caminosOrdenados()[dir%4]);
                       aux = aux.caminosOrdenados()[dir%4];
                       aux.dibujar();
                       break;
                     }
                   }
                 }
                 else{
                   reseteado = false;
                   modoBusqueda = 5;
                   delay(delay);
                 }
               break;
               

      //Right Wall Follower
               case 5:
                 if(aux != fin && perfectMaze){
                   dir++;
                   for(int i = 0; i < 2; i++, dir--){
                     if(aux.caminosOrdenados()[dir%4] != null){
                       if(aux != inicio){
                         if(aux.caminosOrdenados()[dir%4].esLibre()){
                           aux.setColorCelda(30, 80, 180);
                         }
                         else{
                           aux.setColorCelda(160, 180, 255);
                         }
                       }
                       else{
                         aux.setColorCelda(255, 255, 0);
                       }
                       aux.dibujar();
                       aux.setEsLibre(false);
                       maze.pintarPared(aux, aux.caminosOrdenados()[dir%4]);
                       aux = aux.caminosOrdenados()[dir%4];
                       aux.dibujar();
                       break;
                     }
                   }
                 }
                 else{
                   reseteado = false;
                   modoBusqueda = 6;
                   delay(delay);
                 }
               break;
               
     //Anchura
               case 6:
                 if( aux != fin){
                   aux = listaBuscados.poll();
                   aux.setColorCelda(155, 0, 155);
                   aux.dibujar();
                   aux.setEsLibre(false);
                   for( int i = 0; i < aux.getListaCaminos().size(); i++){
                     if(!aux.getListaCaminos().get(i).esLibre()){
                       maze.pintarPared(aux, aux.getListaCaminos().get(i));
                     }
                   }
                   for( int i = 0; i<aux.CSV().size(); i++){
                     if(!listaBuscados.contains(aux.CSV().get(i))){
                       listaBuscados.offer(aux.CSV().get(i));
                     }
                   }
                 }
                 else{
                   reseteado = false;
                   modoBusqueda = 7;
                   delay(delay);
                 }
               break;
               
     //Profundidad
               case 7:
                 if( aux != fin){
                   aux = listaBuscados.pop();
                   aux.setColorCelda(155, 0, 155);
                   aux.dibujar();
                   aux.setEsLibre(false);
                   for( int i = 0; i < aux.getListaCaminos().size(); i++){
                     if(!aux.getListaCaminos().get(i).esLibre()){
                       maze.pintarPared(aux, aux.getListaCaminos().get(i));
                     }
                   }
                   for( int i = 0; i<aux.CSV().size(); i++){
                     if(!listaBuscados.contains(aux.CSV().get(i))){
                       listaBuscados.push(aux.CSV().get(i));
                     }
                   }
                 }
                 else{
                   reseteado = false;
                   modoBusqueda = 8;
                   delay(delay);
                 }
               break;
               
    //A*    chan chan chaaaan!!!!!!!!
               case 8:
               //celdasDisponibles son las celdas esperando ser buscadas.
               //listaBuscados son los que ya se vieron.
               if(aux != fin /*&& !perfectMaze*/){                                    //Si no se ha encontrado el final del laberinto,
                 listaBuscados.push(aux);                         //se agrega a la lista de visitados y de buscados
                 celdasDisponibles.remove(aux);                   //y se quita de la de celdas a visitar.
                 aux.setEsLibre(false);
                   
                   for(int i = 0; i < aux.getListaCaminos().size(); i++){               //Agrega todos los nodos vecinos del actual a los de posible búsqueda  
                     if(!listaBuscados.contains(aux.getListaCaminos().get(i)) &&         //si no están en los ya visitados
                       !celdasDisponibles.contains(aux.getListaCaminos().get(i))){       //ni en los que ya están en esa lista
                       fill(255, 0, 0);
                       maze.pintarPared(aux, aux.getListaCaminos().get(i));
                       celdasDisponibles.push(aux.getListaCaminos().get(i));
                       aux.getListaCaminos().get(i).setColorCelda(30, 80, 180);
                       aux.getListaCaminos().get(i).dibujar();
                       aux.setColorCelda(160, 180, 255);
                       aux.dibujar();
                     }
                   }
                   
                   temp = inicio;              //La celda más cercana?
                                      
                   for(int i = 0; i < celdasDisponibles.size(); i++){                  //Determina la celda a buscar más cercana a la meta.
                     if(maze.distancia(temp, fin) > maze.distancia(celdasDisponibles.get(i), fin)){
                       temp = celdasDisponibles.get(i);
                     }
                   }
                   
                   aux.setColorCelda(30, 80, 180);
                   temp.setColorCelda(30, 80, 180);
                   temp.dibujar();
                   fill(30, 80, 180);
                   maze.pintarPared(aux, temp);
                   fill(0, 255, 0);                    //Color de Celda Activa
                   aux = temp;
                   aux.setColorCelda(30, 80, 180);
                   aux.dibujar();
               }
               else{
                 reseteado = false;
                 modoBusqueda = 9;
                 delay(delay);
               }
               break;
                              
               
               
     //Dijkstra
             case 9:
               if(!perfectMaze){
                 if(aux != null){
                   aux.setColorCelda(160, 180, 255);
                   aux.dibujar();
                   aux.setEsLibre(false);
                   for( int i = 0; i < aux.getListaCaminos().size(); i++){
                     if(!aux.getListaCaminos().get(i).esLibre()){
                       fill(160, 180, 255);
                       maze.pintarPared(aux, aux.getListaCaminos().get(i));
                     }
                   }
                   for( int i = 0; i<aux.CSV().size(); i++){
                     if(!listaBuscados.contains(aux.CSV().get(i))){
                       listaBuscados.offer(aux.CSV().get(i));
                       if(aux.CSV().get(i).getPeso() > aux.getPeso()){
                         aux.CSV().get(i).setPeso(aux.getPeso() + 1);
                       }
                     }
                   }
                   aux = listaBuscados.poll();
                   temp = fin;
                 }
                 else{
                   if(temp != inicio){
                     auxAnterior = temp;
                     temp.setColorCelda(30, 80, 180);
                     temp.dibujar();
                     for(int i = 0; i < temp.getListaCaminos().size(); i++){
                       if(temp.getListaCaminos().get(i).getPeso() < temp.getPeso()){
                         maze.pintarPared(temp.getListaCaminos().get(i), temp);
                         temp = temp.getListaCaminos().get(i);
                         break;
                       }
                     }
                     temp.setColorCelda(30, 80, 180);
                     temp.dibujar();
                   }
                   else{
                     reseteado = false;
                     modoBusqueda = 1;
                     laberintoCompleto = false;
                     modoCreacion = (modoCreacion + 1)%7;
                     delay(delay);
                     maze = new Laberinto(15, 15);
                     listaVisitados = new LinkedList<Celda>();
                     listaBuscados  = new LinkedList<Celda>();
                     celdasDisponibles = new LinkedList<Celda>();
                     temp = maze.celdas[0][0];
                     celdasDisponibles.add(temp);
                     aux = maze.celdas[0][0];
                     auxAnterior = aux;
                     inicio = maze.celdas[0][0];
                     fin = maze.celdas[maze.celdas.length-1][maze.celdas[0].length-1];
                     clear();
                   }
                 }
               }
               else{
                 reseteado = false;
                 modoBusqueda = 1;
                 laberintoCompleto = false;
                 modoCreacion = (modoCreacion + 1)%7;
                 delay(delay);
                 maze = new Laberinto(15, 15);
                 listaVisitados = new LinkedList<Celda>();
                 listaBuscados  = new LinkedList<Celda>();
                 celdasDisponibles = new LinkedList<Celda>();
                 temp = maze.celdas[0][0];
                 celdasDisponibles.add(temp);
                 aux = maze.celdas[0][0];
                 auxAnterior = aux;
                 inicio = maze.celdas[0][0];
                 fin = maze.celdas[maze.celdas.length-1][maze.celdas[0].length-1];
                 clear();
               }
             break;
          }
       }
     }
  }
}

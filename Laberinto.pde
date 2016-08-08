
import java.util.*;

public class Laberinto{
   //Ivars
    public Celda[][] celdas;
    
  
   //Constructor
   public Laberinto(int ancho, int largo){
     
     celdas = new Celda[ancho][largo];
     int x = 0, y = 40;
     for(int i = 0; i < celdas.length; i++){//Crear grid
         x = 0;
         for(int j = 0; j < celdas[i].length; j++){
             celdas[i][j] = new Celda(x, y, 10, 10);
             x += 20;
         }
         y += 20 ;
     }
     
     for (int i = 0; i < ancho; i++){          //Recorre las celdas en "x"
       for (int j = 0; j < largo; j++){        //Recorre las celdas en "y"
         if( i > 0){                                               //Si no es de las celdas de hasta la izquierda
           celdas[i][j].getListaAdyacencia().add(celdas[i-1][j]);  //agregar la celda a su izquierda.
         }
         if( i < ancho-1){                                         //Si no es de las celdas de hasta la derecha
           celdas[i][j].getListaAdyacencia().add(celdas[i+1][j]);  //agregar la celda a su derecha.
         }
         if( j > 0){                                               //Si no es de las celdas de hasta arriba
           celdas[i][j].getListaAdyacencia().add(celdas[i][j-1]);  //agregar la celda de arriba.
         }
         if( j < largo-1){                                         //Si no es de las celdas de hasta abajo
           celdas[i][j].getListaAdyacencia().add(celdas[i][j+1]);  //Agregar la celda de abajo.
         }
       }
     }
     
     //Llenado de las listas de aydacencia de las celdas
     /*
     //Esquina superior izquierda
     celdas[0][0].getListaAdyacencia().add(celdas[0][1]);//derecha
     celdas[0][0].getListaAdyacencia().add(celdas[1][0]);//abajo
     
      //Esquina inferior izquierda 
     celdas[celdas.length - 1][0].getListaAdyacencia().add(celdas[celdas.length - 1][1]);//derecha
     celdas[celdas.length - 1][0].getListaAdyacencia().add(celdas[celdas.length - 2][0]);//arriba
    
     //Esquina superior derecha
     celdas[0][celdas[0].length - 1].getListaAdyacencia().add(celdas[0][celdas[0].length - 2]);//izquierda
     celdas[0][celdas[0].length - 1].getListaAdyacencia().add(celdas[1][celdas[1].length - 1]);//abajo   
     
      //Esquina inferior derecha
     celdas[celdas.length - 1][celdas[celdas.length - 1].length - 1].getListaAdyacencia().add(celdas[celdas.length - 1][celdas[celdas.length - 1].length - 2]);//izquierda
     celdas[celdas.length - 1][celdas[celdas.length - 1].length - 1].getListaAdyacencia().add(celdas[celdas.length - 2][celdas[celdas.length - 1].length - 1]);//arriba   
     
     //Borde izquierdo
     for(int i = 1; i < celdas.length - 1; i++){
             celdas[i][0].getListaAdyacencia().add(celdas[i][1]);//derecha
             celdas[i][0].getListaAdyacencia().add(celdas[i - 1][0]);//arriba
             celdas[i][0].getListaAdyacencia().add(celdas[i + 1][0]);//abajo
     }
     
     //Borde derecho
     for(int i = 1; i < celdas.length - 1; i++){ 
             celdas[i][celdas[i].length - 1].getListaAdyacencia().add(celdas[i][celdas[i].length - 2]);//izquierda
             celdas[i][celdas[i].length - 1].getListaAdyacencia().add(celdas[i - 1][celdas[i - 1].length - 1]);//arriba
             celdas[i][celdas[i].length - 1].getListaAdyacencia().add(celdas[i + 1][celdas[i + 1].length - 1]);//abajo
     }
     
     //Borde superior
     for(int i = 1; i < celdas.length - 1; i++){ 
             celdas[0][i].getListaAdyacencia().add(celdas[0][i + 1]);//derecha
             celdas[0][i].getListaAdyacencia().add(celdas[0][i - 1]);//izquierda
             celdas[0][i].getListaAdyacencia().add(celdas[1][i]);//abajo
     }
     
     //Borde inferior
     for(int i = 1; i < celdas.length - 1; i++){ 
             celdas[celdas.length - 1][i].getListaAdyacencia().add(celdas[celdas.length - 1][i + 1]);//derecha
             celdas[celdas.length - 1][i].getListaAdyacencia().add(celdas[celdas.length - 1][i - 1]);//izquierda
             celdas[celdas.length - 1][i].getListaAdyacencia().add(celdas[celdas.length - 2][i]);//arriba
     }
     
     //Todo lo de en medio
     for(int i = 1; i < celdas.length - 1; i++){//Crear lista de adyacencia
         for(int j = 1; j < celdas[i].length - 1; j++){           
             celdas[i][j].getListaAdyacencia().add(celdas[i - 1][j]);//arriba
             celdas[i][j].getListaAdyacencia().add(celdas[i + 1][j]);//abajo
             celdas[i][j].getListaAdyacencia().add(celdas[i][j - 1]);//izquierda
             celdas[i][j].getListaAdyacencia().add(celdas[i][j + 1]);//derecha
         }
     }*/
     
   }//Fin constructor
  
  
   //Setters y Getters
  public Celda[][] getCeldas(){
    return celdas;
  }

   //Métodos
   public void dibujar(){
      for(int i = 0; i < celdas.length; i++){
         for(int j = 0; j < celdas[i].length; j++){           
             celdas[i][j].dibujar(); 
         }
     }
   }
   
   public void generarLaberintoBusquedaProfundidad(Celda inicio){//La recursión simula la pila, por lo que no es necesario utilizar un objeto del tipo Stack
       inicio.setColorCelda(255, 255, 255);//La pintas de blanco
       inicio.setEsLibre(false);//Marcas la celda como visitada 
       Collections.shuffle(inicio.getListaAdyacencia());//Barajeas la lista cada vez que hagas una recursión, de manera que la selección del vecino sea aleatoria.
       
       for(int i = 0; i < inicio.getListaAdyacencia().size(); i++){
          if(inicio.getListaAdyacencia().get(i).esLibre()){//Checas si hay vecinos del nodo que estén libres.
             removerPared(inicio, inicio.getListaAdyacencia().get(i));//Quitas la pared entre la celda actual y la celda vecina escogida.
             generarLaberintoBusquedaProfundidad(inicio.getListaAdyacencia().get(i));//Haces recursión con uno de sus vecinos, el cual es seleccionado aleatoriamente.
          }
       }
   }
   
   public void growingTreeAlgorithm(Celda inicio){
       ArrayList<Celda> listaVisitados = new ArrayList<Celda>();
       Celda aux = inicio;
       boolean hayVecinosLibres;
       do{
         if(!listaVisitados.contains(aux))
             listaVisitados.add(aux);//Si visitas un nodo, lo añades a la lista de nodos visitados. 
             
         aux.setColorCelda(255, 255, 255);
         aux.setEsLibre(false);
         hayVecinosLibres = false;
         Collections.shuffle(aux.getListaAdyacencia());//Random pick de vecino
         
         for(int i = 0; i < aux.getListaAdyacencia().size(); i++){
              if(aux.getListaAdyacencia().get(i).esLibre()){//Checas si hay vecinos del nodo que estén libres.
                hayVecinosLibres = true;
                removerPared(aux, aux.getListaAdyacencia().get(i));
                aux = aux.getListaAdyacencia().get(i);
                break;
              }
         }
         
         if(!hayVecinosLibres){//Si ya no hay vecinos libres en el nodo seleccionado, escoger uno de los nodos de la lista aleatoriamente.
             listaVisitados.remove(aux);
             if(!listaVisitados.isEmpty()){
               Collections.shuffle(listaVisitados);
               aux = listaVisitados.get(0);//Si no barajeas la lista y escoges el añadido más recientemente, se vuelve una búsqueda en profundidad. Si escoges el más antiguo, resulta en un laberinto más engorroso que los obtenidos con el algoritmo de Prim. Si cambias el dominio del shuffle, de manera que no se revuelvan todos y sólo algunos, el algoritmo produce diferentes laberintos
             }  
         }
           
         
       }while(!listaVisitados.isEmpty());
     
   }
   
   
  /* public void wilsonsAlgorithm(Celda inicio){
      LinkedList<Celda> caminoFantasma = new LinkedList<Celda>();
      ArrayList<Celda> visitados = new ArrayList<Celda>();
      inicio.setEsLibre(false);
      inicio.setColorCelda(255, 255, 255);
      visitados.add(inicio);
      Celda aux = inicio;
       int num1 = (int)(Math.random() * celdas.length), num2 = (int)(Math.random() * celdas[0].length);
      
      do{
        do{
          
        }while();
        celdas[num1][num2].setColorCelda(255);
        celdas[num1][num2].setEsLibre(false);//Celda random
        
        
      }while(!visitados.isEmpty());
      
      
      
      
      
   }*/
   
   public void removerPared(Celda c1, Celda c2){
       //remover pared a la derecha de c1
       if(c1.getX() - c2.getX() < 0)
         rect(c1.getX() + c1.getAncho(), c1.getY(), c1.getAncho(), c1.getLargo());
       else{
          if(c1.getX() - c2.getX() > 0) //pared a la izquierda de c1
             rect(c2.getX() + c2.getAncho(), c2.getY(), c2.getAncho(), c2.getLargo());
          else{
             if(c1.getY() - c2.getY() < 0)//pared de abajo de c1
                 rect(c1.getX(), c1.getY() + c1.getLargo(), c1.getAncho(), c1.getLargo());
             else{
                if(c1.getY() - c2.getY() > 0)//pared de arriba de c1
                  rect(c2.getX(), c2.getY() + c2.getLargo(), c2.getAncho(), c2.getLargo());
             }
          }
       }
       c1.getListaCaminos().add(c2);    //Agrega sólo las celdas entre las que no hay paredes a la lista de celdas accesibles desde una celda.
       c2.getListaCaminos().add(c1);
       fill(255, 0, 0);                 //Color del creador.
   }
   
   public double distancia(Celda c1, Celda c2){
     return Math.sqrt(Math.pow(Math.abs(c1.getX()-c2.getX()), 2) + Math.pow(Math.abs(c1.getY()-c2.getY()), 2));
   }
   
   public void pintarPared(Celda c1, Celda c2){
       //remover pared a la derecha de c1
       if(c1.getX() - c2.getX() < 0){
         rect(c1.getX() + c1.getAncho(), c1.getY(), c1.getAncho(), c1.getLargo());
       }
       else{
          if(c1.getX() - c2.getX() > 0) //pared a la izquierda de c1
             rect(c2.getX() + c2.getAncho(), c2.getY(), c2.getAncho(), c2.getLargo());
          else{
             if(c1.getY() - c2.getY() < 0)//pared de abajo de c1
                 rect(c1.getX(), c1.getY() + c1.getLargo(), c1.getAncho(), c1.getLargo());
             else{
                if(c1.getY() - c2.getY() > 0)//pared de arriba de c1
                  rect(c2.getX(), c2.getY() + c2.getLargo(), c2.getAncho(), c2.getLargo());
             }
          }
       }
       fill(255, 0, 0);
   }
}


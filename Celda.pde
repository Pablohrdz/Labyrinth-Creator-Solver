import java.util.*;

public class Celda{
   //Ivars
   private float x;
   private float y;
   private int ancho;
   private int largo;
   private int r, g, b;
   private boolean esLibre;
   private LinkedList<Celda> listaAdyacencia;
   private LinkedList<Celda> listaCaminos;
   private int peso;
  
   //Constructor
   public Celda(float x, float y, int ancho, int largo){
     this.x = x;
     this.y = y;
     this.ancho = ancho;
     this.largo = largo;
     r = 0;
     g = 0;
     b = 0;
     listaAdyacencia = new LinkedList<Celda>();
     listaCaminos = new LinkedList<Celda>();
     esLibre = true;
     peso = (int)Double.POSITIVE_INFINITY;
   }
  
   //Getters y Setters
   public float getX(){
      return x; 
   }
   
   public float getY(){
      return y; 
   }
   
   public int getAncho(){
     return ancho;
   }
   
   public int getLargo(){
     return largo; 
   }
   
   public int getR(){
      return r; 
   }
   
   public int getG(){
      return g; 
   }
   
   public int getB(){
      return b; 
   }
   
   public void setX(float xx){
      x = xx; 
   }
   
   public void setY(float yy){
      y = yy; 
   }
   
   public LinkedList<Celda> getListaAdyacencia(){
      return listaAdyacencia; 
   }
   
   public void setListaAdyacencia(LinkedList<Celda> lista){
      listaAdyacencia = lista; 
   }
   
   public LinkedList<Celda> CSV(){        //Caminos Sin Visitar
     LinkedList<Celda> CSV = new LinkedList<Celda>();
     for(int i = 0; i< listaCaminos.size(); i++){
       if (listaCaminos.get(i).esLibre()){
         CSV.push(listaCaminos.get(i));
       }
     }
     return CSV;
   }
      
   public LinkedList<Celda> getListaCaminos(){
      return listaCaminos; 
   }
   
   public void setListaCaminos(LinkedList<Celda> lista){
      listaCaminos = lista;
   }
   
   public void setColorCelda(int r, int g, int b){
      this.r = r;
      this.g = g;
      this.b = b; 
   }
   
   public int[] getRGB(){
     int a[] = {r, g, b};
     return a;
   }
   
   public boolean esLibre(){
      return esLibre; 
   }
   
   public void setEsLibre(boolean esLibre){
      dibujar();
      this.esLibre = esLibre; 
   }
   
   public void setPeso(int peso){
     this.peso = peso;
   }
   
   public int getPeso(){
     return peso;
   }
   
   ////////////////////////////////////////////////////////////////////
   
   //MÉTODOS
   public void resetear(){
     //setColorCelda(255, 255, 255);
     esLibre = true;
     dibujar();
     fill(255, 255, 255);                               //Color con el que se resetean las paredes.
     for(int i = 0; i < listaCaminos.size(); i++){
       if(x - listaCaminos.get(i).getX() < 0)
         rect(x + ancho, y, ancho, largo);
       else{
          if(x - listaCaminos.get(i).getX() > 0)        //pared a la izquierda de c1
             rect(listaCaminos.get(i).getX() + listaCaminos.get(i).getAncho(), listaCaminos.get(i).getY(), listaCaminos.get(i).getAncho(), listaCaminos.get(i).getLargo());
          else{
             if(y - listaCaminos.get(i).getY() < 0)     //pared de abajo de c1
                 rect(x, y + largo, ancho, largo);
             else{
                if(y - listaCaminos.get(i).getY() > 0)  //pared de arriba de c1
                  rect(listaCaminos.get(i).getX(), listaCaminos.get(i).getY() + listaCaminos.get(i).getLargo(), listaCaminos.get(i).getAncho(), listaCaminos.get(i).getLargo());
             }
          }
       }
     }
   }
   
   public Celda[] caminosOrdenados(){      //Este método da un arreglo ordenado antihorariamente desde el "sur".
     Celda[] celdas = new Celda[4];
     for(int i = 0; i < listaCaminos.size(); i++){
       if(listaCaminos.get(i).getX() != x){
         if(listaCaminos.get(i).getX() < x){      //Si la celda está a la izquierda
           celdas[3] = listaCaminos.get(i);       // se pone en la 3
         }
         else{                                    //Si está a la derecha
           celdas[1] = listaCaminos.get(i);       // se pone en la 1
         }
       }
       
       if(listaCaminos.get(i).getY() != y){
         if(listaCaminos.get(i).getY() < y){      //Si está abajo
           celdas[0] = listaCaminos.get(i);       // se pone en la 0
         }
         else{                                    //Si está arriba
           celdas[2] = listaCaminos.get(i);      //se pone en la 2
         }
       }
     }
     return celdas;
   }
   
   public void dibujar(){
      rect(x, y, ancho, largo); 
      fill(r, g, b);
   }
   
  public boolean hayLibres(){                    //Indica si la celda todavía tiene vecinos sin visitar
    for(int i = 0; i< listaAdyacencia.size(); i++){
      if (listaAdyacencia.get(i).esLibre()){
        return true;
      }
    }
    return false;
  }
   
   public LinkedList<Celda> libres(){                   //Devuelve un linked list de los vecinos que no se han visitado.
     LinkedList<Celda> libres = new LinkedList<Celda>();
     for(int i = 0; i< listaAdyacencia.size(); i++){
       if (listaAdyacencia.get(i).esLibre()){
         libres.push(listaAdyacencia.get(i));
       }
     }
     return libres;
   }
   
   public int hashCode(){
      return  0 + ((int)(x + y));
   }
}

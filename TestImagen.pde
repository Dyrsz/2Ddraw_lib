 float t,t0, dx1, dy1, dx2, dy2;
 boolean sentido = false;
 
 void setup () {
   t0 = 0;
 }
 
 void draw () {
   background (0);
   dx1 = width/2;
   if (!sentido) {
     dy1 = (1-t)*(height/2-300) + t*(height/2+300);
   } else {
     dy1 = (1-t)*(height/2+300) + t*(height/2-300);
   }
   //dy1 = t*t*t*t*(height/2) + (1-t)*(1-t)*(1-t)*(1-t)*(height/2);
   for (int i = 0; i < 10; i++) {
     noFill ();
     stroke (200);
     if (i%2 == 1) {
       ellipse (dx1, dy1, 500, 500);
     } else {
       polygon (6, dx1, dy1, 250, 2*PI/12 + i*2*PI/10, color (200));
     }
     dx2 = rot (dx1,dy1,width/2,height/2,2*PI/10)[0];
     dy2 = rot (dx1,dy1,width/2,height/2,2*PI/10)[1];
     dx1 = dx2;
     dy1 = dy2;
   }
   t0 += 0.02;
   if (t0 >= 1) {
     sentido = !sentido;
     t0 --;
   }
   t = t0*t0*t0;
 }
 
 void polygon (int n, float cx, float cy, float r, float angle, color col) {
   float x1, y1, x2, y2;
   x1 = rot (cx, cy-r, cx, cy, angle)[0];
   y1 = rot (cx, cy-r, cx, cy, angle)[1];
   for (int i = 0; i < n; i++) {
     noStroke ();
     fill (col);
     ellipse (x1, y1, 5, 5);
     x2 = rot (x1, y1, cx, cy, 2*PI/n)[0];
     y2 = rot (x1, y1, cx, cy, 2*PI/n)[1];
     stroke (col);
     line (x1,y1,x2,y2);
     x1 = x2;
     y1 = y2;
   }
 }
 
 float [] rot (float x, float y, float cx, float cy, float rad) {
   float[] ret = new float [2];
   x = x - cx;
   y = y - cy;
   ret [0] = x*cos(rad) - y*sin(rad) + cx;
   ret [1] = x*sin(rad) + y*cos(rad) + cy;
   return ret;
 }
 
 class TrayectoriaLineal () {
   
   float xi, xf, vel, t, t0;
   boolean idaYVueltaActiva;
   boolean sentido = true; // Auxiliar.
   int type = 1;
   
   TrayectoriaLineal (float xit, float xft, float velt, boolean idaYVuelta) {
     xi = xit;
     xf = xft;
     vel = velt;
     idaYVueltaActiva = idaYVuelta;
   }
   
   TrayectoriaLineal (float xit, float xft, float velt, boolean idaYVuelta, int ttype) {
     xi = xit;
     xf = xft;
     vel = velt;
     idaYVueltaActiva = idaYVuelta;
     type = ttype;
   }
   
   void OnSetup () {
     t0 = 0;
   }
   
   void OnDraw () {
     t0 += vel;
     if (t0 >= 1) {
       if (idaYVueltaActiva) sentido = !sentido;
       t0 --;
     }
     t = functype (type, t0);
   }
   
   float coord () {
     float ret;
     if (!idaYVueltaActiva) {
       ret = (1-t)*xi + t*xf;
     } else {
       if (sentido) {
         ret = (1-t)*xi + t*xf;
       } else {
         ret = (1-t)*xf + t*xi;
       }
     }
   }
   
   float functype (int typ, float t0t) {
     return potencia (t0t, typ);
   }
   
   float potencia (float a, int b) {
     float ret = 1;
     for (int i = 0; i < b; i++) ret = ret*a;
     return ret;
   }
 }
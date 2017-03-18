 class TrayectoriaLineal {
   
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
     return ret;
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
 TrayectoriaLineal tr;
 
 float x1, y1, x2, y2;
 
 void setup () {
   tr = new TrayectoriaLineal (height/2-300, height/2+300, 0.02, true, 3);
   tr.OnSetup();
 }
 
 void draw () {
   background (0);
   tr.OnDraw ();
   x1 = width/2;
   y1 = tr.coord ();
   for (int i = 0; i < 10; i++) {
     noFill ();
     stroke (tr.CenDisNormalized ()*255);
     if (i%2 == 1) {
       ellipse (x1, y1, 500, 500);
     } else {
       polygon (6, x1, y1, 250, 2*PI/12 + i*2*PI/10, color (tr.CenDisNormalized ()*255));
     }
     x2 = rot (x1,y1,width/2,height/2,2*PI/10)[0];
     y2 = rot (x1,y1,width/2,height/2,2*PI/10)[1];
     x1 = x2;
     y1 = y2;
   }
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
     strokeWeight(10);
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
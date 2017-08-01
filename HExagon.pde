import toxi.geom.*;
class HExagon
{
  PShape Hexagon;
  int changed=0;
  Polygon2D poly;
  float centerX, centerY, side;
  int Coordinates, i, j;
  HExagon(float x, float y, int z, int Coordinate)
  {
    centerX=x;
    centerY=y;
    side=z;
    poly=new Polygon2D();
    float angle = TWO_PI/ 6;
    Hexagon= createShape();
    Hexagon.beginShape();
    Coordinates=Coordinate;
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = centerX + cos(a) * side;
      float sy = centerY + sin(a) * side;
      Hexagon.vertex(sx, sy);
      poly.add(new Vec2D(sx, sy));
    }
    Hexagon.endShape(CLOSE);
  }
  void draw1()
  {
    shape(Hexagon);
  }

  void drawCoordinates()
  {
    textSize(14);
    fill(0);
    String s="("+Coordinates/size+","+Coordinates%size+")";
    //String s=""+Coordinates;
    text(s, centerX, centerY);
  }
  void showCost()
  {
    textSize(14);
    fill(0);
    String s="("+ai.ACost[Coordinates]+","+ai.BCost[Coordinates]+")";
    text(s, centerX, centerY);
  }
  void changedIt()
  {
    if (changed==0)
    {
      fill(255);
      shape(Hexagon);
    } else if (player==1)
    {
      fill(0, 255, 0);
      shape(Hexagon);
    } else
    {
      fill(0, 0, 255);
      shape(Hexagon);
    }
  }
  boolean changcolor(int x,int y)
  {
    if (changed==0)
    {
      if (poly.containsPoint(new Vec2D(x, y)))
      {
        if (player==1)
        {
          Hexagon.setFill(color(0, 255, 0));
        } else
        {
          Hexagon.setFill(color(0, 0, 255));
        }
        return true;
      } else 
      {
        Hexagon.setFill(color(255));
        return false;
      }
    } else
    {
      return false;
    }
  }
}
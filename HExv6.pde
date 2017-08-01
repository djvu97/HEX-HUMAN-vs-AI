import javax.swing.JOptionPane;
import java.util.HashSet;
Ai ai;
HExagon[] shapeArr;
Graph graph;
int totalMoves=0;
corner Corner;
int player=1;
PFont mono, mono1;
int lastClick=0;
int state=0;
PImage icon;
int size=7;
int sizeSquare;
int Score;
int a1, a2, b1, b2;
void setup()
{
  icon=loadImage("Hex.PNG");
  surface.setIcon(icon);

  ArrayList<HExagon> shapes = new ArrayList<HExagon>();
  size(700, 600);
  surface.setTitle("___HEX___");
  String name=null;
  try {
    name=JOptionPane.showInputDialog(null, "ENTER SIZE", 7);
  }
  finally
  {
    if (name==null)
    {
      name="7";
    }
  }
  size=Integer.parseInt(name);
  mono = loadFont("BradleyHandITC-48.vlw");
  mono1=loadFont("SegoeUI-SemilightItalic-48.vlw");
  float x, y, xmin, ymin;
  int side=210/size;
  x=width/2;
  int q=0;
  y=182+side+size*0.866;
  xmin=x;
  sizeSquare=size*size;
  ymin=y;
  for (int i=0; i<size; i++)
  {
    for (int j=0; j<size; j++)
    {
      shapes.add(new HExagon(x, y, side, i*size+j));
      x+=(1.5*side);
      y+=(0.866*side);
    }
    xmin+=(-1)*1.5*side;
    ymin+=0.866*side;
    x=xmin;
    y=ymin;
  }
  shapeArr=shapes.toArray(new HExagon[shapes.size()]);
  graph=new Graph();
  Corner= new corner();
  ai=new Ai();
}

void draw()
{
  if (state==2)End();
  else if (state==0)dothis();
  else init();
}
void End()
{ 
  fill(0, 30);
  rect(0, 0, width, height);
  fill(255);
  textSize(26);
  text("Click here to restart", 350, 100);
  textSize(54);
  fill(color(random(255), random(255), random(255)));
  if (player==1) text("Player 1 WON", 350, 50);
  else text("Player 2 WON", 350, 50);
}
void init()
{
  background(0);
  Rectangles();
  if (player==1) {
    fill(0, 255, 0);
    textFont(mono);
    textSize(60);
    text("Player 1", 350, 50);
  } else
  {
    textFont(mono);
    fill(0, 0, 255);
    textSize(60);
    text("Player 2", 350, 50);
  } 
  for (HExagon part : shapeArr) {
    part.draw1();
    part.changcolor(mouseX, mouseY);
    part.showCost();
    //part.drawCoordinates();
  }
  fill(255);
  textSize(26);
  String s1=Score+" "+a1+" "+a2+" "+b1+" "+b2;
  text(s1, 350, 100);
}

void mousePressed()
{
  if (state==2)
  {
    graph.reset();
    delay(1);
    player=1;
    totalMoves=0;
    state=0;
    Corner.BL=-1;
    Corner.BR=-1;
    Corner.GL=-1;
    Corner.GR=-1;
  } 
  if (state==1)
  {
    totalMoves++;
    for (HExagon part : shapeArr) {
      if (part.changcolor(mouseX, mouseY))
      {
        part.changed=1;
        graph.changedIT(part.Coordinates,1);
        Score=ai.Calculate(graph.State);
        if (totalMoves>2*(size-1))Corner.Won();
        if(state==2)return;
        player=-player;
        int a;
        if (totalMoves==1)a=int(random(sizeSquare));
        else {
          a= ai.MonteCarlo(graph.State,-1,2);
        }
        println(a);
        if (shapeArr[a].changcolor(int(shapeArr[a].centerX), int(shapeArr[a].centerY))) {
          shapeArr[a].changed=1;
          totalMoves++;
          graph.State[a]=-1;
          graph.changedIT(a,-1);
          Score=ai.Calculate(graph.State);
          if (totalMoves>2*(size-1))Corner.Won();
          if(state==2)return;
          player=-player;
        }
      }
    }
  }
  if (state==0) { 
    state=1;
  }
}

void Rectangles()
{
  fill(0, 0, 255);
  rect(30, 182, 320, 192);
  fill(0, 255, 0);
  rect(350, 182, 320, 192);
  fill(0, 255, 0);
  rect(30, 372, 320, 192);
  fill(0, 0, 255);
  rect(350, 372, 320, 192);
}
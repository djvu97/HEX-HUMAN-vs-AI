class Graph {
  int[] State;
  int[][] ConnectedPoints;
  int[] Union;
  Graph()
  {
    ConnectedPoints=new int[sizeSquare+4][6];
    State=new int[sizeSquare];
    Union=new int[sizeSquare];
    for (HExagon shape : shapeArr)
    {
      int no=shape.Coordinates; 
      int x=no/size; 
      int y=no%size;
      State[no]=0;
      Union[no]=no;
      if (x==0&&y==0)
      {
        ConnectedPoints[no][0]=(x)*size+(y+1);
        ConnectedPoints[no][1]=(x+1)*size+(y+1);
        ConnectedPoints[no][2]=(x+1)*size+(y);
        ConnectedPoints[no][3]=-1;
        ConnectedPoints[no][4]=-1;
        ConnectedPoints[no][5]=-1;
      } else if (x==0&&y==size-1)
      {
        ConnectedPoints[no][0]=(x)*size+(y-1);
        ConnectedPoints[no][1]=(x+1)*size+(y);
        ConnectedPoints[no][2]=-1; 
        ConnectedPoints[no][3]=-1;
        ConnectedPoints[no][4]=-1; 
        ConnectedPoints[no][5]=-1;
      } else if (x==size-1&&y==size-1)
      {
        ConnectedPoints[no][0]=(x)*size+(y-1);
        ConnectedPoints[no][1]=(x-1)*size+(y-1);
        ConnectedPoints[no][2]=(x-1)*size+(y);
        ConnectedPoints[no][3]=-1; 
        ConnectedPoints[no][4]=-1;
        ConnectedPoints[no][5]=-1;
      } else if (x==size-1&&y==0)
      {
        ConnectedPoints[no][0]=(x)*size+(y+1);
        ConnectedPoints[no][1]=(x-1)*size+(y);
        ConnectedPoints[no][2]=-1;
        ConnectedPoints[no][3]=-1;
        ConnectedPoints[no][4]=-1; 
        ConnectedPoints[no][5]=-1;
      } else if (x==0)
      {
        ConnectedPoints[no][0]=(x)*size+(y-1);
        ConnectedPoints[no][1]=(x+1)*size+(y);
        ConnectedPoints[no][2]=(x+1)*size+(y+1);
        ConnectedPoints[no][3]=(x)*size+(y+1);
        ConnectedPoints[no][4]=-1;
        ConnectedPoints[no][5]=-1;
      } else if (y==0)
      {
        ConnectedPoints[no][0]=(x-1)*size+(y);
        ConnectedPoints[no][1]=(x+1)*size+(y);
        ConnectedPoints[no][2]=(x)*size+(y+1);
        ConnectedPoints[no][3]=(x+1)*size+(y+1);
        ConnectedPoints[no][4]=-1; 
        ConnectedPoints[no][5]=-1;
      } else if (x==size-1)
      {
        ConnectedPoints[no][0]=(x)*size+(y-1);
        ConnectedPoints[no][1]=(x-1)*size+(y-1);
        ConnectedPoints[no][2]=(x-1)*size+(y);
        ConnectedPoints[no][3]=(x)*size+(y+1);
        ConnectedPoints[no][4]=-1;
        ConnectedPoints[no][5]=-1;
      } else if (y==size-1)
      {
        ConnectedPoints[no][0]=(x+1)*size+(y);
        ConnectedPoints[no][1]=(x)*size+(y-1);
        ConnectedPoints[no][2]=(x-1)*size+(y-1);
        ConnectedPoints[no][3]=(x-1)*size+(y);
        ConnectedPoints[no][4]=-1;
        ConnectedPoints[no][5]=-1;
      } else
      {
        ConnectedPoints[no][0]=(x)*size+(y+1);
        ConnectedPoints[no][1]=(x)*size+(y-1);
        ConnectedPoints[no][2]=(x+1)*size+(y);
        ConnectedPoints[no][3]=(x-1)*size+(y);
        ConnectedPoints[no][4]=(x-1)*size+(y-1);
        ConnectedPoints[no][5]=(x+1)*size+(y+1);
      }
    }
  }
  void Change_all(int x, int y)
  {
    Union[x]=y;
    for (int neighbours : ConnectedPoints[x])
    {
      if (neighbours!=-1&&State[neighbours]==player&&Union[neighbours]!=y)
      {
        Change_all(neighbours, y);
      }
    }
  }
  void UnionFind(int x)
  {
    for (int neighbours : ConnectedPoints[x])
    {
      if (neighbours!=-1&&State[neighbours]==player)
      {
        Change_all(x, Union[neighbours]);
        break;
      }
    }
  }
  void ShowUnion()
  {
    fill(0);
    textSize(14);
    for (HExagon x : shapeArr)
    {
      String s="("+x.Coordinates+","+Union[x.Coordinates]+")";
      text(s, x.centerX, x.centerY);
    }
  }
  void changedIT(int n, int q)
  {
    State[n]=q;
    shapeArr[n].changedIt();
    UnionFind(n);
    Corner.add();
  }
  void reset()
  {
    for (int i=0; i<sizeSquare; i++)
    {
      State[i]=0;
      shapeArr[i].changed=0;
      shapeArr[i].changedIt();
      Union[i]=i;
    }
  }
}
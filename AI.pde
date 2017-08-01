class Ai
{
  boolean visited[]=new boolean[sizeSquare];
  int[] ACost=new int[sizeSquare];
  int[] BCost=new int[sizeSquare];
  int Points[]=new int[2];
  int Calculate(int[] States)
  {
    for (int i=0; i<sizeSquare; i++)
    {
      ACost[i]=99;
      BCost[i]=99;
    }
    for (int coordinate=0; coordinate<sizeSquare; coordinate++)
    {
      if (States[coordinate]==1)
      {
        ACost[coordinate]=0;
        Change_Distances(States, coordinate, ACost, 1);
      }
      if (States[coordinate]==-1)
      {
        BCost[coordinate]=0;
        Change_Distances(States, coordinate, BCost, -1);
      }
    }
    return Heuristics(States);
  }
  int Heuristics(int []States)
  {
    int GreenCost=0;
    int BlueCost=0;
    int min=90;
    int firstPoint=0;
    int endPoint=0;
    boolean flag=false;
    for (int i=0; i<size; i++)
    {
      for (int j=0; j<size; j++)
      {
        if (ACost[i*size+j]==0)
        {
          firstPoint=i*size+j;
          flag=true;
        }
        if (flag==true)break;
      }
      if (flag==true)break;
    }
    flag=false;
    for (int i=size-1; i>=0; i--)
    {
      for (int j=size-1; j>=0; j--)
      {
        if (ACost[i*size+j]==0)
        {
          endPoint=i*size+j;
          flag=true;
        }
        if (flag==true)break;
      }
      if (flag==true)break;
    }
    GreenCost=(firstPoint/size)+(endPoint/size)-2;
    a1=firstPoint;
    a2=endPoint;
    GreenCost*=10;
    GreenCost+=DFS(firstPoint, endPoint, 1, States);
    flag=false;
    firstPoint=0;
    endPoint=0;
    for (int i=0; i<size; i++)
    {
      for (int j=0; j<size; j++)
      {
        if (BCost[j*size+i]==0)
        {
          firstPoint=j*size+i;
          flag=true;
        }
        if (flag==true)break;
      }
      if (flag==true)break;
    }
    flag=false;
    for (int i=size-1; i>=0; i--)
    {
      for (int j=size-1; j>=0; j--)
      {
        if (BCost[j*size+i]==0)
        {
          endPoint=j*size+i;
          flag=true;
        }
        if (flag==true)break;
      }
      if (flag==true)break;
    }
    BlueCost=(firstPoint%size)+(endPoint%size)-2;
    BlueCost*=10;
    b1=firstPoint;
    b2=endPoint;
    BlueCost+=DFS(firstPoint, endPoint, -1, States);
    for (int i=0; i<size; i++)
    {
      int k=0;
      for (int j=0; j<size; j++)
      {
        if (BCost[j*size+i]==0)k++;
      }
      if (k>=3)BlueCost-=30;
    }
    return (GreenCost-BlueCost);
  }
  int DFS(int x, int y, int player, int []States)
  {
    ArrayList<Integer> On=new ArrayList<Integer>();
    boolean Visited[]=new boolean[sizeSquare];
    int Parents[]=new int[sizeSquare];
    On.add(x);
    Parents[x]=x;
    Visited[x]=true;
    while (!On.isEmpty())
    {
      int i=On.get(0);
      On.remove(0);
      for (int neighbours : graph.ConnectedPoints[i])
      {
        if (neighbours!=-1&&States[neighbours]!=-player&&Visited[neighbours]==false)
        {
          Parents[neighbours]=i;
          Visited[neighbours]=true;
        }
      }
    }
    int X=y;
    int steps=0;
    while (Parents[X]!=X)
    {
      X=Parents[X];
      if (States[X]!=player)
        steps++;
    }
    return steps;
  }
  void Change_Distances(int State[], int x, int [] Cost, int player)
  {
    for (int i=0; i<sizeSquare; i++)
    {
      visited[i]=false;
    }
    ArrayList<Integer> radius = new ArrayList<Integer>();
    int parent[]=new int[sizeSquare];
    radius.add(x);
    parent[x]=x;
    visited[x]=true;
    while (!radius.isEmpty())
    {
      int number=radius.get(0);
      radius.remove(0);
      if (State[number]==player) {
        Cost[number]=0;
      } else if (Cost[number]>Cost[parent[number]]) {
        Cost[number]=Cost[parent[number]]+1;
      }
      for (int neigbours : graph.ConnectedPoints[number])
      {
        if (neigbours!=-1&&visited[neigbours]==false&&State[neigbours]!=-player)
        {
          visited[neigbours]=true;
          radius.add(neigbours);
          parent[neigbours]=number;
        }
      }
    }
    for (int i=0; i<sizeSquare; i++)
    {
      if (visited[i]==false)
      {
        Cost[i]=99;
      }
    }
  }
  int MonteCarlo(int []State, int player, int depth)
  {
    int max=-1000;
    int []Copy;
    ArrayList<Integer> numbers=new ArrayList<Integer>();
    int Result[]=new int[sizeSquare];
    int Cost[];
    if (player==-1)Cost=BCost.clone();
    else Cost=ACost.clone();
    for (int i=0; i<sizeSquare; i++)
    {
      Copy=State.clone();
      if (Copy[i]==0&&Cost[i]<=2)
      {
        Copy[i]=player;
        if (depth==0)
        {
          Result[i]=Calculate(Copy);
        } else
        {
          Result[i]=MonteCarlo(Copy, -player, depth-1);
        }
      } else
      {
        Result[i]=-9999;
      }
    }
    int next=-1;
    if (player==-1) { 
      for (int i=0; i<sizeSquare; i++)
      {
        if (Result[i]>=max)
        {
          max=Result[i];
          next=i;
        }
      }
      return next;
    }else{
      max=1000;
      for (int i=0; i<sizeSquare; i++)
      {
        if (Result[i]<=max)
        {
          max=Result[i];
          next=i;
        }
      }
      return next;
    }
  }
}
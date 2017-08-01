class corner
{
  ArrayList<Integer> BlueL= new ArrayList<Integer>(size);
  ArrayList<Integer> GreenL= new ArrayList<Integer>(size);
  ArrayList<Integer> BlueR= new ArrayList<Integer>(size);
  ArrayList<Integer> GreenR= new ArrayList<Integer>(size);
  ArrayList<Integer> GEnd= new ArrayList<Integer>(size);
  ArrayList<Integer> GStart= new ArrayList<Integer>(size);
  ArrayList<Integer> BEnd= new ArrayList<Integer>(size);
  ArrayList<Integer> BStart= new ArrayList<Integer>(size);
  int BL, BR, GL, GR;
  corner()
  {
    BL=-1;
    BR=-1;
    GL=-1;
    GR=-1;
    for (HExagon shape : shapeArr)
    {
      int np=shape.Coordinates;
      int x=np/size;
      int y=np%size;
      if (x==0)GreenR.add(np);
      if (x==size-1)GreenL.add(np);
      if (y==0)BlueL.add(np);
      if (y==size-1)BlueR.add(np);
    }
  }
  void add()
  {
    for (int x : BlueR)
    {
      if (graph.State[x]==-1&&!BEnd.contains(x))
      {
        BEnd.add(x);
      }
    }
    for (int x : BlueL)
    {
      if (graph.State[x]==-1&&!BStart.contains(x))
      {
        BStart.add(x);
      }
    }
    for (int x : GreenR)
    {
      if (graph.State[x]==1&&!GEnd.contains(x))
      {
        GEnd.add(x);
      }
    }
    for (int x : GreenL)
    {
      if (graph.State[x]==1&&!GStart.contains(x))
      {
        GStart.add(x);
      }
    }
  }
  void Won()
  {
    if (player==1)
    {
      for (int x : GStart) {
        for (int y : GEnd)
        {
          if (graph.Union[x]==graph.Union[y])
          {
            state=2;
            break;
          }
        }
        if (state==2) break;
      }
    }
    if (player==-1)
    {
      for (int x : BStart) {
        for (int y : BEnd)
        {
          if (graph.Union[x]==graph.Union[y])
          {
            state=2;
            break;
          }
        }
        if (state==2) break;
      }
    }
  }
}
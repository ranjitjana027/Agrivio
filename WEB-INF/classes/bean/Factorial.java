package bean;
public class Factorial implements java.io.Serializable{
  int n;
  public int getValue(){
    int prod=1;
    for(int i=2;i<=n;i++){
      prod*=i;
    }
    return prod;
  }
  public void setValue(int n){
    this.n=n;
  }
}

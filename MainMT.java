import java.util.concurrent.ThreadLocalRandom;

public class MainMT {

  Object hello = new Object();
  Object world = new Object();
  static int numT = 32; 

  public static void main(String[] args) throws InterruptedException {
    for(int i=0; i<numT;i++){
      Runnable helloTask = new Runnable(){
        @Override
        public void run(){
          new MainMT().printHello();
        }
      };
      new Thread(helloTask).start();
    }
  }

  public void printHello(){
    synchronized (hello) {
      System.out.println("Hello" + Thread.currentThread().getName());
      System.gc();
      try{
        Thread.sleep(5000);
      } catch(InterruptedException e) {
        /* ignored */
      }
    }
  }
}


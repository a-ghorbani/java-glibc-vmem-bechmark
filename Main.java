public class Main {
  public static void main(String[] args) {
        System.out.println("Hello vMem!");
        System.gc();
        try {
                Thread.sleep(5000);
        } catch(InterruptedException e) {
                /* ignored */
        }
  }
}

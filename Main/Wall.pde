public class Wall {
    int x;
    int y;
    int w;    // widht
    int h;    // height
    boolean isGoal;
    
     public Wall(int x, int y) {
        this.x = x;
        this.y = y;
        w = pixelsPerBlock;
        h = pixelsPerBlock;
        isGoal = false;
    }
}

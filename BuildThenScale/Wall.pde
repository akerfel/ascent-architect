public class Wall {
    int x;
    int y;
    int w;    // widht
    int h;    // height
    
     public Wall(int x, int y) {
        this.x = x;
        this.y = y;
        w = grid.blockLength;
        h = grid.blockLength;
    }
}

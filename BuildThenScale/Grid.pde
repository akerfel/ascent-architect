public class Grid {
    Block[][] grid;
    int w = gridWidth; // width
    int h = gridHeight; // height
    int blockLength; // side length of each block

    public Grid() {
        grid = new Block[w][h];
        blockLength = 32;
        initializeBlocks();
    }

    public void initializeBlocks() {
        for (int x = 0; x < w; x++) {
            for (int y = 0; y < h; y++) {
                boolean isFilled = (y == h - 1);
                grid[x][y] = new Block(isFilled);
            }
        }
    }
}

public class Grid {
    Block[][] grid;
    int w = gridWidth; // width
    int h = gridHeight; // height

    public Grid() {
        grid = new Block[w][h];
        initializeBlocks();
    }

    public void initializeBlocks() {
        for (int x = 0; x < w; x++) {
            for (int y = 0; y < h; y++) {
                boolean isFilled = false;
                if (y == h - 1 || x == 0 ||x == w - 1) {
                    isFilled = true;
                }
                grid[x][y] = new Block(isFilled);
            }
        }
    }
}

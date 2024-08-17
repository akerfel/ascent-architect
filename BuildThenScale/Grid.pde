public class Grid {
    Block[][] grid;
    int w = gridWidth; // width
    int h = gridHeight; // height

    public Grid() {
        grid = new Block[w][h];
        initializeBlocks();
    }

    public void initializeBlocks() {
        
        transferLevelToGrid(level1);
        /*
        for (int x = 0; x < w; x++) {
            for (int y = 0; y < h; y++) {
                boolean isFilled = false;
                if (y == h - 1 || x == 0 ||x == w - 1) {
                    isFilled = true;
                }
                grid[x][y] = new Block(isFilled);
            }
        }
        */
    }
    
    public void transferLevelToGrid(char[][] level) {
        for (int x = 0; x < w; x++) {
            for (int y = 0; y < h; y++) {
                if (level[y][x] == '#') {
                    grid[x][y] = new Block(true);
                }
                else if (level[y][x] == '.') {
                    grid[x][y] = new Block(false);
                }
                else if (level[y][x] == 'G') {
                    grid[x][y] = new Block(false);
                    grid[x][y].setIsGoal(true);
                    grid[x][y].setRgbColor(goalColor);
                }
            }
        }
    }
}

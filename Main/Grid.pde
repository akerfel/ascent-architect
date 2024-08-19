public class Grid {
    Block[][] grid;
    int w = gridWidth; // width
    int h = gridHeight; // height

    public Grid() {
        grid = new Block[w][h];
    }
    
    
    public void startMenuBlocks() {
        for (int x = 0; x < w; x++) {
            for (int y = 0; y < h; y++) {
                grid[x][y] = new Block(true);
                if (y >= h - 5) {
                    grid[x][y].setIsLava(true);   
                }
            }
        }
    }
    
    public void initializeBlocks() {
        for (int x = 0; x < w; x++) {
            for (int y = 0; y < h; y++) {
                boolean isFilled = y > h - lava_initialLevelsBelowPlayer || x == 0 || x == w - 1;
                Block block = new Block(isFilled);
                grid[x][y] = block;
                if (y >= h - lava_currentLevel - 1) {
                    block.setIsLava(true);
                }
            }
        }
    }
    
    public void transferLevelToGrid(char[][] level) {
        for (int x = 0; x < w; x++) {
            for (int y = 0; y < h; y++) {
                if (level[y][x] == 'X') {
                    grid[x][y] = new Block(true);
                }
                else if (level[y][x] == ' ') {
                    grid[x][y] = new Block(false);
                }
                else if (level[y][x] == 'G') {
                    grid[x][y] = new Block(true);
                    grid[x][y].setIsGoal(true);
                    grid[x][y].setRgbColor(goalColor);
                }
            }
        }
    }
}

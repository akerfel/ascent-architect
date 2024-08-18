void updateClimbingGameState() {
    updateWallsAccordingToGrid();
    player.update();
    updateScore();
}

void updateScore() {
    int currentHeight = gridHeight - player.getYinGrid() - 2;
    if (currentHeight > score) {
        score = currentHeight;
        int timeLevel = int(score / decreaseTickTimeAfterScore);
        int possibleNewTickTime = initialtickTime - timeLevel * decreaseIntickTimePerLevel;
        tickTime = max(minimumtickTime, possibleNewTickTime);
        println("New tick time: " + tickTime);
    }
}

void updateWallsAccordingToGrid() {
    walls = new ArrayList<>();
    for (int x = 0; x < grid.w; x++) {
        for (int y = 0; y < grid.h; y++) {
            Block block = grid.grid[x][y];
            if (block.isFilled) {
                Wall wall = new Wall(x * pixelsPerBlock, y * pixelsPerBlock);
                wall.isGoal = block.isGoal;
                walls.add(wall);
            }
        }   
    }
}

void goToNextLevel() {
    player.vy = 0;
    setPlayerToStartPos();
    currentLevelNum++;
    loadCurrentLevel();
}

void setPlayerToStartPos() {
    player.x = playerXstartPos;  
    player.y = playerYstartPos;     
}

void loadCurrentLevel() {
    grid.transferLevelToGrid(levels[currentLevelNum]);
}

void updateClimbingGameState() {
    updateWallsAccordingToGrid();
    player.update();
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
}

void setPlayerToStartPos() {
    player.x = playerXstartPos;  
    player.y = playerYstartPos;     
}

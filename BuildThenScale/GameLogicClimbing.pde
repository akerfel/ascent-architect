void updateClimbingGameState() {
    updateWallsAccordingToGrid();
    player.update();
}

void updateWallsAccordingToGrid() {
    walls = new ArrayList<>();
    for (int x = 0; x < grid.w; x++) {
        for (int y = 0; y < grid.h; y++) {
            if (grid.grid[x][y].isFilled) {
                walls.add(new Wall(x * pixelsPerBlock, y * pixelsPerBlock));
            }
        }   
    }
}

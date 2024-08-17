void drawEverything() {
    background(backgroundColor);
    drawGrid();
    drawHeldPiece();
    if (gameOver) {
        drawGameOver();
    }
    drawPlayer();
}

void drawGrid() {
    //translate((width - grid.blockLength * grid.w)/2, (height - grid.blockLength * grid.h)/2);
    for (int x = 0; x < grid.w; x++) {
        for (int y = 0; y < grid.h; y++) {
            stroke(130, 130, 130);
            noStroke();
            drawBlock(grid.grid[x][y], x, y);
        }
    }
}

void drawBlock(Block block, int x, int y) {
    if (block.isFilled) {
        fill(block.rgbColor);
    }
    else if (block.isGoal) {
        fill(block.rgbColor);
    }
    else {
        fill(gridBackgroundColor);
        rect(x * pixelsPerBlock, y * pixelsPerBlock, pixelsPerBlock, pixelsPerBlock);
    }
    rect(x * pixelsPerBlock, y * pixelsPerBlock, pixelsPerBlock, pixelsPerBlock);
}

void drawHeldPiece() {
    if (heldPiece != null) {
        //translate(width - grid.blockLength * (5 - heldPiece.xOffset), grid.blockLength * 2);
        if (heldPiece instanceof Piece_I) {
            //translate(grid.blockLength, 0);
        }
        for (int i = 0; i < heldPiece.blocks.length; i++) {
            fill(heldPiece.rgbColor);
            rect(heldPiece.blocks[i].x * pixelsPerBlock, heldPiece.blocks[i].y * pixelsPerBlock, pixelsPerBlock, pixelsPerBlock);
        }
        //translate(-(width - grid.blockLength * (3 + heldPiece.xOffset)), -grid.blockLength * 2);
    }
}

void drawGameOver() {
    textSize(40);
    textAlign(CENTER, CENTER);
    fill(200, 0, 0);
    text("GAME OVER", width/2, height/2);
}

void drawPlayer() {
    fill(251, 121, 56);
    rect(player.x, player.y, player.w, player.h);
}

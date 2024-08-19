void drawEverything() {
    background(background1);
    int yTranslate = - (player.y - height + pixelsPerBlock * numBlocksVisibleBelowPlayer);
    translate(0, yTranslate);
    drawGrid();
    drawHeldPiece();
    if (gameOver) {
        drawGameOver();
    }
    drawPlayer();
    translate(0, -yTranslate);
    drawScore();
}

void drawMuteIcon() {
    if (soundIsMuted) {
        image(muteTexture, 0, 0, pixelsPerBlock, pixelsPerBlock);
    }
    else {
        image(unmuteTexture, 0, 0, pixelsPerBlock, pixelsPerBlock);
    }
}

void drawScore() {
    fill(color(255, 255, 255));
    textSize(32);
    text(score, width - 60, 60);
}

void drawGrid() {
    //translate((width - grid.blockLength * grid.w)/2, (height - grid.blockLength * grid.h)/2);
    for (int x = 0; x < grid.w; x++) {
        for (int y = grid.h - 1; y > 0; y--) {
            stroke(130, 130, 130);
            noStroke();
            drawBlock(grid.grid[x][y], x, y);
        }
    }
}

void drawBlock(Block block, int x, int y) {
    int xpos = x * pixelsPerBlock;
    int ypos = y * pixelsPerBlock;
    int w = pixelsPerBlock;
    int h = pixelsPerBlock;
    
    if (block.isFilled) {
        image(activeBlockTexture, xpos, ypos, w, h);
    }
    else if (block.isGoal) {
        fill(block.rgbColor);
        rect(xpos, ypos, w, h);
    }
    else {
        //fill(gridBackgroundColor);
        //rect(xpos, ypos, w, h);
    }
    if (block.isLava) {
        image(lavaGif2, xpos, ypos + pixelsPerBlock/5, w, h);
    }
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
    fill(255, 255, 255);
    textAlign(CENTER);
    text("GAME OVER", width/2, 50);
    fill(0, 200, 0);
    text("Score: " + score, width/2, 100);
    fill(255, 255, 255);
    text("Menu: Space", width/2, 150);
    fill(255, 255, 255);
    text("Highscores:", width/2, 200);
    drawHighScores();
    drawMuteIcon();
}

void drawHighScores() {
    ArrayList<Integer> highscores = getHighscores();
    for (int i = 0; i < highscores.size(); i++) {
        int scoreToPrint = highscores.get(i);
        if (scoreToPrint == score && (i == highscores.size() - 1 || (i < highscores.size() - 1 && highscores.get(i+1) != score))) {
            fill(0, 200, 0);
        } else {
            fill(255, 255, 255);
        }
        text((i+1) + ". " + str(scoreToPrint), width/2, 250 + i * 50);
    }
    rectMode(CORNER);
}

void drawPlayer() {
    lerpAmount += lerpSpeed;

    if (lerpAmount > 1) {
        lerpAmount = 0;
        color temp = startColor;
        startColor = endColor;
        endColor = temp;
    }

    color currentColor = lerpColor(startColor, endColor, lerpAmount);

    fill(currentColor);

    stroke(0);
    strokeWeight(1);

    rect(player.x, player.y - 1, player.w, player.h);
}

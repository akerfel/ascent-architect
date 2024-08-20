class StartMenu {
    Button EasyButton;
    Button MediumButton;
    Button HardButton;

    StartMenu() {
        EasyButton = new Button("Easy", width / 2, 200);
        MediumButton = new Button("Medium", width / 2, 300);
        HardButton = new Button("Hard", width / 2, 400);
    }

    void display() {
    background(background1);
    fill(255);
    textSize(55);
    textAlign(CENTER, CENTER);
    text(gameTitle, width / 2, 100);

    EasyButton.display();
    MediumButton.display();
    HardButton.display();
    drawMuteIcon();

    textSize(18);
    textAlign(CENTER, TOP);
    fill(255);

    float instructionsY = HardButton.y + HardButton.height / 2 + 45;
    String[] instructions = {
        "Instructions","Evade the rising lava by building and climbing.",
        "Don't crush the Climber.",
        "1-Player mode: You are both the Builder and the Climber.",
        "2-Player mode: One is the Builder, the other the Climber.",
    };

    float maxWidth = 0;
    for (String instruction : instructions) {
        float w = textWidth(instruction);
        if (w > maxWidth) {
            maxWidth = w;
        }
    }
    
    float boxWidth = maxWidth + 30;
    float boxHeight = instructions.length * 35 + 12;

    // Box
    stroke(255);
    noFill();
    rectMode(CENTER);
    rect(width / 2 + 1, instructionsY + boxHeight / 2, boxWidth, boxHeight);
    rectMode(CORNER);
    
    // Draw the instructions text
    fill(255);
    for (int i = 0; i < instructions.length; i++) {
        float textY = instructionsY + i * 35 + 10;
        text(instructions[i], width / 2, textY);

        // Draw a line right below "Instructions"
        if (i == 0) {
            stroke(255);
            line(width / 2 - boxWidth / 2 + 10, textY + 25, width / 2 + boxWidth / 2 - 10, textY + 25);
        }
    }

    // Display the controlsTexture at the bottom
    if (controlsTexture != null) {
        float imgWidth = controlsTexture.width;
        float imgHeight = controlsTexture.height;
        imageMode(CENTER);
        image(controlsTexture, width / 2, height - imgHeight * 0.65, imgWidth, imgHeight);
        imageMode(CORNER);
    }
}

    void handleMousePressed() {
        if (EasyButton.isClicked(mouseX, mouseY)) {
            gameState = GameState.GAMEACTIVE;
            difficulty = Difficulty.EASY;
            setLavaTickTimeDependingOnDifficulty();
        } else if (MediumButton.isClicked(mouseX, mouseY)) {
            difficulty = Difficulty.MEDIUM;
            gameState = GameState.GAMEACTIVE;
            setLavaTickTimeDependingOnDifficulty();
        } else if (HardButton.isClicked(mouseX, mouseY)) {
            difficulty = Difficulty.HARD;
            gameState = GameState.GAMEACTIVE;
            setLavaTickTimeDependingOnDifficulty();
        }
    }
}

class Button {
    String label;
    float x, y;
    float width = 200;
    float height = 50;

    Button(String label, float x, float y) {
        this.label = label;
        this.x = x;
        this.y = y;
    }

    void display() {
        fill(255);
        rectMode(CENTER);
        rect(x, y, width, height, 10);
        fill(0);
        textSize(24);
        textAlign(CENTER, CENTER);
        text(label, x, y);
        rectMode(CORNER);
        textAlign(CORNER);
    }

    boolean isClicked(float mouseX, float mouseY) {
        return mouseX > x - width / 2 && mouseX < x + width / 2 &&
               mouseY > y - height / 2 && mouseY < y + height / 2;
    }
}

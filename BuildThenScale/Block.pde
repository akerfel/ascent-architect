public class Block {
    boolean isFilled;
    boolean isLava;
    color rgbColor;
    boolean isGoal;

    public Block(boolean isFilled) {
        this.isFilled = isFilled;
        this.rgbColor = color(19,133,16);
        isLava = false;
    }
    
    void setIsGoal(boolean isGoal) {
        this.isGoal = isGoal;    
    }
    
    void setIsLava(boolean isLava) {
        this.isLava = isLava;    
    }
    
    void setRgbColor(color rgbColor) {
        this.rgbColor = rgbColor;
    }
}

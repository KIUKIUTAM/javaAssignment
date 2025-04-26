package enums;

/**
 *
 * @author Vincent
 */
public enum  LoginType {
    BAKERY("bakery",1),
    WAREHOUSE("warehouse",2),
    MANAGEMENT("management",3);
    
    
    private final String displayName;
    private final int level;
    
    LoginType(String displayName, int level){
        this.displayName = displayName;
        this.level = level;
    }
    
    public String getDisplayName() {
        return displayName;
    }
    
    public int getLevel() {
        return level;
    }
    
}

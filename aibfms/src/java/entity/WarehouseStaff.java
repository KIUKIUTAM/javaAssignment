package entity;

public class WarehouseStaff {
    private int id;
    private String userId;
    private String name;
    private String password;

    public WarehouseStaff() {}

    public WarehouseStaff(int id, String userId, String name, String password) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}

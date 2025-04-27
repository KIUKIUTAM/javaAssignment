package entity;

public class Fruit {
    private int id;
    private String fruitName;
    private int shelfLife;
    private String cityName;
    private float usaWarehouseDistance;
    private float japanWarehouseDistance;
    private float hkWarehouseDistance;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFruitName() {
        return fruitName;
    }

    public void setFruitName(String fruitName) {
        this.fruitName = fruitName;
    }

    public int getShelfLife() {
        return shelfLife;
    }

    public void setShelfLife(int shelfLife) {
        this.shelfLife = shelfLife;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public float getUsaWarehouseDistance() {
        return usaWarehouseDistance;
    }

    public void setUsaWarehouseDistance(float usaWarehouseDistance) {
        this.usaWarehouseDistance = usaWarehouseDistance;
    }

    public float getJapanWarehouseDistance() {
        return japanWarehouseDistance;
    }

    public void setJapanWarehouseDistance(float japanWarehouseDistance) {
        this.japanWarehouseDistance = japanWarehouseDistance;
    }

    public float getHkWarehouseDistance() {
        return hkWarehouseDistance;
    }

    public void setHkWarehouseDistance(float hkWarehouseDistance) {
        this.hkWarehouseDistance = hkWarehouseDistance;
    }

    // getters and setters
}
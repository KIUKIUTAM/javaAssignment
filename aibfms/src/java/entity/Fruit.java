package entity;

public class Fruit {
    private int id;
    private String fruitName;
    private int shelfLife;
    private int cityId;

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

    public int getCityId() {
        return cityId;
    }

    public void setCityId(int city) {
        this.cityId = city;
    }

    // getters and setters
}
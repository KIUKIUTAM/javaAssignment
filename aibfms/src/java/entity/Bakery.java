package entity;

public class Bakery {
    int id;
    String name;
    String location;
    int cityId;

    public Bakery(int id, String name, String location, int cityId) {
        this.id = id;
        this.name = name;
        this.location = location;
        this.cityId = cityId;
    }

    public Bakery() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = (name != null) ? name : this.name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = (location != null) ? location : this.location;
    }

    public int getCityId() {
        return cityId;
    }

    public void setCityId(int cityId) {
        this.cityId = cityId;
    }
}

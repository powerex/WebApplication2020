package model;

public class Subject {
    private int id;
    private String title;
    private String lecturer;
    private int credits;

    public Subject() {
    }

    public Subject(int id, String title, String lecturer, int credits) {
        this.id = id;
        this.title = title;
        this.lecturer = lecturer;
        this.credits = credits;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLecturer() {
        return lecturer;
    }

    public void setLecturer(String lecturer) {
        this.lecturer = lecturer;
    }

    public int getCredits() {
        return credits;
    }

    public void setCredits(int credits) {
        this.credits = credits;
    }
}

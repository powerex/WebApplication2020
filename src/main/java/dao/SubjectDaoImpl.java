package dao;

import db.ConnectionFactory;
import model.Subject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SubjectDaoImpl implements SubjectDao {
    @Override
    public List<Subject> listSubjects() {

        List<Subject> list = new ArrayList<>();
        ResultSet resultSet;

        try (Connection connection = ConnectionFactory.getConnection()) {
            resultSet = connection.createStatement().executeQuery("select a.id, a.title, l.name, l.surname ,a.credits from subjects a inner join lecturers l on l.id = a.lecturer_id order by id");
            while (resultSet.next()) {
                Subject subject = new Subject();
                subject.setId(resultSet.getInt("id"));
                subject.setCredits(resultSet.getInt("credits"));
                subject.setTitle(resultSet.getString("title"));
                String lecturer =
                        resultSet.getString("name") + " " +
                                resultSet.getString("surname");
                subject.setLecturer(lecturer);
                list.add(subject);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return list;
    }

    @Override
    public void saveSubject(Subject subject) {
//        try (Connection connection = ConnectionFactory.getConnection()) {
//            PreparedStatement pst;
//            pst = connection.prepareStatement("insert into subjects(title, lecturer, credits) values (?,?,?)");
//            pst.setString(1, subject.getTitle());
//            pst.setString(2, subject.getLecturer());
//            pst.setInt(3, subject.getCredits());
//            pst.executeUpdate();
//        } catch (SQLException throwables) {
//            throwables.printStackTrace();
//        }
    }
}

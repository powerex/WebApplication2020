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

        Connection connection = ConnectionFactory.getConnection();

        PreparedStatement pst;
        ResultSet resultSet;

        try {
            connection = ConnectionFactory.getConnection();
            resultSet = connection.createStatement().executeQuery("select * from subjects order by id");

            while (resultSet.next()) {
                Subject subject = new Subject();
                subject.setId(resultSet.getInt("id"));
                subject.setCredits(resultSet.getInt("credits"));
                subject.setTitle(resultSet.getString("title"));
                subject.setLecturer(resultSet.getString("lecturer"));
                list.add(subject);
            }

            connection.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return list;
    }

    @Override
    public void saveSubject(Subject subject) {

    }
}

package dao;

import model.Subject;

import java.util.List;

public interface SubjectDao {
    List<Subject> listSubjects();
    void saveSubject(Subject subject);
}

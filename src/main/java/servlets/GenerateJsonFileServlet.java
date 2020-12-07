package servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.SubjectDao;
import dao.SubjectDaoImpl;
import model.Subject;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.List;

public class GenerateJsonFileServlet extends HttpServlet {

    private final int ARBITARY_SIZE = 1048;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SubjectDao subjectDao = new SubjectDaoImpl();
        List<Subject> subjectList = subjectDao.listSubjects();
        ObjectMapper objectMapper = new ObjectMapper();
        String json = "";
        try {
            json = objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(subjectList);
            System.out.println(json);
        } catch(Exception e) {
            e.printStackTrace();
        }

        resp.setContentType("text/plain");
        resp.setHeader("Content-disposition", "attachment; filename=report.json");

        try(InputStream targetStream = new ByteArrayInputStream(json.getBytes(StandardCharsets.UTF_8));
            OutputStream out = resp.getOutputStream()) {

            byte[] buffer = new byte[ARBITARY_SIZE];

            int numBytesRead;
            while ((numBytesRead = targetStream.read(buffer)) > 0) {
                out.write(buffer, 0, numBytesRead);
            }
        }

        resp.sendRedirect("/courses");
    }
}

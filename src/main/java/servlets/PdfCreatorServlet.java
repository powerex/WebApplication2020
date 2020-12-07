package servlets;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import dao.SubjectDao;
import dao.SubjectDaoImpl;
import model.Subject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

public class PdfCreatorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Document doc = new Document();
        try {
            PdfWriter pdfWriter = PdfWriter.getInstance(doc, baos);
            doc.open();

            PdfPTable table = new PdfPTable(3);
            table.setWidthPercentage(100);
            table.setSpacingBefore(10f);
            table.setSpacingAfter(10f);

            float[] columnWidths = {3f, 3f, 1f};
            table.setWidths(columnWidths);

            SubjectDao subjectDao = new SubjectDaoImpl();
            List<Subject> subjectList = subjectDao.listSubjects();

            String fontName = "/fonts/Autoproject.ttf";
            BaseFont bf = BaseFont.createFont(fontName, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
            Font f = new Font(bf, 12);

            for (Subject s: subjectList) {

                Paragraph paragraph1 = new Paragraph(s.getTitle(), f);
                PdfPCell cell1 = new PdfPCell(paragraph1);
                cell1.setBorderColor(BaseColor.BLACK);
                cell1.setPaddingLeft(10);
                cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);

                Paragraph paragraph2 = new Paragraph(s.getLecturer(), f);
                PdfPCell cell2 = new PdfPCell(paragraph2);
                cell1.setBorderColor(BaseColor.BLACK);
                cell2.setPaddingLeft(10);
                cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell2.setVerticalAlignment(Element.ALIGN_MIDDLE);

                Paragraph paragraph3 = new Paragraph(String.valueOf(s.getCredits()), f);
                PdfPCell cell3 = new PdfPCell(paragraph3);
                cell1.setBorderColor(BaseColor.BLACK);
                cell3.setPaddingLeft(10);
                cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell3.setVerticalAlignment(Element.ALIGN_MIDDLE);

                table.addCell(cell1);
                table.addCell(cell2);
                table.addCell(cell3);
            }

            doc.add(table);
            doc.close();
            pdfWriter.close();
        } catch (DocumentException e) {
            e.printStackTrace();
        }

        resp.setHeader("Expires", "0");
        resp.setHeader("Cache-Control",
                "must-revalidate, post-check=0, pre-check=0");
        resp.setHeader("Pragma", "public");
        resp.setContentType("application/pdf");
        resp.setContentLength(baos.size());
        OutputStream os = resp.getOutputStream();
        baos.writeTo(os);
        os.flush();
        os.close();

    }
}

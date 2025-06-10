package com.tugas.perpus.api;

import com.tugas.perpus.controller.TransactionController;
import com.tugas.perpus.model.Transaction;
import com.tugas.perpus.model.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.List;
import java.lang.reflect.Type;

@WebServlet(name = "TransactionApiServlet", urlPatterns = {"/api/transactions", "/api/transactions/pagination"})
public class TransactionApiServlet extends HttpServlet {
    private static final JsonSerializer<LocalDate> localDateSerializer = (src, typeOfSrc, context) ->
        src == null ? null : new JsonPrimitive(src.toString());
    private static final JsonDeserializer<LocalDate> localDateDeserializer = (json, typeOfT, context) ->
        json == null ? null : LocalDate.parse(json.getAsString());

    private final Gson gson = new GsonBuilder()
        .registerTypeAdapter(LocalDate.class, localDateSerializer)
        .registerTypeAdapter(LocalDate.class, localDateDeserializer)
        .create();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;
        TransactionController controller = (TransactionController) (session != null ? session.getAttribute("transactionController") : null);
        if (controller == null) {
            controller = new TransactionController();
            if (session != null) session.setAttribute("transactionController", controller);
        }

        String path = request.getServletPath();
        PrintWriter out = response.getWriter();
        if ("/api/transactions/pagination".equals(path)) {
            // Pagination version
            int page = 1;
            int size = 10;
            try {
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }
                if (request.getParameter("size") != null) {
                    size = Integer.parseInt(request.getParameter("size"));
                }
            } catch (NumberFormatException ignored) {}
            List<Transaction> all = controller.getTransactionsFromDatabase(user);
            int total = all.size();
            int fromIndex = Math.max(0, (page - 1) * size);
            int toIndex = Math.min(fromIndex + size, total);
            List<Transaction> paged = all.subList(fromIndex, toIndex);
            out.print(gson.toJson(new PaginatedResult(paged, page, size, total)));
        } else {
            // Non-pagination version
            List<Transaction> transactions = controller.getTransactionsFromDatabase(user);
            out.print(gson.toJson(transactions));
        }
        out.flush();
    }

    static class PaginatedResult {
        List<Transaction> data;
        int page;
        int size;
        int total;
        PaginatedResult(List<Transaction> data, int page, int size, int total) {
            this.data = data;
            this.page = page;
            this.size = size;
            this.total = total;
        }
    }
}

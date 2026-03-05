package filter;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import model.User;

@WebFilter(urlPatterns = { "/admin/*", "/cart", "/checkout", "/profile" })
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        String path = req.getServletPath();

        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Admin-only protection
        if (path.startsWith("/admin") && !"admin".equals(user.getRole())) {
            res.sendRedirect(req.getContextPath() + "/access-denied");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig fc) {
    }

    @Override
    public void destroy() {
    }
}

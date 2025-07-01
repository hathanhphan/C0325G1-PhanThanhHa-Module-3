package org.example.productmanagement.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

@WebFilter("/*")
public class CharacterEncodingFilter implements Filter {
    private static final String ENCODING = "UTF-8";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException { }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        req.setCharacterEncoding(ENCODING);
        res.setCharacterEncoding(ENCODING);
        res.setContentType("text/html; charset=" + ENCODING);
        chain.doFilter(req, res);
    }

    @Override
    public void destroy() { }
}

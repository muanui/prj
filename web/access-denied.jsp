<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% String cp=request.getContextPath(); %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8" />
            <title>Truy cập bị từ chối - BookApp</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <link rel="stylesheet" href="<%= cp %>/css/style.css" />
        </head>

        <body>
            <div class="container text-center" style="padding:6rem 0">
                <div style="font-size:5rem">&#127758;</div>
                <h1 style="font-size:4rem;color:var(--danger);font-weight:900;">403</h1>
                <p style="font-size:1.2rem;color:var(--muted);margin:1rem 0">Bạn không có quyền truy cập trang này.</p>
                <a href="<%= cp %>/home" class="btn btn-primary">&#8592; Về trang chủ</a>
            </div>
        </body>

        </html>
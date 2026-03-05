// BookApp - Main JavaScript

// ===== Cart quantity controls =====
function changeQty(cartId, delta) {
    const input = document.getElementById('qty_' + cartId);
    if (!input) return;
    let val = parseInt(input.value) + delta;
    if (val < 1) val = 1;
    input.value = val;
}

// ===== Format currency (VND) =====
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
}

// ===== Confirm delete =====
function confirmDelete(msg) {
    return confirm(msg || 'Bạn có chắc muốn xóa?');
}

// ===== Auto-hide alerts =====
document.addEventListener('DOMContentLoaded', function () {
    const alerts = document.querySelectorAll('.alert.auto-hide');
    alerts.forEach(function (alert) {
        setTimeout(function () {
            alert.style.transition = 'opacity 0.5s';
            alert.style.opacity = '0';
            setTimeout(() => alert.remove(), 500);
        }, 3500);
    });

    // Smooth scroll
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) target.scrollIntoView({ behavior: 'smooth' });
        });
    });
});

// ===== Book cover color generator (by title) =====
function getBookGradient(title) {
    const gradients = [
        'linear-gradient(135deg,#667eea,#764ba2)',
        'linear-gradient(135deg,#f76b1c,#fad961)',
        'linear-gradient(135deg,#0f3460,#e94560)',
        'linear-gradient(135deg,#11998e,#38ef7d)',
        'linear-gradient(135deg,#fc5c7d,#6a3093)',
        'linear-gradient(135deg,#4568dc,#b06ab3)',
        'linear-gradient(135deg,#c94b4b,#4b134f)',
        'linear-gradient(135deg,#2193b0,#6dd5ed)',
    ];
    let hash = 0;
    for (let i = 0; i < (title||'').length; i++) hash = (hash << 5) - hash + title.charCodeAt(i);
    return gradients[Math.abs(hash) % gradients.length];
}

// Apply gradients to all cover placeholders
document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.book-cover-placeholder').forEach(el => {
        const title = el.dataset.title || '';
        el.style.background = getBookGradient(title);
    });
});
